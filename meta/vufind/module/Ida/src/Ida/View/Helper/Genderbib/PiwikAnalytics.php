<?php
/**
 * Piwik Analytics view helper
 *
 * @package  View_Helpers
 * @author   dkuom <dku@outermedia.de>
 */
namespace Ida\View\Helper\Genderbib;

/**
 * Piwik Analytics view helper
 *
 * @package  View_Helpers
 * @author   dkuom <dku@outermedia.de>
 */
class PiwikAnalytics extends \Zend\View\Helper\AbstractHelper {

    /**
     * Piwik site id
     *
     * @var int
     */
    protected $_siteId;

    /**
     * Piwik tracker url (e.g. http(s)://www.my-tracking-server.de/piwik/)
     *
     * @var string
     */
    protected $_trackerURL;

    /**
     * Constructor
     *
     * @param string $trackerURL Piwik tracking tracker url (null if disabled)
     * @param int $siteId Piwik tracking site id (null if disabled)
     */
    public function __construct($trackerURL, $siteId) {

        if (0 < strlen($trackerURL)) {
            $this->_trackerURL = $trackerURL;
        }

        if (is_numeric($siteId) && 0 < (int) $siteId) {
            $this->_siteId = $siteId;
        }
    }

    /**
     * Returns PA code (if correctly set up) or empty string if not.
     *
     * @return string
     */
    public function __invoke() {

        if (null === $this->_trackerURL || null === $this->_siteId) {
            return 'NOPE';
        }

        $html = '';

        // Assemble tracking code
        $javascript = <<<PIWIK
var _paq = _paq || [];
_paq.push(['trackPageView']);
_paq.push(['enableLinkTracking']);
(function() {
    var u=(("https:" == document.location.protocol) ? "https" : "http") + "://$this->_trackerURL";
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', $this->_siteId]);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript';
    g.defer=true; g.async=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
})();
PIWIK;

        // Add <script> tags
        $inlineScript = $this->getView()->plugin('inlinescript');
        $html .= '<!-- Piwik -->';
        $html .= $inlineScript(\Zend\View\Helper\HeadScript::SCRIPT, $javascript, 'SET');

        // Append <noscript> part
        $html .= <<<NOSCRIPT
<noscript>
<p>
    <img src="http://{$this->_trackerURL}piwik.php?idsite={$this->_siteId}" style="border:0;" alt="" />
</p>
</noscript>
NOSCRIPT;
        $html .= '<!-- End Piwik Code -->';

        $javascript = <<<TRACKING
(function ($) {

    function trackSearch(keywrd, c, results) {

        if (!$.isArray(c)) {
            c = ('string' === typeof c) ? [c] : [];
        }

       _paq.push(['trackSiteSearch', keywrd, c.sort().join(' '), results]);
    }

    function trackEvent(c, a, n) {
        _paq.push(['trackEvent', c, a, n]);
    }

    /**
     * @see http://james.padolsey.com/javascript/parsing-urls-with-the-dom/
     */
    function _parse(url) {
        var a = document.createElement('a');
        a.href = url;
        return {
            source: url,
            protocol: a.protocol.replace(':', ''),
            host: a.hostname,
            port: a.port,
            query: a.search,
            params: (function () {
                var ret = {},
                    seg = a.search.replace(/^\?/, '').split('&'),
                    len = seg.length, i = 0, s;
                for (; i < len; i++) {
                    if (!seg[i]) {
                        continue;
                    }
                    s = seg[i].split('=');
                    ret[s[0]] = s[1];
                }
                return ret;
            })(),
            file: (a.pathname.match(/\/([^\/?#]+)$/i) || [, ''])[1],
            hash: a.hash.replace('#', ''),
            path: a.pathname.replace(/^([^\/])/, '/$1'),
            relative: (a.href.match(/tps?:\/\/[^\/]+(.+)/) || [, ''])[1],
            segments: a.pathname.replace(/^\//, '').split('/')
        };
    }

    $(function () {

        // Track site search
        var url = _parse(window.location);

        if (-1 !== url.path.indexOf('Search/Results')) {

            var query = decodeURIComponent(url.params.lookfor),
                category = [],
                resultsStr = $('.resulthead .floatleft').text(),
                results = false;

            // Collect facets
            $('.sidegroup')
                .find('.narrowList dd.applied')
                .each(function (idx, elem) {
                    category.push($(elem).prev().text());
                });

            // Results count
            if ('string' === typeof resultsStr && resultsStr.match(/von ([0-9]+)/)) {
                results = 1 * RegExp.$1;
            }

            trackSearch(query, category, results);
        }

        // Perform advanced search
        $('#advSearchForm')
            .find('input[type="submit"]')
            .click(function (e) {
                trackEvent('Erweiterte Suche', 'Formular abgeschickt');
            });

        // Open advanced search form
        $('.searchform a.advancedSearch, .footer > .span-5 ul li:last-child a').click(function (e) {
            trackEvent('Erweiterte Suche');
        });

        // Tags
        $('.authorbox')
            // "Similar tags"
            .find('.span-5 a')
            .click(function (e) {

                var tag = $(this).text(),
                    tagsAdditional = 1 === $(this).parents('#narrowGroupHidden_topic_facet').length;

                if ('string' === typeof tag) {

                    if (true === tagsAdditional) {
                        trackEvent('Facette', 'Facette: Schlagwort (weitere)', 'Wert: ' + tag);
                    }
                    else {
                        trackEvent('Facette', 'Facette: Schlagwort', 'Wert: ' + tag);
                    }
                }
            })
            .end()
            // "More tags"
            .find('#moretopic_facet')
            .click(function (e) {
                trackEvent('Weitere Schlagwörter anzeigen', 'Auf');
            });

        // Facets
        $('.sidegroup')
            .find('dl.navmenu a[class^=facet]')
            .click(function (e) {

                var facet = $(this).parents('dl').find('dt').text(),
                    facetValue = $(this).text();

                if ('string' === typeof facet && 'string' === typeof facetValue) {
                    trackEvent('Facette', 'Facette: ' + facet, 'Wert: ' + facetValue);
                }
            });

        // Pagination
        $('.pagination')
            .find('a')
            .click(function (e) {

                var pageURL = $(this).attr('href'),
                    pageURLParsed = _parse(pageURL),
                    pageId = pageURLParsed.params.page;

                if ('string' !== typeof pageId || 0 === pageId.length) {
                    pageId = '1';
                }

                trackEvent('Suchseite blättern', 'Seite ' + pageId);
            });

        // Search result list items
        $('ul.recordSet')
            .find('.span-2 a, .span-9 .resultItemLine1 a')
            .click(function (e) {

                var listItem = $(this).parents('li.result'),
                    resultId = listItem.find('.recordNumber').text();

                if (0 < resultId.length) {
                     trackEvent('Suchergebnis klicken', 'Position ' + resultId);
                }
            });
    });
}) (jQuery);
TRACKING;

        $html .= '<!-- IDA search event tracking -->';
        $html .= $inlineScript(\Zend\View\Helper\HeadScript::SCRIPT, $javascript, 'SET');
        $html .= '<!-- End IDA search event tracking -->';

        return $html;
    }
}