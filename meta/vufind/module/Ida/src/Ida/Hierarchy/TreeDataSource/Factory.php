<?php
/**
 * Hierarchy Data Source Factory Class
 *
 */
namespace Ida\Hierarchy\TreeDataSource;
use Zend\ServiceManager\ServiceManager;

/**
 * Hierarchy Data Source Factory Class
 *
 * This is a factory class to build objects for managing hierarchies
 * and is an exact copy of the corresponding file in the VuFind module.
 *
 */
class Factory
{
    /**
     * Factory for Solr driver.
     *
     * @param ServiceManager $sm Service manager.
     *
     * @return Solr
     */
    public static function getSolr(ServiceManager $sm)
    {
        $cacheDir = $sm->getServiceLocator()->get('VuFind\CacheManager')
            ->getCacheDir(false);
        $hierarchyFilters = $sm->getServiceLocator()->get('VuFind\Config')
            ->get('HierarchyDefault');
        $filters = isset($hierarchyFilters->HierarchyTree->filterQueries)
            ? $hierarchyFilters->HierarchyTree->filterQueries->toArray()
            : array();

        // Instance of Ida\Hierarchy\TreeDataSource\Solr class
        return new Solr(
            $sm->getServiceLocator()->get('VuFind\Search'),
            rtrim($cacheDir, '/') . '/hierarchy',
            $filters
        );
    }
}