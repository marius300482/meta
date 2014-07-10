<?php
/**
 * Customization odf OAI behaviour
 * User: boehm
 * Date: 10.07.14
 * Time: 14:46
 */

namespace Ida\OAI;


class Server extends \VuFind\OAI\Server
{

    /**
     * Get an array of information on non-deleted records in the specified range.
     * Excludes Systematik records.
     *
     * @param int    $from   Start date.
     * @param int    $until  End date.
     * @param int    $offset First record to obtain in full detail.
     * @param int    $limit  Max number of full records to return.
     * @param string $set    Set to limit to (empty string for none).
     *
     * @return \VuFind\Search\Base\Results Search result object.
     */
    protected function listRecordsGetNonDeleted($from, $until, $offset, $limit, $set = '')
    {
        $results = parent::listRecordsGetNonDeleted($from, $until, $offset, $limit, $set = '');
        $params = $results->getParams();
        $params->addFilter(
            '-' . $this->setField . ':Systemaktik');
        return $results;
    }
} 