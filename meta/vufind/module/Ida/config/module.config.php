<?php
namespace Ida\Module\Configuration;

$config = array(
    'vufind' => array(
        'plugin_managers' => array(
            'recorddriver' => array(
                'factories' => array(
                    'solrlibrary' => array('Ida\Factory', 'getSolrLibrary'),
                    'solrarchive' => array('Ida\Factory', 'getSolrArchive'),
                    'solrsystematik' => array('Ida\Factory', 'getSolrSystematik'),
                ),
            ),
//            'hierarchy_driver' => array(
//                'factories' => array(
//                    'default' => array('VuFind\Hierarchy\Driver\Factory', 'getHierarchyDefault'),
//                    'flat' => array('VuFind\Hierarchy\Driver\Factory', 'getHierarchyFlat'),
//                ),
//            ),
            'hierarchy_treedatasource' => array(
                'factories' => array(
                    //edit:dku
                    'solr1337' => array('Ida\Hierarchy\TreeDataSource\Factory', 'getSolr'),
//                    'solr' => array('VuFind\Hierarchy\TreeDataSource\Factory', 'getSolr'),
                ),
                'invokables' => array(
                    'xmlfile' => 'VuFind\Hierarchy\TreeDataSource\XMLFile',
                ),
            ),
        // --- das hier bleibt
            'hierarchy_treerenderer' => array(
                'invokables' => array(
                    'jstree' => 'Ida\Hierarchy\TreeRenderer\JSTree',
                )
            ),
        ),
        'recorddriver_tabs' => array(
            // Disable Holdings and  Staff View
            'Ida\RecordDriver\SolrIDA' => array(
                'tabs' => array (
                    'Description' => 'Description',
                    'TOC' => 'TOC',
                    'UserComments' => 'UserComments',
                    'Reviews' => 'Reviews',
                    'Excerpt' => 'Excerpt',
                    'HierarchyTree' => 'HierarchyTree',
                    'Map' => 'Map',
                ),
                'defaultTab' => null,
            ),
        ),
    ),
    'controllers' => array(
        'factories' => array(
            'topics' => array('Ida\Factory', 'getTopicsController'),
        ),
        'invokables' => array(
            'idaoai' => 'Ida\Controller\IdaOaiController',
        ),
    ),
    'router' => array(
        'routes' => array(
            'topics' => array(
                'type' => 'Zend\Mvc\Router\Http\Literal',
                'options' => array(
                    'route'    => '/Topics',
                    'defaults' => array(
                        'controller' => 'Topics',
                        'action'     => 'Cloud',
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    'list' => array(
                        'type' => 'Zend\Mvc\Router\Http\Literal',
                        'options' => array(
                            'route'    => '/List',
                            'defaults' => array(
                                'controller' => 'Topics',
                                'action'     => 'List',
                            )
                        )
                    ),
                ),
            ),
            'idaoai' => array(
                'type' => 'Zend\Mvc\Router\Http\Literal',
                'options' => array(
                    'route'    => '/OAI/Server',
                    'defaults' => array(
                        'controller' => 'idaoai',
                        'action'     => 'Server',
                    ),
                ),
            ),
        ),
    ),
    'view_helpers' => array(
        'factories' => array(
            'piwikanalytics' => array('Ida\View\Helper\Factory', 'getPiwikAnalytics'),
        ),
    ),
);

return $config;