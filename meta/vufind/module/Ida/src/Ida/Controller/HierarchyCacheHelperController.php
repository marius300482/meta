<?php
/**
 * Created by IntelliJ IDEA.
 * User: boehm
 * Date: 05.02.15
 * Time: 17:42
 */

namespace Ida\Controller;


use Ida\Hierarchy\CacheHelper;use VuFind\Controller\AbstractBase;

class HierarchyCacheHelperController extends AbstractBase {
    public function  __construct($mainConfig, $pluginManager, $cacheDir)
    {
        $this->config = $mainConfig;
        $this->hierarchyType = $this->config->Hierarchy->driver;
        $hierarchyDriver=$pluginManager->get($this->hierarchyType);
        $this->cacheHelper=new CacheHelper($hierarchyDriver, $cacheDir);
    }

        /**
     * Get a hierarchy driver appropriate to the current object.  (May be false if
     * disabled/unavailable).
     *
     * @return \VuFind\Hierarchy\Driver\AbstractBase|bool
     */
    public function getHierarchyDriver()
    {
        if (null === $this->hierarchyDriver
            && null !== $this->hierarchyDriverManager
        ) {
            $type = $this->hierarchyType;
            $this->hierarchyDriver = $type
                ? $this->hierarchyDriverManager->get($type) : false;
        }
        return $this->hierarchyDriver;
    }

    /**
     * Inject a hierarchy driver plugin manager.
     *
     * @param \VuFind\Hierarchy\Driver\PluginManager $pm Hierarchy driver manager
     *
     * @return SolrDefault
     */
    public function setHierarchyDriverManager(
        \VuFind\Hierarchy\Driver\PluginManager $pm
    ) {
        $this->hierarchyDriverManager = $pm;
        return $this;
    }


    public function deleteAction()
    {

        $url =  parse_url($this->getServerUrl());
        $query = $url['query'];
        parse_str($query, $parsed);
        $institution = $parsed["institution"];
        $deleted = $this->cacheHelper->delete($institution);

        $view = $this->createViewModel();
        $view->setTemplate('hierarchy/deleteResult');
        $view->deleted = $deleted;

        return $view;
    }
} 