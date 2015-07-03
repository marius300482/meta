<?php
/**
 * Factory for Root view helpers.
 *
 * @category Ida
 * @package  View_Helpers
 * @author   <dku@outermedia.de>
 */
namespace Ida\View\Helper\Root;

use Zend\ServiceManager\ServiceManager;

/**
 * Factory for Root view helpers.
 *
 * @category Ida
 * @package  View_Helpers
 * @author   <dku@outermedia.de>
 */
class Factory {

    /**
     * Construct the Record helper.
     *
     * @param ServiceManager $sm Service manager.
     *
     * @return Record
     */
    public static function getRecord(ServiceManager $sm) {

        return new Record(
            $sm->getServiceLocator()->get('VuFind\Config')->get('config')
        );
    }
}
