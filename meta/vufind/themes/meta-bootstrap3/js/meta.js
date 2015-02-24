// Show all institution facets
$(function(){
    moreFacets('institution');
});

// Register "closer" element to clear search fields
$(window).load(function() {
    $(".closer").click(function () {
        $(this).parent().find("input:visible").first().val("");
    });
});

// Patching the typeahead library. Submitting the form after selection
$(window).load(function() {
    $('.autocomplete').bind('typeahead:selected', function(obj) {
        $(obj.target).closest('form').first().submit();
    });
});
