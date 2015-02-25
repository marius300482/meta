<?php
/**
 * Ida XSLT wrapper
 *
 *
 * @see \VuFind\XSLT\Processor
 */
namespace Ida\XSLT;
use DOMDocument;
use XSLTProcessor;

/**
 * VuFind XSLT wrapper
 *
 * @see \VuFind\XSLT\Processor
 */
class Processor extends \VuFind\XSLT\Processor
{
    /**
     * Perform an XSLT transformation and return the results.
     *
     * @param string $xslt   Name of stylesheet (in application/xsl directory)
     * @param string $xml    XML to transform with stylesheet
     * @param string $params Associative array of XSLT parameters
     *
     * @return string      Transformed XML
     */
    public static function process($xslt, $xml, $params = array())
    {
        if (0 < strlen($xml)) {
            $style = new DOMDocument();
            // TODO: support local overrides
            $style->load(APPLICATION_PATH . '/module/Ida/xsl/' . $xslt);
            $xsl = new XSLTProcessor();
            $xsl->importStyleSheet($style);
            $doc = new DOMDocument();
            if ($doc->loadXML($xml)) {
                foreach ($params as $key => $value) {
                    $xsl->setParameter('', $key, $value);
                }
                return $xsl->transformToXML($doc);
            }
        }
        return '';
    }
}
