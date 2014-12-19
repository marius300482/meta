<?php
/**
 * RecordDriver for Archive Items.
 * User: boehm
 * Date: 6/11/14
 * Time: 11:46 AM
 */

namespace Ida\RecordDriver;


class SolrSystematics extends SolrIDA
{
    function __construct($mainConfig = null, $recordConfig = null,
                         $searchSettings = null)
    {
        parent::__construct($mainConfig, $recordConfig, $searchSettings);
    }
} 