<?php
/**
 * User: boehm
 * Date: 6/11/14
 * Time: 12:02 PM
 */

namespace Ida\Controller;

use Ida\Institution\Institution;
use VuFind\Controller\BrowseController;
use VuFind\RecordDriver\SolrDefault;
use Zend\Config\Config;
use Zend\View\Model\ViewModel;

class TopicsController extends BrowseController
{
    /**
     * VuFind configuration
     *
     * @var Config
     */
    protected $config;
    private $limit;
    private $alpha;

    public function __construct(Config $config)
    {
        $this->config = $config;
        $this->config = new Config($config->toArray(), true);
        $this->limit = $this->config->Browse->result_limit;
        $this->alpha = $this->config->Browse->alphabetical_order;
    }

    private function changeConfigForList()
    {
        $this->config->Browse->result_limit = -1;
        $this->config->Browse->alphabetical_order = true;
    }

    private function restoreConfig()
    {
        $this->config->Browse->result_limit = $this->limit;
        $this->config->Browse->alphabetical_order = $this->alpha;
    }

    public function listAction()
    {
        $prefix = $this->getRequest()->getQuery()->get('facet_prefix');
        $parameters = $this->getRequest()->getQuery();

        // Default to 'A' in case no prefix is given
        if ($prefix == null || $prefix == '') {
            $parameters->set('facet_prefix', 'A');
            $this->getRequest()->setQuery($parameters);
        }
        $this->changeConfigForList();
        $topics = $this->getFacetList('topic_facet', 'topic_facet', 'alphabetical', $parameters->get('facet_prefix') . '*');
        $this->restoreConfig();

        $view = $this->createViewModel('topics/list');
        $view->topics = $topics;
        $view->paginationChars = $this->getAlphabetList();
        $view->currentChar = $parameters->get('facet_prefix');
        $view->driver = new SolrDefault();
        return $view;
    }

    public function homeAction()
    {
        $view = $this->createViewModel('topics/home');
        $view->topics = $this->getTagCloud();
        $view->institutions = $this->getInstitutions();
        $view->inventoryFacet = $this->getInventoryfacet();
        $view->solrDriver = new SolrDefault();
        $view->randomBooks = $this->getRandomItems();
        return $view;
    }

    public function topicsAction()
    {
        $view = $this->createViewModel('topics/topics');
        $view->topics = $this->getTagCloud();
        $view->driver = new SolrDefault();
        return $view;
    }

    public function getTagCloud()
    {
        // Remove some entries for better distribution
        $topics = array_slice($this->getTopics(), 6);

        $max_font = $this->config->TopicsCloud->fontsize != null ? $this->config->TopicsCloud->fontsize : 50;
        $maxcount=reset($topics);
        $keyword_weight_ratio = (float)($max_font / (float)$maxcount['count']);

        foreach ($topics as &$topic) {
            $topic['weight'] = round($topic['count'] * $keyword_weight_ratio);
        }

        $alpha = $this->config->TopicsCloud->alpha;
        if (!isset($alpha) || $alpha) {
            usort($topics, function ($a, $b) {
                return $a['displayText'] > $b['displayText'];
            });
        }

        return $topics;
    }

    public function getInventoryfacet() {
        $colors = array(
            "#990099", "#29AAE3", "#01009A",
            "#FF931E", "#C1272D", "#8CC53F"
        );
        // Get content of the format cell as array
        $facetContent = $this->getFacetList('format', 'format', 'count', '*');
        // Add values which are required for presentation
        for ($i = 0; $i < count($facetContent); $i++) {
            // Add percentage
            $maxCount = $facetContent[0]['count'];
            $currentCount = $facetContent[$i]['count'];
            $percent = 0 < $maxCount ? (100 / $maxCount) * $currentCount : 0;
            $facetContent[$i]['percent'] = round($percent, 2);
            // Add color
            $facetContent[$i]['color'] = $i < count($colors) ? $colors[$i] : "#000000";
        }

        return $facetContent;
    }

    protected function getRandomItems()
    {
        $idSourceFile = APPLICATION_PATH . "/module/Ida/data/randomItems.ini";
        $maxItems = 3;
        $randomIds = array();
        $result = array();
        try {
            // Read the .ini file
            $reader = new \Zend\Config\Reader\Ini();
            $ini = (array) $reader->fromFile($idSourceFile);
            // Get the item ids if there are any in the .ini file
            $itemIds = isset($ini['item']) ? $ini['item'] : array();
            shuffle($itemIds);
            // Get 3 array keys randomly from the $itemIds array
            $randomIds = $maxItems < count($itemIds) ? array_rand($itemIds, $maxItems) : $itemIds;
        } catch (\Zend\Config\Exception\RuntimeException $error) {}

        // Read items from Solr
        foreach ($randomIds as $randomId) {
            try {
                $result[] = $this->getRecordLoader()->load($itemIds[$randomId], "Solr");
            } catch (\VuFind\Exception\RecordMissing $error) {}
        }

        return $result;
    }

    protected function getInstitutions()
    {
        $language = $this->getServiceLocator()->has('VuFind\Translator')
            ? $this->getServiceLocator()->get('VuFind\Translator')->getLocale()
            : 'de';
        $institution = new \Ida\Institution\Institution(null, $language);

        return $institution->getAllInstitutions();
    }

    protected function createViewModel($template = null, $params = null)
    {
        $view = new ViewModel();
        $view->setTemplate($template);

        return $view;
    }

    private function getTopics()
    {
        $results = $this->getFacetList('topic_facet');

        return $results;
    }
}