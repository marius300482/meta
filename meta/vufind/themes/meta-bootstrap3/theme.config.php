<?php
return array(
    'extends' => 'bootstrap3',
    'css' => array(
        'metastyles.css:screen, projection',
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
        'meta.js',
    /*
        ,'jquery.min.js',
        'jquery.form.js',
        'jquery.metadata.js',
        'jquery.validate.min.js',
        'jquery-ui/js/jquery-ui.js',
        'lightbox.js',
        'common.js',*/
    ),
    'favicon' => 'favicon.ico',
    'helpers' => array(
        'factories' => array(
            // View helper to display a record
            'record' => 'Ida\View\Helper\Root\Factory::getRecord',
//            'layoutclass' => array('VuFind\View\Helper\Blueprint\Factory', 'getLayoutClass'),
        ),
//        'invokables' => array(
//            'search' => 'VuFind\View\Helper\Blueprint\Search',
//        )
    ),
);