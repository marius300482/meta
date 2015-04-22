<?php
/**
 * User: boehm
 * Date: 6/11/14
 * Time: 12:02 PM
 */

namespace Ida\Controller;

use VuFind\Controller\BrowseController;
use VuFind\RecordDriver\SolrDefault;
use Zend\Config\Config;
use Zend\View\Model\ViewModel;

class TopicsController extends BrowseController
{
    /**
     * VuFind configuration
     *
     * @var Config
     */
    protected $config;
    private $limit;
    private $alpha;

    public function __construct(Config $config)
    {
        $this->config = $config;
        $this->config = new Config($config->toArray(), true);
        $this->limit = $this->config->Browse->result_limit;
        $this->alpha = $this->config->Browse->alphabetical_order;
    }

    private function changeConfigForList()
    {
        $this->config->Browse->result_limit = -1;
        $this->config->Browse->alphabetical_order = true;
    }

    private function restoreConfig()
    {
        $this->config->Browse->result_limit = $this->limit;
        $this->config->Browse->alphabetical_order = $this->alpha;
    }

    public function listAction()
    {
        $prefix = $this->getRequest()->getQuery()->get('facet_prefix');
        $parameters = $this->getRequest()->getQuery();

        // Default to 'A' in case no prefix is given
        if ($prefix == null || $prefix == '') {
            $parameters->set('facet_prefix', 'A');
            $this->getRequest()->setQuery($parameters);
        }
        $this->changeConfigForList();
        $topics = $this->getFacetList('topic_facet', 'topic_facet', 'alphabetical', $parameters->get('facet_prefix') . '*');
        $this->restoreConfig();

        $view = $this->createViewModel('topics/list');
        $view->topics = $topics;
        $view->paginationChars = $this->getAlphabetList();
        $view->currentChar = $parameters->get('facet_prefix');
        $view->driver = new SolrDefault();
        return $view;
    }

    public function homeAction()
    {
        $view = $this->createViewModel('topics/home');
        $view->topics = $this->getTagCloud();
        $view->institutions = $this->getInstitutions();
        $view->inventoryFacet = $this->getInventoryfacet();
        $view->solrDriver = new SolrDefault();
        $view->randomBooks = $this->getRandomItems();
        return $view;
    }

    public function getTagCloud()
    {
        $topics = $this->getTopics();

        $max_font = $this->config->TopicsCloud->fontsize != null ? $this->config->TopicsCloud->fontsize : 50;
        $maxcount=reset($topics);
        $keyword_weight_ratio = (float)($max_font / (float)$maxcount['count']);

        foreach ($topics as &$topic) {
            $topic['weight'] = round($topic['count'] * $keyword_weight_ratio);
        }

        $alpha = $this->config->TopicsCloud->alpha;
        if (!isset($alpha) || $alpha) {
            usort($topics, function ($a, $b) {
                return $a['displayText'] > $b['displayText'];
            });
        }

        return $topics;
    }

    public function getInventoryfacet() {
        $colors = array(
            "#990099", "#29AAE3", "#01009A",
            "#FF931E", "#C1272D", "#8CC53F"
        );
        // Get content of the format cell as array
        $facetContent = $this->getFacetList('format', 'format', 'count', '*');
        // Add values which are required for presentation
        for ($i = 0; $i < count($facetContent); $i++) {
            // Add percentage
            $maxCount = $facetContent[0]['count'];
            $currentCount = $facetContent[$i]['count'];
            $percent = 0 < $maxCount ? (100 / $maxCount) * $currentCount : 0;
            $facetContent[$i]['percent'] = round($percent, 2);
            // Add color
            $facetContent[$i]['color'] = $i < count($colors) ? $colors[$i] : "#000000";
        }

        return $facetContent;
    }

    protected function getRandomItems()
    {
        $idSourceFile = APPLICATION_PATH . "/module/Ida/data/randomItems.ini";
        $maxItems = 3;
        $randomIds = array();
        $result = array();
        try {
            // Read the .ini file
            $reader = new \Zend\Config\Reader\Ini();
            $ini = (array) $reader->fromFile($idSourceFile);
            // Get the item ids if there are any in the .ini file
            $itemIds = isset($ini['item']) ? $ini['item'] : array();
            shuffle($itemIds);
            // Get 3 array keys randomly from the $itemIds array
            $randomIds = $maxItems < count($itemIds) ? array_rand($itemIds, $maxItems) : $itemIds;
        } catch (\Zend\Config\Exception\RuntimeException $error) {}

        // Read items from Solr
        foreach ($randomIds as $randomId) {
            try {
                $result[] = $this->getRecordLoader()->load($itemIds[$randomId], "Solr");
            } catch (\VuFind\Exception\RecordMissing $error) {}
        }

        return $result;
    }

    protected function getInstitutions()
    {
        $institutionList = array(
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

        return $institutionList;
    }

    protected function createViewModel($template = null, $params = null)
    {
        $view = new ViewModel();
        $view->setTemplate($template);

        return $view;
    }

    private function getTopics()
    {
        $results = $this->getFacetList('topic_facet');

        return $results;
    }
}