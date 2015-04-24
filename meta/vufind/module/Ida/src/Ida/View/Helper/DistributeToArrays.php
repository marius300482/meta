<?php
/**
 * Array distributor view helper
 *
 * @package  View_Helpers
 */
namespace Ida\View\Helper;

/**
 * Distribute elements of a one dimensional array to multiple sub-arrays
 *
 * @package  View_Helpers
 */
class DistributeToArrays extends \Zend\View\Helper\AbstractHelper
{
    /**
     * Distribute elements of a one dimensional array to multiple sub-arrays
     *
     * @param $array array One dimensional array, containing the elements to distribute
     * @param $subArraysLengths array An array containing the max amount of elements for each sub array to create
     * @return array Array with the requested amount of sub arrays and elements
     */
    public function __invoke(array $array, array $subArraysLengths)
    {
        $result = array();

        foreach($subArraysLengths as $length) {
            // Create empty sub-arrays
            $subArray = array();
            // Fill the sub-arrays
            for($i = 0; $i < $length; $i++) {
                if (0 < count($array)) {
                    $subArray[] = array_shift($array);
                } else {
                    break;
                }
            }
            $result[] = $subArray;
        }

        return $result;
    }
}