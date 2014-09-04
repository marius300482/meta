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

        return $html;
    }
}