<?php
/**
 * Hierarchy Tree Data Source (Solr)
 *
 */
namespace Ida\Hierarchy\TreeDataSource;
use VuFindSearch\ParamBag;
use VuFindSearch\Query\Query;

/**
 * Hierarchy Tree Data Source (Solr)
 *
 * This is a base helper class for producing hierarchy Trees.
 *
 */
class Solr extends \VuFind\Hierarchy\TreeDataSource\Solr
{

    /**
     * Get XML for the specified hierarchy ID.
     *
     * Build the XML file from the Solr fields
     *
     * @param string $id Hierarchy ID.
     * @param array  $options Additional options for XML generation.  (Currently one
     * option is supported: 'refresh' may be set to true to bypass caching).
     *
     * @return string
     */
    public function getXML($id, $options = array()) {

        // Get the next hierarchy level (one sub level)
        $loadSubtree = isset($options['subtree']) && true === $options['subtree'];

        if (false === $loadSubtree) {

            // Lookup by record ID
            $result = $this->searchService->retrieve('Solr', $id);

            if (0 === $result->getTotal()) {

                // Record was not found (error)
                return '';
            }
        }
        // Load sub-tree
        else {

            $xml = $this->getChildren($id);

            if (0 === strlen($xml)) {

                return '';
            }
        }

        if (false) {} // TODO: Caching
        else {

            if (false === $loadSubtree) {

                $result = $result->first();

                // Traverse hierarchy tree upwards
                $xml = $this->_getXMLParents($result, '');
            }

            $xml = <<<ROOT
<root>
    $xml
</root>
ROOT;
        }

        return $xml;
    }

    /**
     * Build the hierarchy tree XML of a record's parents.
     *
     * @author dku <dku@outermedia.de>
     * @param VuFind\\RecordDriver $record hierarchy tree record
     * @param string $treeXML the record's descendant's XML (optional)
     * @return string the record's parents' XML
     */
    protected function _getXMLParents($record, $treeXML) {

        // Unspecified error?
        if (false === method_exists($record, 'getHierarchyPositionsInParents')) {
            return '';
        }

        $parents = $record->getHierarchyPositionsInParents();

        if (0 < count($parents)) {

            // Use first parent entry
            $parentId = array_shift(array_flip($record->getHierarchyPositionsInParents()));
            $result = $this->searchService->retrieve('Solr', $parentId);

            // Traverse tree upwards
            if (0 < $result->getTotal()) {

                // Build the record's sibling's tree level (XML)
                $children = $this->getChildren($parentId, $record->getUniqueID());

                // Append former descendant's XML to this tree level (if applicable)
                $treeXML = str_replace('%%%children%%%', $treeXML, $children);

                return $this->_getXMLParents($result->first(), $treeXML);
            }
            // No parents in tree hierarchy
            else {
                return '';
            }
        }
        // Root element reached
        else {
            return str_replace('%%%children%%%', $treeXML, $this->_getXMLRecord($record, true));
        }
    }

    /**
     * Generate XML code for a specific record (in the hierarchy tree).
     *
     * @param VuFind\\RecordDriver $record the hierarchy tree record
     * @param boolean $hasChildren if the record is parent of another record (in the hierarchy tree)
     * @return string the hierarchy tree's record XML code
     */
    protected function _getXMLRecord($record, $hasChildren) {

        if (false === method_exists($record, 'getUniqueID')) {
            return '';
        }

        $id = htmlspecialchars($record->getUniqueID());
        $title = htmlspecialchars($record->getTitle());
        $isCollection = $record->isCollection() ? 'true' : 'false';
        // Insert placeholder for children (items)
        $children = (true === $hasChildren) ? '%%%children%%%' : '';

        $xml = <<<XML
<item id="$id" isCollection="$isCollection">
    <content>
        <name>$title</name>
    </content>
    $children
</item>
XML;

        return $xml;
    }

