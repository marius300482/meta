<?php
namespace Ida\Controller;

use Zend\Stdlib\Parameters;

/**
 * Class IDA SearchController
 *
 * @author PHE
 * @package Ida\Controller
 */
class SearchController extends \VuFind\Controller\SearchController
{
    /**
     * Helper function to check if the current search is empty #71
     *
     * @param int $minValueLength Minimum length of the longest search value
     * @return bool
     */
    protected function isEmptySearch($minValueLength = 1)
    {
        $isEmptySearch = true;
        $searchQuery = $this->params()->fromQuery();

        // Iterate over all query values
        foreach ($searchQuery as $attribute => $values) {
            // All text search query attributes start with "lookfor"
            // and can end with an integer value. E.g. "lookfor123"
            $isSearchAttribute = 1 === preg_match('/^lookfor\d*$/', $attribute);
            // Valid search queries can also be (facet) filters
            $isFilterAttribute = 1 === preg_match('/^filter$/', $attribute);
            if ($isSearchAttribute || $isFilterAttribute) {
                // Transform simple search queries into
                // the same format as advanced search queries.
                // This allows us the do the same validation
                if (!is_array($values)) {
                    $values = array($values);
                }
                // Validate all attribute values
                foreach ($values as $value) {
                    $valueLength = strlen(trim($value));
                    if (is_string($value) && $minValueLength <= $valueLength) {
                        $isEmptySearch = false;
                        // Finish inner and outer loop
                        break 2;
                    }
                }
            }
        }

        return $isEmptySearch;
    }

    /**
     * VuFind functionResults action.
     *
     * @overwrite
     * @return mixed
     */
    public function resultsAction()
    {
        // PHE START: Empty search is forbidden #71
        if ($this->isEmptySearch()) {
            return $this->forwardTo('Error', 'Search');
        }
        // PHE END: Empty search is forbidden #71

        // Default case -- standard behavior.
        return parent::resultsAction();
    }

    public function contributorsAction()
    {
        // Special case -- redirect tag searches.
        $tag = $this->params()->fromQuery('tag');
        if (!empty($tag)) {
            $query = $this->getRequest()->getQuery();
            $query->set('lookfor', $tag);
            $query->set('type', 'tag');
        }

        // PHE START: Empty search is forbidden #71
        if ($this->isEmptySearch()) {
            return $this->forwardTo('Error', 'Search');
        }
        // PHE END: Empty search is forbidden #71

        if ($this->params()->fromQuery('type') == 'tag') {
            return $this->forwardTo('Tag', 'Home');
        }

        $view = $this->createViewModel();

        // Handle saved search requests:
        $savedId = $this->params()->fromQuery('saved', false);
        if ($savedId !== false) {
            return $this->redirectToSavedSearch($savedId);
        }

        $results = $this->getResultsManager()->get($this->searchClassId);
        $params = $results->getParams();
        $params->setFacetLimit(999999); // PHE change the limit

        // Enable recommendations unless explicitly told to disable them:
        $noRecommend = $this->params()->fromQuery('noRecommend', false);
        $params->recommendationsEnabled(!$noRecommend);

        // Send both GET and POST variables to search class:
        $params->initFromRequest(
            new Parameters(
                $this->getRequest()->getQuery()->toArray()
                + $this->getRequest()->getPost()->toArray()
            )
        );

        // Make parameters available to the view:
        $view->params = $params;

        // Attempt to perform the search; if there is a problem, inspect any Solr
        // exceptions to see if we should communicate to the user about them.
        try {
            // Explicitly execute search within controller -- this allows us to
            // catch exceptions more reliably:
            $results->performAndProcessSearch();

            // If a "jumpto" parameter is set, deal with that now:
            if ($jump = $this->processJumpTo($results)) {
                return $jump;
            }

            // Send results to the view and remember the current URL as the last
            // search.
            $view->results = $results;
            $this->rememberSearch($results);

            // Add to search history:
            if ($this->saveToHistory) {
                $user = $this->getUser();
                $sessId = $this->getServiceLocator()->get('VuFind\SessionManager')
                    ->getId();
                $history = $this->getTable('Search');
                $history->saveSearch(
                    $this->getResultsManager(), $results, $sessId,
                    $history->getSearches(
                        $sessId, isset($user->id) ? $user->id : null
                    )
                );
            }

            // Set up results scroller:
            if ($this->resultScrollerActive()) {
                $this->resultScroller()->init($results);
            }
        } catch (\VuFindSearch\Backend\Exception\BackendException $e) {
            if ($e->hasTag('VuFind\Search\ParserError')) {
                // If it's a parse error or the user specified an invalid field, we
                // should display an appropriate message:
                $view->parseError = true;

                // We need to create and process an "empty results" object to
                // ensure that recommendation modules and templates behave
                // properly when displaying the error message.
                $view->results = $this->getResultsManager()->get('EmptySet');
                $view->results->setParams($params);
                $view->results->performAndProcessSearch();
            } else {
                throw $e;
            }
        }
        // Save statistics:
        if ($this->logStatistics) {
            $this->getServiceLocator()->get('VuFind\SearchStats')
                ->log($results, $this->getRequest());
        }

        // Get contributor facet
        $facets = $view->results->getfacetList();
        $view->contributorFacetKey = 'contributor_facet';

        if (!isset($facets[$view->contributorFacetKey])) {
            throw new \Exception('Facet "' . $view->contributorFacetKey . '" does not exist!');
        } else {
            $view->contributorFacet = $facets[$view->contributorFacetKey];
        }

        // Set up paginator
        $adapter = new \Zend\Paginator\Adapter\ArrayAdapter($view->contributorFacet['list']);
        $pageLimit = max($view->results->getParams()->getLimit(), 20);
        $paginator = new \Zend\Paginator\Paginator($adapter);
        $paginator->setCurrentPageNumber($view->results->getParams()->getPage())
            ->setItemCountPerPage($pageLimit)
            ->setPageRange(5);
        $view->paginator = $paginator;
        $view->pages = $paginator->getPages();

        return $view;
    }
}
