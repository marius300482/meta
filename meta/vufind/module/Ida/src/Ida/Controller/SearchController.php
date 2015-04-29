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
// TODO - PHE START: Make this code obsolete. Re-use this->resultsAction() and set facet limit in there
        // PHE START: Empty search is forbidden #71
        if ($this->isEmptySearch()) {
            return $this->forwardTo('Error', 'Search');
        }
        // PHE END: Empty search is forbidden #71
        $view = $this->createViewModel();
        $results = $this->getResultsManager()->get($this->searchClassId);
        $params = $results->getParams();
        $params->setFacetLimit(999999); // PHE change the limit
        $noRecommend = $this->params()->fromQuery('noRecommend', false);
        $params->recommendationsEnabled(!$noRecommend);
        $params->initFromRequest(
            new Parameters(
                $this->getRequest()->getQuery()->toArray()
                + $this->getRequest()->getPost()->toArray()
            )
        );
        $view->params = $params;
        try {
            $results->performAndProcessSearch();
            $view->results = $results;
            if ($this->resultScrollerActive()) {
                $this->resultScroller()->init($results);
            }
        } catch (\VuFindSearch\Backend\Exception\BackendException $e) {
            if ($e->hasTag('VuFind\Search\ParserError')) {
                $view->parseError = true;
                $view->results = $this->getResultsManager()->get('EmptySet');
                $view->results->setParams($params);
                $view->results->performAndProcessSearch();
            } else {
                throw $e;
            }
        }
// TODO - PHE END: Make this code obsolete. Re-use this->resultsAction() and set facet limit in there

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
