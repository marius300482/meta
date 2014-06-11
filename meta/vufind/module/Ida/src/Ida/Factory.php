<?php

namespace Ida;

use Zend\ServiceManager\ServiceManager;

class Factory
{


    /**
     * Factory for SolrLibary record driver.
     *
     * @param ServiceManager $sm Service manager.
     *
     * @return SolrLibary
     */
    public static function getSolrLibrary(ServiceManager $sm)
    {
        $serviceLocator = $sm->getServiceLocator();

        return new RecordDriver\SolrLibrary(
            $serviceLocator->get('VuFind\Config')->get('config'),
            null,
            $serviceLocator->get('VuFind\Config')->get('searches')
        );
    }
}