<?php
namespace Ida\Controller;

/**
 * Class IDA SearchController
 *
 * @author PHE
 * @package Ida\Controller
 */
class SearchController extends VuFind\Controller\SearchController
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
            // All search query attributes start with "lookfor"
            // and can end with an integer value. E.g. "lookfor123"
            $isSearchAttribute = 1 === preg_match('/^lookfor\d*$/', $attribute);
            if ($isSearchAttribute) {
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

        // Default case -- standard behavior.
        return parent::resultsAction();
    }
}
