<?php
/**
 * User: boehm
 * Date: 6/11/14
 * Time: 12:02 PM
 */

namespace Ida\Controller;


use VuFind\Controller\BrowseController;
use VuFind\RecordDriver\SolrDefault;
use Zend\View\Model\ViewModel;

class TopicsController extends BrowseController
{
    /**
     * VuFind configuration
     *
     * @var \Zend\Config\Config
     */
    protected $config;

    public function __construct(\Zend\Config\Config $config)
    {
        $this->config = $config;
    }

    public function cloudAction()
    {
        $topics = $this->getTopics();

        $max_font = $this->config->TopicsCloud->fontsize != null ? $this->config->TopicsCloud->fontsize : 50;
        $keyword_weight_ratio = (float) ($max_font / (float) reset($topics)['count']);

        foreach($topics as &$topic)
        {
            $topic['weight'] = round($topic['count'] * $keyword_weight_ratio);
        }

        $view = $this->createViewModel();
        $view->topics = $topics;
        $view->driver = new SolrDefault();
        return $view;
    }

    protected function createViewModel($params = null)
    {
        $view = new ViewModel();
        $view->setTemplate('topics/cloud');

        return $view;
    }

    private function getTopics()
    {
        $results = $this->getFacetList('topic_facet');

        return $results;
    }
}