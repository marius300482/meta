<?php

namespace Ida;

use Ida\Controller\TopicsController;use Zend\ServiceManager\ServiceManager;

class Factory
{
    public static function getTopicsController(ServiceManager $sm)
    {
        return new TopicsController(
            $sm->getServiceLocator()->get('VuFind\Config')->get('config')
        );
    }

    /**
     * Factory for SolrLibrary record driver.
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

    public static function getSolrArchive(ServiceManager $sm)
    {
        $serviceLocator = $sm->getServiceLocator();

        return new RecordDriver\SolrArchive(
            $serviceLocator->get('VuFind\Config')->get('config'),
            null,
            $serviceLocator->get('VuFind\Config')->get('searches')
        );
    }

    public static function getSolrSystematics(ServiceManager $sm)
    {
        $serviceLocator = $sm->getServiceLocator();

        return new RecordDriver\SolrSystematics(
            $serviceLocator->get('VuFind\Config')->get('config'),
            null,
            $serviceLocator->get('VuFind\Config')->get('searches')
        );
    }
}