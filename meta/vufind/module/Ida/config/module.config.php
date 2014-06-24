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
        ),
    ),
    'controllers' => array(
        'factories' => array(
            'topics' => array('Ida\Factory', 'getTopicsController'),
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
                    /*'list' => array(
                       'controller' => 'Topics',
                        'action'     => 'List',
                    ),*/
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
        ),
    ),
);

return $config;