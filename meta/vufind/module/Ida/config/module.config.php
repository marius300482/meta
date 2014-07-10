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
                    'route'    => '/OAI/IDA',
                    'defaults' => array(
                        'controller' => 'idaoai',
                        'action'     => 'Server',
                    ),
                ),
            ),
        ),
    ),
);

return $config;