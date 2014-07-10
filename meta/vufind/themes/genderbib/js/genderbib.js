$(document).ready(function() {

    // Slide down the main menu, when the user clicks on the menu opener button.
    $("#mainNavOpener, #menuNavOpenerLink").click(function () {
        $("#mainNav").slideDown();
        $("#mainNavOpener").fadeOut();
    });

});