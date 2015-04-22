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

    public function getAllInstitutions()
    {
        $institutionDirContent = scandir($this->institutionDir);
        $fileEnding = "_" . $this->language . ".ini";
        $fileEndingIndex = -1 * strlen($fileEnding);
        $institutions = array();

        // Get all institutions which fir to the current language
        foreach ($institutionDirContent as $file)
        {
            if ($fileEnding === substr($file, $fileEndingIndex)) {
                $this->institutionId = substr($file, 0, $fileEndingIndex);
                $institutions[] = $this->getInstitutionDetails();
            }
        }

        var_dump($institutions);

        // Parse all ini

die();
        return array(
            "Germany" => array(
                "Alice Salomon Archiv der ASH Berlin",
                "Archiv der deutschen Frauenbewegung",
                "Archiv des Lette-Vereins",
                "Archiv Frau und Musik",
                "Archiv zur Geschichte von Tempelhof und Schöneberg in Berlin",
                "ausZeiten, Bildung, Information, Forschung und Kommunikation für Frauen e.V.",
                "BAF e.V., Bildungszentrum und Archiv zur Frauengeschichte Baden-Württembergs",
                "belladonna, Kultur, Bildung und Wirtschaft für Frauen e.V.",
                "D.I.W.A. - FrauenForschungsStelle Münster e.V.",
                "DENKtRÄUME - hamburger frauenbibliothek in Kooperation mit Landesfrauenrat Hamburg e.V.",
                "Feministisches Archiv Marburg",
                "Frauen-Kultur-Archiv/ Genderforschungs-Transferstelle",
                "Frauenarchiv Dortmund - Universitätsbibliothek Dortmund",
                "Frauenbibliothek des Autonomen Frauenreferats",
                "Frauenforschungs-, -bildungs- und -informationszentrum FFBIZ e.V.",
                "FrauenGenderBibliothek Saar",
                "FrauenMediaTurm, Das Archiv und Dokumentationszentrum",
                "FrauenStadtArchiv Dresden / FrauenBildungsHaus Dresden e.V.",
                "Genderbibliothek am Zentrum für transdisziplinäre Geschlechterstudien",
                "GrauZone, Dokumentationsstelle zur nichtstaatlichen Frauenbewegung in der DDR",
                "Helene-Lange-Archiv",
                "Kölner Frauengeschichtsverein e.V.",
                "Lila ArchivZ e.V.",
                "LLL e.V. Lesbenarchiv Frankfurt am Main",
                "Louise-Otto-Peters-Archiv",
                "Madonna-Archiv des Vereins Madonna e.V. – Verein zur Förderung der beruflichen und kulturellen Bildung von Sexarbeiterinnen",
                "MONAliesA Leipzig Feministische Bibliothek",
                "Spinnboden Lesbenarchiv und Bibliothek e.V.",
                "Studentische Frauenbibliothek Lieselle",
                "Terre des Femmes Dokumentationsstelle",
                "Zentrum GenderWissen - Zentrale Bibliothek Frauenforschung & Gender Studies Hamburg"
            ),
            "Italy" => array(
                "Frauenarchiv Bozen - Archivio storico delle donne"
            ),
            "Luxembourg" => array(
                "Cid | Fraen an Gender"
            ),
            "Austria" => array(
                "Frauen*solidarität feministisch-entwicklungspolitische Informations- und Bildungsarbeit",
                "im C3 – Centrum für Internationale Entwicklung",
                "FRIDA - Verein zur Förderung und Vernetzung frauenspezifischer Informations- und Dokumentationseinrichtungen in Österreich",
                "Öffentliche Frauenbibliothek AEP",
                "Sammlung Frauennachlässe am Institut für Geschichte der Universität Wien",
                "STICHWORT, Archiv der Frauen- und Lesbenbewegung, Bibliothek · Dokumentation · Multimedia"
            ),
            "Swiss" => array(
                "frauen_bibliothek basel",
                "schema f"
            )
        );
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