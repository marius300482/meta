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
        return new RecordDriver\SolrLibrary(
            $sm->getServiceLocator()->get('VuFind\Config')->get('config'),
            null,
            $sm->getServiceLocator()->get('VuFind\Config')->get('searches')
        );
    }
}