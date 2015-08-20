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
        	error_log("TreeDataSource\Solr: getXML(): retrieve id:{$id}");
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

        // Caching
        $cacheRead = isset($options['refresh']) ? !$options['refresh'] : true;
        $cacheTime = $this->getHierarchyDriver()->getTreeCacheTime();
        $cacheFile = $this->cacheDir;

        if (null !== $cacheFile) {

            $cacheFile .= '/';
            $cacheFile .= (false === $loadSubtree) ? 'hierarchyTree' : 'hierarchySubTree';
            $cacheFile .= '_' . urlencode($id) . '.xml';
        }

        $cacheWrite = $cacheRead && null !== $cacheFile;

        // Read (sub) tree from cache?
        if (true === $cacheRead && null !== $cacheFile && true === file_exists($cacheFile)
            && ($cacheTime < 0 || filemtime($cacheFile) > (time() - $cacheTime))) {

            $xml = file_get_contents($cacheFile);
        }
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

            // Write (sub) tree to cache
            if ($cacheWrite) {

                if (!file_exists($this->cacheDir)) {
                    mkdir($this->cacheDir);
                }

                file_put_contents($cacheFile, $xml);
            }
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
            $parentId = array_shift(array_flip($parents));
            error_log("TreeDataSource\Solr: _getXMLParents(): retrieve id:{$parentId}");
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

            // If no hierarchy tree has been generated yet, try to fetch
            // at least the immediate children of the root element
            if (0 === strlen($treeXML)) {
                $treeXML = $this->getChildren($record->getUniqueID());
            }

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

    /**
     * Get the immediate children's XML of a hierarchy tree record.
     *
     * @param string $parentID to get the children of
     * @param string $hookId the id of the record to insert further lower tree levels
     * @return string the children's XML
     * @throws \Exception
     */
    protected function getChildren($parentID, $hookId = null) {

        // Lookup children by parent ID
        $query = new Query(
            'hierarchy_parent_id:"' . addcslashes($parentID, '"') . '"'
        );

        error_log("TreeDataSource\Solr: getChildren(): search hierarchy_parent_id:{$parentID}");
        $results = $this->searchService->search(
            'Solr', $query, 0, 10000, new ParamBag(array('fq' => $this->filters))
        );

        if ($results->getTotal() < 1) {
            return '';
        }

        $xml = array();
        $sorting = $this->getHierarchyDriver()->treeSorting();

        foreach ($results->getRecords() as $current) {

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
            $hasChildren = $this->_recordHasChildren($uid) ? 'true' : 'false';
            // Placeholder for further children levels (see calling function)
            $replace = ($uid === $hookId) ? '%%%children%%%' : '';

            $xmlNode = <<<XML
<item id="$id" hasChildren="$hasChildren" isCollection="$isCollection">
    <content>
        <name>$title</name>
    </content>
    $replace
</item>
XML;

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

    /**
     * Check whether a hierarchy tree record has children.
     *
     * @author dku <dku@outermedia.de>
     * @param VuFind\\RecordDriver $record the hierarchy tree record to check
     * @return bool record has children
     */
    protected function _recordHasChildren($record) {

        if ('object' === gettype($record) && method_exists($record, 'getUniqueID')) {
            $record = $record->getUniqueID();
        }

        $query = new Query('hierarchy_parent_id:"' . addcslashes($record, '"') . '"');
        $params = new ParamBag(array('fq' => $this->filters));

        error_log("TreeDataSource\Solr: _recordHasChildren(): search hierarchy_parent_id:{$record}");
        return 0 < $this->searchService->search('Solr', $query, 0, 10000, $params)->getTotal();
    }
}
