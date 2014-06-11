<?php
/**
 * Created by PhpStorm.
 * User: boehm
 * Date: 6/11/14
 * Time: 11:46 AM
 */

namespace Ida\RecordDriver;


class SolrArchive extends SolrLibrary{

    function __construct($mainConfig = null, $recordConfig = null,
                         $searchSettings = null)
    {
        parent::__construct($mainConfig, $recordConfig, $searchSettings);
    }
} 