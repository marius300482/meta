// Show all institution facets
$(function(){
    moreFacets('institution');
});

// Register "closer" element to clear search fields
// And advanced search from when clicking the reset button
$(window).load(function() {
    $(".closer").click(function () {
        $(this).parent().find("input:visible").first().val("");
    });
    $("input[type='reset']").click(function () {
        var form = $(this).parents("form");
        form.find("input[type='text']").attr("value", "");
        form.find("option").removeAttr("selected");
    });
});

// Patching the typeahead library. Submitting the form after selection
$(window).load(function() {
    $('.autocomplete').bind('typeahead:selected', function(obj) {
        $(obj.target).closest('form').first().submit();
    });
});
