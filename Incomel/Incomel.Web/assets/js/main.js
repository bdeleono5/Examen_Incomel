(function ($) {

    "use strict";

    var fullHeight = function () {

        $('.js-fullheight').css('height', $(window).height());
        $(window).resize(function () {
            $('.js-fullheight').css('height', $(window).height());
        });

    };
    fullHeight();

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });

})(jQuery);

function goTo(resultado) {
    if (resultado == null) {
        $("html, body").animate({ scrollTop: $(document).height() }, 'slow');
    } else {
        $('html, body').animate({ scrollTop: resultado.scrollHeight }, 'slow');
    }
}

function Holdon_Open(message) {
    var options = {
        theme: "sk-rect",
        message: message,
        backgroundColor: "#1847B1",
        textColor: "white"
    };

    HoldOn.open(options);
}

function Holdon_Close() {
    HoldOn.close();
}