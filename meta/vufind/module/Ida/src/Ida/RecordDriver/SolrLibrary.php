<?php
/**
 * * RecordDriver for Library Items.
 * User: boehm
 * Date: 6/11/14
 * Time: 11:46 AM
 */

namespace Ida\RecordDriver;


class SolrLibrary extends SolrIDA {

    function __construct($mainConfig = null, $recordConfig = null,
                         $searchSettings = null)
    {
        parent::__construct($mainConfig, $recordConfig, $searchSettings);
    }
} 