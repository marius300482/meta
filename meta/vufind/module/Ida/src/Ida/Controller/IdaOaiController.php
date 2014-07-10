<?php
/**
 * Controller delegates to customized Oai Server.
 * User: boehm
 * Date: 10.07.14
 * Time: 14:36
 */

namespace Ida\Controller;


class IdaOaiController extends  \VuFind\Controller\OaiController{

    /**
     * Customized OAI server for Ida.
     *
     * @return \Zend\Http\Response
     */
    public function serverAction()
    {
        return $this->handleOAI('Ida\OAI\Server');
    }
} 