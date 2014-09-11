<?php
return array(
    'extends' => 'ida',
    'css' => array(
        'genderbibstyles.css:screen, projection'
        /*,'idastyles.css:screen, projection',*/
    ),
    /*'css' => array(
        'blueprint/screen.css:screen, projection',
        'blueprint/print.css:print',
        'blueprint/ie.css:screen, projection:lt IE 8',
        'jquery-ui/css/smoothness/jquery-ui.css',
        'styles.css:screen, projection',
        'print.css:print',
        'ie.css:screen, projection:lt IE 8',
    ), */
    'js' => array(
        'genderbib.js'
        /*
        ,'jquery.min.js',
        'jquery.form.js',
        'jquery.metadata.js',
        'jquery.validate.min.js',
        'jquery-ui/js/jquery-ui.js',
        'lightbox.js',
        'common.js',
        */
    ),
    'favicon' => 'favicon.ico',
    'helpers' => array(
        'factories' => array(
            'piwikanalytics' => array('Ida\View\Helper\Factory', 'getPiwikAnalytics'),
//            'layoutclass' => array('VuFind\View\Helper\Blueprint\Factory', 'getLayoutClass'),
        ),
//        'invokables' => array(
//            'search' => 'VuFind\View\Helper\Blueprint\Search',
//        )
    )
);