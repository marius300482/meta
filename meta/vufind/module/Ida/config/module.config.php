<?php
namespace Ida\Module\Configuration;

$config = array(
    'vufind' => array(
        'plugin_managers' => array(
            'recorddriver' => array(
                'factories' => array(
                    'solrlibrary' => array('Ida\Factory', 'getSolrLibrary'),
                    'solrarchive' => array('Ida\Factory', 'getSolrArchive'),
                    'solrsystematics' => array('Ida\Factory', 'getSolrSystematics'),
                ),
            ),
        ),
        'recorddriver_tabs' => array(
            // Disable Holdings, Comments and  Staff View
            'Ida\RecordDriver\SolrIDA' => array(
                'tabs' => array (
                    //'Holdings' => 'HoldingsILS',
                    //'Description' => 'Description',
                    'TOC' => 'TOC',
                    //'UserComments' => 'UserComments',
                    'Reviews' => 'Reviews',
                    'Excerpt' => 'Excerpt',
                    'HierarchyTree' => 'HierarchyTree',
                    'Map' => 'Map',
                    'Details' => 'StaffViewArray',
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
                        'action'     => 'Home',
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