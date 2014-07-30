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

    public function  getLoanStatus()
    {
        $loanStatus = null;
        if ($this->getSingleValuedField("loanStatus") !== null)
        {
            $loanStatus = $this->getSingleValuedField("loanStatus");
        }
        return $loanStatus;
    }

    public function getLoanReturn()
    {
        $loanReturn = null;
        if ($this->getSingleValuedField("loanReturn"))
        {
            $loanReturn = $this->getSingleValuedField("loanReturn");
        }
        return $loanReturn;
    }
} 