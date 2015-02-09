<?php
/**
 * Institution
 *
 * @package  Institution
 * @author   phe
 */
namespace Ida\Institution;

use Zend\Config\Reader\Ini;
use Zend\Config\Exception;

/**
 * Delivers institution details
 *
 * @package  Institution
 * @author   phe
 */
class Institution
{

    /**
     * Identifier of an institution
     *
     * @var String
     */
    private $institutionId;

    /**
     * Language identifier
     *
     * @var String
     */
    private $language;

    /**
     * Local path where the institutions are stored
     *
     * @var String
     */
    private $institutionDir;

    /**
     * Constructor
     *
     * @param String $institutionId Identifier of an institution
     * @param String $language Language identifier
     */
    public function __construct($institutionId, $language)
    {
        $this->institutionId = $institutionId;
        $this->language = $language;
        $this->institutionDir = APPLICATION_PATH . "/module/Ida/data/institutions/";
    }

    /**
     * Return all details about an institution, if a corresponding
     * file exists in the file system.
     *
     * @return array
     */
    public function getInstitutionDetails()
    {
        $details = array();
        $fileName = $this->institutionDir . $this->getInstitutionFileName();

        // Check if the institution file exists
        if (is_readable($fileName))
        {
            // Try to parse the file and return the result
            $reader = new Ini();

            try {
                $details = (array) $reader->fromFile($fileName);
            }
            catch (Exception\RuntimeException $error)
            {
                // TODO log error?
            }
        }
        else
        {
            // TODO log error?
        }

        return $details;
    }

    /**
     * Return the file name for a given institution id and
     * remove all chars which can cause (security) problems
     *
     * @return string
     */
    private function getInstitutionFileName()
    {
        return preg_replace("/[^0-9a-zA-Z_\-öäüßÄÖÜ]/", "", $this->institutionId) . "_" . $this->language . ".ini";
    }
}