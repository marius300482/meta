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
     * @var null|String
     */
    private $institutionId;

    /**
     * Local path where the institutions are stored
     *
     * @var string
     */
    private $institutionDir;

    /**
     * Constructor
     *
     * @param $institutionId Identifier of an institution
     */
    public function __construct($institutionId)
    {
        $this->institutionId = $institutionId;
        $this->institutionDir = APPLICATION_PATH . "/module/Ida/data/institutions/";
    }

    /**
     * Returns all details about an institution, if a corresponding
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
                // TODO log errors
            }
        }

        return $details;
    }

    /**
     * Returns the file name for a given institution id.
     * Removed all chars which can cause security problems.
     *
     * @return string
     */
    private function getInstitutionFileName()
    {
        return preg_replace("/[^0-9a-zA-Z_-öäüßÄÖÜ]/", "", $this->institutionId) . ".ini";
    }
}