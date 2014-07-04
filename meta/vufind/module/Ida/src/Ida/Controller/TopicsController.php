<?php
/**
 * User: boehm
 * Date: 6/11/14
 * Time: 12:02 PM
 */

namespace Ida\Controller;


use VuFind\Controller\BrowseController;use VuFind\RecordDriver\SolrDefault;use Zend\Config\Config;use Zend\View\Model\ViewModel;

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

    public function cloudAction()
    {
        $topics = $this->getTopics();

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

        $view = $this->createViewModel('topics/cloud');
        $view->topics = $topics;
        $view->driver = new SolrDefault();
        return $view;
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