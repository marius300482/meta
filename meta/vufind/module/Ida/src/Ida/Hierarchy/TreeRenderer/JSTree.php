<?php
/**
 * Hierarchy Tree Renderer for the JS_Tree plugin
 *
 */
namespace Ida\Hierarchy\TreeRenderer;

/**
 * Hierarchy Tree Renderer
 *
 * This is a helper class for producing hierarchy trees and
 * extends the class \VuFind\Hierarchy\TreeRenderer\JSTree.
 *
 * @see \VuFind\Hierarchy\TreeRenderer\JSTree
 */

class JSTree extends \VuFind\Hierarchy\TreeRenderer\JSTree
{

    /**
     * Transforms Collection XML to Desired Format
     *
     * @param string $context     The Context in which the tree is being displayed
     * @param string $mode        The Mode in which the tree is being displayed
     * @param string $hierarchyID The hierarchy to get the tree for
     * @param string $recordID    The currently selected Record (false for none)
     *
     * @return string A HTML List
     */
    protected function transformCollectionXML(
        $context, $mode, $hierarchyID, $recordID
    ) {
        $record = $this->getRecordDriver();
        $inHierarchies = $record->getHierarchyTopID();
        $inHierarchiesTitle = $record->getHierarchyTopTitle();

        $hierarchyTitle = $this->getHierarchyName(
            $hierarchyID, $inHierarchies, $inHierarchiesTitle
        );

        // Set up parameters for XSL transformation
        $params = array(
            'titleText' => $this->translate('collection_view_record'),
            'collectionID' => $hierarchyID,
            'collectionTitle' => $hierarchyTitle,
            'baseURL' => '%%%%VUFIND-BASE-URL%%%%',
            'context' => $context,
            'recordID' => $recordID
        );

        //edit:dku
        // TODO: auslagern an richtige stelle
        if (isset($_REQUEST['subtree'])) {
            $recordID = '';
        }

        // Transform the XML
        // TODO:
        if (!isset($_REQUEST['subtree'])) {
            $xmlFile = $this->getDataSource()->getXML($recordID);
//            $xmlFile = $this->getDataSource()->getXML($hierarchyID);
        }
        else {
            $xmlFile = $this->getDataSource()->getXML($hierarchyID, array('subtree' => true));
//            $xmlFile = $this->getDataSource()->getXML($recordID, array('subtree' => true));
        }
//        $xmlFile = $this->getDataSource()->getXML($hierarchyID,array('recordID'=>$recordID,'foo'=>'bar'));

        $transformation = ucfirst($context) . ucfirst($mode);
        $xslFile = "Hierarchy/{$transformation}.xsl";

        return \Ida\XSLT\Processor::process($xslFile, $xmlFile, $params);
    }
}
