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


    function __construct($hierarchyDriver, $cacheDir)
    {
        $this->setHierarchyDriver($hierarchyDriver);
        $this->cacheDir = $cacheDir;
    }

    public function delete($institution)
    {
        $deleted = array();
        if ($institution == null)
        {
            return $deleted;
        }

        $scandir = scandir($this->cacheDir);
        $failure = array();
        foreach($scandir as $file)
        {
            if ($this->endsWith($file, $institution . ".xml"))
            {
                $path=$this->cacheDir . "/" . $file;
                if(!unlink($path))
                {
                    echo "Failed to delete " . $path;
                    array_push($failure, $file);
                }
                else
                {
                	error_log("deleted cache file {$file}");
                    array_push($deleted, $file);
                }
            }
        }

        return $deleted;
    }

    public function endsWith($string, $subString)
    {
        return substr_compare($string, $subString, -strlen($subString)) === 0;
    }
}