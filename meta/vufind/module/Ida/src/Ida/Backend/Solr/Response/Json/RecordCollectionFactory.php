<?php

/**
 * Simple JSON-based factory for record collection.
 *
 * PHP version 5
 *
 * Copyright (C) Villanova University 2010.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * @category VuFind2
 * @package  Search
 * @author   David Maus <maus@hab.de>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org
 */

namespace Ida\Backend\Solr\Response\Json;

use VuFindSearch\Response\RecordCollectionFactoryInterface;
use VuFindSearch\Exception\InvalidArgumentException;

/**
 * Simple JSON-based factory for record collection.
 *
 * @category VuFind2
 * @package  Search
 * @author   David Maus <maus@hab.de>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     http://vufind.org
 */
class RecordCollectionFactory implements RecordCollectionFactoryInterface
{
    /**
     * Factory to turn data into a record object.
     *
     * @var Callable
     */
    protected $recordFactory;

    /**
     * Class of collection.
     *
     * @var string
     */
    protected $collectionClass;

    /**
     * Constructor.
     *
     * @param Callable $recordFactory   Callback to construct records
     * @param string   $collectionClass Class of collection
     *
     * @return void
     */
    public function __construct($recordFactory = null,
        $collectionClass = 'Ida\Backend\Solr\Response\Json\RecordCollection'
//        $collectionClass = 'VuFindSearch\Backend\Solr\Response\Json\RecordCollection'
    ) {
        if (null === $recordFactory) {
            $this->recordFactory = function ($data) {
//                return new \VuFind\RecordDriver\SolrDefault(null,$data);
//                return new \Ida\RecordDriver\SolrArchive($data);
//                return new \Ida\RecordDriver\SolrLibrary($data);
                return new \VuFindSearch\Backend\Solr\Response\Json\Record($data);
                //todo: use vufind record class?
//                return new Record($data);
            };
        } else {
            $this->recordFactory = $recordFactory;
        }
        $this->collectionClass = $collectionClass;
    }

    /**
     * Return record collection.
     *
     * @param array $response Deserialized JSON response
     *
     * @return RecordCollection
     */
    public function factory($response)
    {
        if (!is_array($response)) {
            throw new InvalidArgumentException(
                sprintf(
                    'Unexpected type of value: Expected array, got %s',
                    gettype($response)
                )
            );
        }
        $collection = new $this->collectionClass($response);

        // todo: unterscheide "has groups" oä, wichtig fuer record-ansicht, zb http://localhost/meta/Record/36855fmt
        $collectionGroups = $collection->getGroups();
        $collectionHasGroups = 0 < count($collectionGroups);

        if (true === $collectionHasGroups) {

            $groupFieldId = reset(array_keys($collectionGroups));

            foreach ($collectionGroups[$groupFieldId]['groups'] as $group) {

                $docs = $group['doclist']['docs'];

                // Get first doc (as parent doc)
                $docFirst = reset($docs);

                // Do sub records exist?
                if (1 < count($docs)) {

                    // Create new collection for sub records
                    $collectionSub = new $this->collectionClass($docs);

                    // Merge topics of all sub records
                    $topics = array();

                    foreach ($docs as $doc) {

                        $doc['_isSubRecord'] = true;

                        // Add each grouped record to sub collection
                        $collectionSub->add(call_user_func($this->recordFactory, $doc));

                        // Merge topics, if available
                        if (array_key_exists('topic', $doc) && true === is_array($doc['topic'])) {
                            $topics = array_merge($topics, $doc['topic']);
                        }
                    }

                    // Remove topic duplicates
                    $docFirst['topic'] = array_unique($topics);

                    $docFirst['_subRecords'] = $collectionSub;
                }

                $collection->add(call_user_func($this->recordFactory, $docFirst));
            }
        }
        else {

            if (isset($response['response']['docs'])) {
                foreach ($response['response']['docs'] as $doc) {
                    $collection->add(call_user_func($this->recordFactory, $doc));
                }
            }
        }

        return $collection;
    }

}