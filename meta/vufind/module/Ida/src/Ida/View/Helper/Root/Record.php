<?php
/**
 * Record driver view helper
 *
 * @category Ida
 * @package  View_Helpers
 * @author   <dku@outermedia.de>
 */
namespace Ida\View\Helper\Root;

class Record extends \VuFind\View\Helper\Root\Record {

    /**
     * Render a sub record to be displayed in a search result list.
     *
     * @author <dku@outermedia.de>
     * @return string the rendered sub record
     */
    public function getSubRecord() {

        return $this->renderTemplate('result-list.phtml');
    }
}