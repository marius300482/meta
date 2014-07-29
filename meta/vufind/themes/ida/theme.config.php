<?php
return array(
    'extends' => 'blueprint',
    'css' => array(
        'idastyles.css:screen, projection',
/*
        'blueprint/screen.css:screen, projection',
        'blueprint/print.css:print',
        'blueprint/ie.css:screen, projection:lt IE 8',
        'jquery-ui/css/smoothness/jquery-ui.css',
        'styles.css:screen, projection',
        'print.css:print',
        'ie.css:screen, projection:lt IE 8',
*/
    ),
    'js' => array(
        'ida.js'
    ),
/*
    'favicon' => 'vufind-favicon.ico',
    'helpers' => array(
        'factories' => array(
            'layoutclass' => array('VuFind\View\Helper\Blueprint\Factory', 'getLayoutClass'),
        ),
        'invokables' => array(
            'search' => 'VuFind\View\Helper\Blueprint\Search',
        )
    )
*/
);