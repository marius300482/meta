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
);

return $config;