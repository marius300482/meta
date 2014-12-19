<?php
/**
 * Hierarchy Tree Renderer for the JS_Tree plugin
 *
 * PHP version 5
 *
 * Copyright (C) Villanova University 2010.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * @category VuFind2
 * @package  HierarchyTree_Renderer
 * @author   Luke O'Sullivan <l.osullivan@swansea.ac.uk>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/vufind2:hierarchy_components Wiki
 */
namespace Ida\Hierarchy\TreeRenderer;

/**
 * Hierarchy Tree Renderer
 *
 * This is a helper class for producing hierarchy trees.
 *
 * @category VuFind2
 * @package  HierarchyTree_Renderer
 * @author   Luke O'Sullivan <l.osullivan@swansea.ac.uk>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org/wiki/vufind2:hierarchy_components Wiki
 */

class JSTree extends \VuFind\Hierarchy\TreeRenderer\JSTree
{

    /**
     * transformCollectionXML
     *
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
        //$recordID=10464genderbib
        //
        //$hierarchyID=0Genderbiblgenderbib
        //$inHierarchies=0Genderbiblgenderbib
        //$inHierarchiesTitle=0 Genderbibliothek Aufstellung
        //$hierarchyTitle=0 Genderbibliothek Aufstellung
        //---
        //$this->getDataSource() : VuFind\Hierarchy\TreeDataSource\Solr
//        var_dump($hierarchyID,get_class($record),$inHierarchies,$inHierarchiesTitle,$hierarchyTitle);
//        var_dump(get_class($this->getDataSource()));
        //edit:dku
        // TODO: auslagern an richtige stelle
        if (isset($_REQUEST['subtree'])) {
            $recordID = '';
        }

        // Set up parameters for XSL transformation
        $params = array(
            'titleText' => $this->translate('collection_view_record'),
//            'collectionID' => '0Genderbiblgenderbib',
            'collectionID' => $hierarchyID,
            'collectionTitle' => $hierarchyTitle,
            'baseURL' => '%%%%VUFIND-BASE-URL%%%%',
            'context' => $context,
            'recordID' => $recordID
        );

        // Transform the XML
        //edit:dku
//        // TODO: auslagern an richtige stelle
//        if (isset($_REQUEST['subtree'])) {
//            $recordID = '';
//        }
//        $tstart=microtime(true);
//        throw new \Exception('help wanted');
//        var_dump(func_get_args(),$_REQUEST['subtree']);exit;
        $xmlFile = $this->getDataSource()->getXML($hierarchyID,array('recordID'=>$recordID,'foo'=>'bar'));
//        print __METHOD__.'<br>';
//        print htmlspecialchars(substr($xmlFile,0,1113500));
//        exit;
//        $xmlFile = $this->getDataSource()->getXML($hierarchyID);
//        printf('time=%3f',microtime(true)-$tstart);exit;
        $transformation = ucfirst($context) . ucfirst($mode);
        $xslFile = "Hierarchy/{$transformation}.xsl";
//        $xslFile='Hierarchy/RecordTree.xsl';
//        var_dump($xslFile);
//        print '<br><br>proc='.htmlspecialchars(substr(\Ida\XSLT\Processor::process($xslFile, $xmlFile, $params),0,1113500));
//        exit;
        return \Ida\XSLT\Processor::process($xslFile, $xmlFile, $params);
//        return \VuFind\XSLT\Processor::process($xslFile, $xmlFile, $params);
    }
}
