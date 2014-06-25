<?php
/**
 * User: boehm
 * Date: 6/11/14
 * Time: 12:02 PM
 */

namespace Ida\Controller;


use VuFind\Controller\BrowseController;
use VuFind\RecordDriver\SolrDefault;
use Zend\Stdlib\Parameters;
use Zend\View\Model\ViewModel;

class TopicsController extends BrowseController
{
    public function listAction()
    {
        $prefix = $this->getRequest()->getQuery()->get('facet_prefix');
        // Default to 'A' in case no prefix is given
        if (!$prefix && $prefix != 0) {
            $this->getRequest()->setQuery(new Parameters(['facet_prefix' => 'A']));
        }
        $topics = $this->getFacetList('topic_facet', 'topic_facet', 'alphabetical', $this->getRequest()->getQuery()->get('facet_prefix') . '*');

        $view = $this->createViewModel('topics/list');
        $view->topics = $topics;
        $view->paginationChars = $this->getAlphabetList();
        $view->char = $this->getRequest()->getQuery()->get('facet_prefix');
        $view->driver = new SolrDefault();
        return $view;
    }

    public function cloudAction()
    {
        $topics = $this->getTopics();

        $max_font = $this->config->TopicsCloud->fontsize != null ? $this->config->TopicsCloud->fontsize : 50;
        $keyword_weight_ratio = (float)($max_font / (float)reset($topics)['count']);

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