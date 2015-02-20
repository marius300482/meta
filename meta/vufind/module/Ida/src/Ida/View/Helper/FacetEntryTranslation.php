<?php
/**
 * Piwik Analytics view helper
 *
 * @package  View_Helpers
 * @author   dkuom <dku@outermedia.de>
 */
namespace Ida\View\Helper;

/**
 * Piwik Analytics view helper
 *
 * @package  View_Helpers
 * @author   dkuom <dku@outermedia.de>
 */
class FacetEntryTranslation extends \Zend\View\Helper\AbstractHelper {


    /**
     * Constructor
     *
     * @param string $trackerURL Piwik tracking tracker url (null if disabled)
     * @param int $siteId Piwik tracking site id (null if disabled)
     */
    public function __construct() {

    }

    /**
     * Returns PA code (if correctly set up) or empty string if not.
     *
     * @return string
     */
    public function __invoke($entry) {

        $escaper = $this->getView()->plugin('escapeHtml');

        return $escaper($entry);
    }
}