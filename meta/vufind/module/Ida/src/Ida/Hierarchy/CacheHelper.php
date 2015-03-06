<?php
/**
 * Created by IntelliJ IDEA.
 * User: boehm
 * Date: 12.02.15
 * Time: 11:33
 */

namespace Ida\Hierarchy;


use VuFind\Hierarchy\TreeDataSource\XMLFile;

class CacheHelper extends XMLFile {


    function __construct($hierarchyDriver)
    {
        $this->setHierarchyDriver($hierarchyDriver);
    }

    public function delete($institution)
    {
        $basePath=$this->getBasePath();
        $scandir = scandir($basePath);
        $deleted = array();
        foreach($scandir as $file)
        {
            if ($this->endsWith($file, $institution . ".xml"))
            {
                unlink($file);
                array_push($deleted, $file);
            }
            echo $deleted;
        }
        $view = $this->createViewModel('hierarchy/deleteResult');
        $view->deleted = $deleted;
        return $view;
    }

    public function endsWith($string, $subString)
    {
        return substr_compare($string, $subString, -strlen($subString)) === 0;
    }
}