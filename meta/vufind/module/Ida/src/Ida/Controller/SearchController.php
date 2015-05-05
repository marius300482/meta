<?php
namespace Ida\Controller;

use Zend\Stdlib\Parameters;
use Zend\Paginator\Adapter\ArrayAdapter;
use Zend\Paginator;

/**
 * Class IDA SearchController
 *
 * @author PHE
 * @package Ida\Controller
 */
class SearchController extends \VuFind\Controller\SearchController
{
    /**
     * VuFind results action.
     *
     * @overwrite
     * @return mixed
     */
    public function resultsAction()
    {
        // PHE START: Empty search is forbidden #71
        if ($this->isEmptySearch()) {
            if (!$this->loadLatestSearch()) {
                return $this->forwardTo('Error', 'Search');
            }
        }
        // PHE END: Empty search is forbidden #71

        // Default case -- standard behavior.
        return parent::resultsAction();
    }

    /**
     * Custom view for contributor paging
     *
     * @return mixed
     * @throws \Exception
     */
    public function contributorsAction()
    {
        // PHE START: Empty search is forbidden #71
        if ($this->isEmptySearch()) {
            if (!$this->loadLatestSearch()) {
                return $this->forwardTo('Error', 'Search');
            }
        }
        // PHE END: Empty search is forbidden #71

        // Perform normal search
        $view = parent::resultsAction();

        // Perform search for the contributor facet with extended limit
        $maxItems = 99999;
        $contributorKey = 'contributor_facet';
        $contributorFacet = $this->getFacetList($contributorKey, 'alphabetical', $maxItems);
        $view->contributorFacetKey = $contributorKey;
        $view->contributorFacet = $contributorFacet;

        // Set up special pagination for the contributor facet
        $adapter = new ArrayAdapter($contributorFacet);
        $paginator = new Paginator\Paginator($adapter);
        $paginator->setCurrentPageNumber($view->results->getParams()->getPage())
            ->setItemCountPerPage($view->results->getParams()->getLimit())
            ->setPageRange(5);
        $view->paginator = $paginator;
        $view->pages = $paginator->getPages();

        return $view;
    }

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
     * Get the whole search history of the current user
     *
     * @return mixed
     */
    protected function getUserSearchHistory()
    {
        $allSearches = $this->getTable('Search');
        $userSessionId = $this->getServiceLocator()->get('VuFind\SessionManager')->getId();

        return $allSearches->getSearches($userSessionId);
    }

    /**
     * Load the latest non-empty search of the current user
     */
    protected function loadLatestSearch()
    {
        $lastSearchLoaded = false;
        $currentCount = 1;
        $searchHistory = $this->getUserSearchHistory();
        $lastEntryCount = $searchHistory->count();

        // The only way to get the last search is to iterate over all searches
        foreach ($searchHistory as $search) {
            if($lastEntryCount === $currentCount) {
                $lastSearchLoaded = true;
                $searchId = $search->getSearchObject()->id;
                $this->redirectToSavedSearch($searchId);
            }
            $currentCount++;
        }

        return $lastSearchLoaded;
    }

    /**
     * Get a list of items from a facet.
     *
     * @param string $facet    The facet we're searching in
     * @param string $sort     How are we sorting these?
     * @param int $limit       Max entries we request from the DB. Keep memory limit in mind!
     *
     * @return array           Array indexed by value with text of displayText and count
     */
    protected function getFacetList($facet, $sort = 'count', $limit = 30) {
        $results = $this->getResultsManager()->get($this->searchClassId);
        $params = $results->getParams();
        // Use GET and POST variables
        $params->initFromRequest(
            new Parameters(
                $this->getRequest()->getQuery()->toArray() +
                $this->getRequest()->getPost()->toArray()
            )
        );
        $params->addFacet($facet);
        $params->getOptions()->disableHighlighting();
        $params->getOptions()->spellcheckEnabled(false);
        $params->recommendationsEnabled(false);
        $params->setFacetLimit($limit);
        // Facet prefix
        if ($this->params()->fromQuery('facet_prefix')) {
            $params->setFacetPrefix($this->params()->fromQuery('facet_prefix'));
        }
        $params->setFacetSort($sort);
        $result = $results->getFacetList();

        return isset($result[$facet]) ? $result[$facet]['list'] : array();
    }
}