    // hinweis: nur eine h-ebene
    protected function getChildren($parentID,$hookId=false) {

//        var_dump(get_class($this->searchService));exit;
        $query = new Query(
            'hierarchy_parent_id:"' . addcslashes($parentID, '"') . '"'
        );
        $results = $this->searchService->search(
            'Solr', $query, 0, 10000, new ParamBag(array('fq' => $this->filters))
        );
        if ($results->getTotal() < 1) {
            return '';
        }
        $xml = array();
        $sorting = $this->getHierarchyDriver()->treeSorting();

        foreach ($results->getRecords() as $current) {
//            ++$count;
            if ($sorting) {
                $positions = $current->getHierarchyPositionsInParents();
                if (isset($positions[$parentID])) {
                    $sequence = $positions[$parentID];
                }
            }

            $uid = $current->getUniqueID();
            $this->debug("$parentID: " . $current->getUniqueID());
            $id = htmlspecialchars($uid);
            $title = htmlspecialchars($current->getTitle());
            $isCollection = $current->isCollection() ? "true" : "false";
//            $hasChildren='false';
            $hasChildren = $this->_recordHasChildren($current) ? 'true' : 'false';
            $ins2=$uid===$hookId?'%%%children%%%':'';
            $xmlNode = <<<XML
<item id="$id" hasChildren="$hasChildren" isCollection="$isCollection">
    <content>
        <name>$title</name>
    </content>
    $ins2
</item>
XML;

//            array_push($xml, array(0, $xmlNode));
            array_push($xml, array((isset($sequence) ? $sequence : 0), $xmlNode));
        }

        if ($sorting) {
            $this->sortNodes($xml, 0);
        }

        $xmlReturnString = '';
        foreach ($xml as $node) {
            $xmlReturnString .= $node[1];
        }
        return $xmlReturnString;
    }
    protected function _recordHasChildren($record) {
//        var_dump(gettype($record));exit;

        if ('object' === gettype($record) && method_exists($record, 'getUniqueID')) {
            $record = $record->getUniqueID();
        }

        $query = new Query('hierarchy_parent_id:"' . addcslashes($record, '"') . '"');
        $params = new ParamBag(array('fq' => $this->filters));

        return 0 < $this->searchService->search('Solr', $query, 0, 10000, $params)->getTotal();
    }
    /**
     * Get Solr Children
     *
     * @param string $parentID The starting point for the current recursion
     * (equivlent to Solr field hierarchy_parent_id)
     * @param string &$count   The total count of items in the tree
     * before this recursion
     *
     * @return string
     */
    /*
    protected function getChildrenVuFind($parentID, &$count)
    {
        $query = new Query(
            'hierarchy_parent_id:"' . addcslashes($parentID, '"') . '"'
        );
        $results = $this->searchService->search(
            'Solr', $query, 0, 10000, new ParamBag(array('fq' => $this->filters))
        );
        if ($results->getTotal() < 1) {
            return '';
        }
        $xml = array();
        $sorting = $this->getHierarchyDriver()->treeSorting();

        foreach ($results->getRecords() as $current) {
            ++$count;
            if ($sorting) {
                $positions = $current->getHierarchyPositionsInParents();
                if (isset($positions[$parentID])) {
                    $sequence = $positions[$parentID];
                }
            }

            $this->debug("$parentID: " . $current->getUniqueID());
            $xmlNode = '';
            $isCollection = $current->isCollection() ? "true" : "false";
            $xmlNode .= '<item id="' . htmlspecialchars($current->getUniqueID()) .
                '" isCollection="' . $isCollection . '"><content><name>' .
                htmlspecialchars($current->getTitle()) . '</name></content>';
            $xmlNode .= $this->getChildrenVuFind($current->getUniqueID(), $count);
            $xmlNode .= '</item>';
            array_push($xml, array((isset($sequence) ? $sequence : 0), $xmlNode));
        }

        if ($sorting) {
            $this->sortNodes($xml, 0);
        }

        $xmlReturnString = '';
        foreach ($xml as $node) {
            $xmlReturnString .= $node[1];
        }
        return $xmlReturnString;
    }
    */

    // TODO delete
    // orig: VuFind/Hierarchy/TreeDataSource/Solr::getChildren(2)
    /*
    protected function getChildrenVuFind($parentID, &$count)
    {

        $query = new Query(
            'hierarchy_parent_id:"' . addcslashes($parentID, '"') . '"'
        );
        $results = $this->searchService->search(
            'Solr', $query, 0, 10000, new ParamBag(array('fq' => $this->filters))
        );
        if ($results->getTotal() < 1) {
            return '';
        }
        $xml = array();
        $sorting = $this->getHierarchyDriver()->treeSorting();

        foreach ($results->getRecords() as $current) {
            ++$count;
            if ($sorting) {
                $positions = $current->getHierarchyPositionsInParents();
                if (isset($positions[$parentID])) {
                    $sequence = $positions[$parentID];
                }
            }

            $this->debug("$parentID: " . $current->getUniqueID());
            $xmlNode = '';
            $isCollection = $current->isCollection() ? "true" : "false";
            $xmlNode .= '<item id="' . htmlspecialchars($current->getUniqueID()) .
                '" isCollection="' . $isCollection . '"><content><name>' .
                htmlspecialchars($current->getTitle()) . '</name></content>';
            // 2edit:dku
            $xmlNode .= $this->getChildrenVuFind($current->getUniqueID(), $count);
            $xmlNode .= '</item>';
            array_push($xml, array((isset($sequence) ? $sequence : 0), $xmlNode));
        }

        if ($sorting) {
            $this->sortNodes($xml, 0);
        }

        $xmlReturnString = '';
        foreach ($xml as $node) {
            $xmlReturnString .= $node[1];
        }
        return $xmlReturnString;
    }
    */
}
