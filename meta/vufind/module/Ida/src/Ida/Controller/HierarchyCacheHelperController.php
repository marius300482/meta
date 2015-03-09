<?php
/**
 * Created by IntelliJ IDEA.
 * User: boehm
 * Date: 05.02.15
 * Time: 17:42
 */

namespace Ida\Controller;


use VuFind\Controller\AbstractBase;
use \Zend\Config\Config;
use Ida\Hierarchy\CacheHelper;

class HierarchyCacheHelperController extends AbstractBase {
    public function  __construct($hierarchydriver, $mainConfig = null)
    {
        $this->cacheHelper=new CacheHelper($hierarchydriver);
        $this->config = $mainConfig;
    }

    public function deleteAction()
    {
        $url = explode('?', $this->getServerUrl());
        $institution=$url[1];
        $this->cacheHelper->delete($institution);
    }
} 