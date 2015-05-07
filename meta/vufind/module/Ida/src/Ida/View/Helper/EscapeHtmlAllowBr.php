<?php
/**
 * Escape HTML view helper
 *
 * @package  View_Helpers
 */
namespace Ida\View\Helper;

use Zend\View\Helper\Escaper\AbstractHelper;

/**
 * HTML view helper
 *
 * @package  View_Helpers
 */
class EscapeHtmlAllowBr extends AbstractHelper
{
    /**
     * Escape all HTML except <br>
     *
     * @param string $html
     * @return string
     */
    public function escape($html)
    {
        $escapedHtml = $this->getEscaper()->escapeHtml($html);

        return preg_replace('/&lt;br\s*\/?&gt;/i', '<br />', $escapedHtml);
    }
}