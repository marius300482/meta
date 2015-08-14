<?php
namespace Ida\RecordTab;

use VuFindSearch\Service as SearchService;
use VuFindSearch\Query\Query;

/**
 * OtherInstitutions tab
 */
class OtherInstitutions extends \VuFind\RecordTab\AbstractBase
{
	protected $searchService; 
	protected $otherInstitutions;
	
	
	public function __construct(SearchService $searchService)
	{
		$this->searchService = $searchService;
    }
    
    public function isActive()
    {
    	return !empty($this->getOtherInstitutions());
    }
	
	public function getOtherInstitutions()
	{
		if (!$this->otherInstitutions)
		{
			$this->otherInstitutions = $this->query();
		}
		return $this->otherInstitutions;
	}
	
	protected function query()
	{
		$other = array();
		$groupId = $this->driver->getGroupID();
		$currentInstitution = $this->driver->getInstitution()[0];
		
		// Lookup records of other institutions with same groupID
		$query = new Query(
				'groupID:"' . $groupId . '"' .
				' -institution:"' . $currentInstitution . '"'
		);
		
		$collection = $this->searchService->search(
				'Solr', $query, 0, 50, NULL
		);
		
		if ($collection->getTotal() > 0) 
		{
			$records = ($collection->isGrouped() && $collection->first()->getSubRecords()) ? 
					$collection->first()->getSubRecords()->getRecords() : 
					$collection->getRecords();
			
			foreach ($records AS $record)
			{
				$institution = $record->getInstitution()[0];
				$other[$institution] = $record;
			}	
		}
		return $other; 
	}
	

	/**
	 * Get the on-screen description for this tab.
	 *
	 * @return string
	 */
	public function getDescription()
	{
		return 'other_institutions';
	}
	
}