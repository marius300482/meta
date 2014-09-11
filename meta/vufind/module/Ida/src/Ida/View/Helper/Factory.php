<?php
/**
 * Factory for view helpers.
 *
 * @package  View_Helpers
 * @author   dkuom <dku@outermedia.de>
 */
namespace Ida\View\Helper;
use Zend\ServiceManager\ServiceManager;

/**
 * Factory for Genderbib view helpers.
 *
 * @package  View_Helpers
 * @author   dkuom <dku@outermedia.de>
 */
class Factory {

    /**
     * Construct the Piwik Analytics helper.
     *
     * @param ServiceManager $sm Service manager.
     *
     * @return PiwikAnalytics
     */
    public static function getPiwikAnalytics(ServiceManager $sm) {

        // Read config file
        $config = $sm->getServiceLocator()->get('VuFind\Config')->get('config');

        $trackerURL = $siteId = null;

        // Piwik config exists?
        if (isset($config->Piwik->trackerURL)) {
            $trackerURL = $config->Piwik->trackerURL;
        }

        if (isset($config->Piwik->siteId)) {
            $siteId = $config->Piwik->siteId;
        }

        return new PiwikAnalytics($trackerURL, $siteId);
    }
}