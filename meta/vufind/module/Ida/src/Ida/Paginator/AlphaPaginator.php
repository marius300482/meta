<?php
namespace Ida\Paginator;

use Zend\Paginator;

class AlphaPaginator extends Paginator\Paginator
{
	
	public function getLetters($page, $glue = '-')
	{
		$firstItem = $this->getItem(1, $page);
		$lastItem = $this->getItem(count($this->getItemsByPage($page)), $page);
		for ($prefixLen = 2; $prefixLen <= 3; $prefixLen++)
		{
			$firstLetters = mb_substr ( $firstItem ['displayText'], 0, $prefixLen);
			$lastLetters = mb_substr ( $lastItem ['displayText'], 0, $prefixLen);
			if (strcmp($firstLetters, $lastLetters) < 0) break;
		}
		return $firstLetters . $glue . $lastLetters; 
	}
	
	public function getAlphaPages()
	{
		$alphaPages = array();
		$lastPrefix = '';
		$count = $this->count();
		for ($page = 1; $page <= $count; $page++)
		{
			foreach ($this->getItemsByPage($page) as $item)
			{
				$prefix =  mb_substr($item['displayText'], 0, 1);
				if (strcmp($lastPrefix, $prefix) != 0)
				{
					if (!empty($lastPrefix))
					{
						$alphaPages[$lastPrefix]['last'] = $page;
					}
					$alphaPages[$prefix] = array('first' => $page);
					$lastPrefix = $prefix;
				}
			}
		}
		if (!empty($lastPrefix))
		{
			$alphaPages[$lastPrefix]['last'] = $count;
		}
		return $alphaPages;
	}
} 