/*
Submit search form on select of auto suggestion
 */
function initAutocomplete() {
    $('input.autocomplete').each(function() {
        var lastXhr = null;
        var params = extractParams($(this).attr('class'));
        var maxItems = params.maxItems > 0 ? params.maxItems : 10;
        var $autocomplete = $(this).autocomplete({
            source: function(request, response) {
                var type = params.type;
                if (!type && params.typeSelector) {
                    type = $('#' + params.typeSelector).val();
                }
                var searcher = params.searcher;
                if (!searcher) {
                    searcher = 'Solr';
                }
                // Abort previous access if one is defined
                if (lastXhr !== null && typeof lastXhr["abort"] != "undefined") {
                    lastXhr.abort();
                }
                lastXhr = $.ajax({
                    url: path + '/AJAX/JSON',
                    data: {method:'getACSuggestions',type:type,q:request.term,searcher:searcher},
                    dataType:'json',
                    success: function(json) {
                        if (json.status == 'OK' && json.data.length > 0) {
                            response(json.data.slice(0, maxItems));
                        } else {
                            $autocomplete.autocomplete('close');
                        }
                    }
                });
            },
            select: function(event, ui) {
                $(event.target).closest('form').first().submit();

            }
        });
    });
}