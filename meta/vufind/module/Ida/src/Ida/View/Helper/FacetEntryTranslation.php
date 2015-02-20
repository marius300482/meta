<?php
/**
 * Facet translation view helper
 *
 * @package  View_Helpers
 */
namespace Ida\View\Helper;

/**
 * Facet translation view helper
 *
 * @package  View_Helpers
 */
class FacetEntryTranslation extends \Zend\View\Helper\AbstractHelper
{
    /**
     * @var
     */
    private $facetNames;

    /**
     * @param $facetNames
     */
    public function __construct(Array $facetNames)
    {
        $this->facetNames = $facetNames;
    }

    /**
     * @param $facetName
     * @return bool
     */
    public function __invoke($facetName)
    {
        return in_array($facetName, $this->facetNames);
    }
}