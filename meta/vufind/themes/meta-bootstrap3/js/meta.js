// Show all institution facets
$(function(){
    moreFacets('institution');
});

// Register "closer" element to clear search fields
// And advanced search from when clicking the reset button
$(window).load(function() {
    $("#simple-search-body").find(".closer").click(function () {
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

// Allow simple search, if at least X chars have been entered
$(window).load(function() {
    $('#searchForm').submit(function() {
        var minRequiredChars = 1,
            textField = $(this).find("#searchForm_lookfor");

        if (textField.length) {
            return minRequiredChars <= textField.val().trim().length;
        }

        return true;
    });
});

// Make sections collapsible in mobile view
$(document).ready(function () {
    var maxMobileWidth = 758; // px
    var headlines = $("*[data-section-toggle], *[data-sidebar-toggle] h4");
    var sections = headlines.next();
    var lastWidth = -1;
    var documentWidth;
    if (headlines.length) {
        // Hide sections on mobile devices
        $(window).bind("load resize", function () {
            documentWidth = $(document).width();
            if (lastWidth !== documentWidth) { // ignore height resize
                if (documentWidth <= maxMobileWidth) {
                    sections.hide()
                } else {
                    sections.show();
                }
                headlines.removeClass("open");
                lastWidth = documentWidth;
            }
        });
        // Make sections toggleable on mobile devices
        headlines.click(function () {
            if (documentWidth <= maxMobileWidth) {
                var $this = $(this);
                $this.next().slideToggle("normal", function () {
                    $this.toggleClass("open");
                });
            }
        });
    }
});