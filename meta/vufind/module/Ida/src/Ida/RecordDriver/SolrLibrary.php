<?php
/**
 * Record Driver for Library Items.
 * User: boehm
 * Date: 6/4/14
 * Time: 3:21 PM
 */
namespace Ida\RecordDriver;

use VuFind\RecordDriver\SolrDefault;
use VuFind\XSLT\Import\VuFind;

class SolrLibrary extends SolrDefault
{

    function __construct($mainConfig = null, $recordConfig = null,
                         $searchSettings = null)
    {
        parent::__construct($mainConfig, $recordConfig, $searchSettings);
    }

    public function getEditors()
    {
        return isset($this->fields['editor']) && is_array($this->fields['editor']) ?
            $this->fields['editor'] : array();
    }

    public function getPublishers()
    {
        return isset($this->fields['publisher']) && is_array($this->fields['publisher']) ?
            $this->fields['publisher'] : array();
    }

    public function getDisplayPublicationDate()
    {
        return $this->fields['displayPublisheddate'];
    }

    public function getDisplayTitle()
    {
        return isset($this->fields['title_sub']) ?
            $this->getShortTitle() . " : " . $this->getTitleSub() : $this->getTitle();
    }

    public function  getTitleSub()
    {
        return $this->fields['title_sub'];
    }

    public function getSeriesNr()
    {
        return $this->fields['seriesNr'];
    }

    public function getTopics()
    {
        return isset($this->fields['topic']) ? $this->fields['topic'] : array();
    }
}