    if ($('#testimonial').length > 0) {
        LixiGlobal.Slider.carousel('#testimonial');
    }
    //LixiGlobal.Theme.initTheme();

    //$('.nav-login-event, .nav-register-event').click(function () {
    //LixiGlobal.User.registerPopup();
    //});

    $('[rel=tooltip]').tooltip();
    LixiGlobal.Menu.effectMainMenu();
    jQuery(window).resize(function () {
        LixiGlobal.Menu.effectMainMenu();
    });
    if ($('.gift-filter-slider-input').length > 0) {
        var sliderFilter = new Slider('.gift-filter-slider-input', {
            tooltip: 'always',
            formatter: function (value) {
                //Call filter here
                return "USD $" + value + " ~ VND " + (value * LixiGlobal.Const.VND).formatCurency();
            }
        });
        /*
         sliderFilter.on("slide", function (slideEvt) {
         //Call filter when change value here
         if(originalSliderVal != slideEvt){
         sliderFilter.disable();
         alert(slideEvt);
         //
         originalSliderVal = slideEvt;
         }
         console.log(slideEvt);
         });
         */
        sliderFilter.on("slideStart", function (slideEvt) {
            //Call filter when change value here
            //alert(slideEvt);
            //
            originalSliderVal = slideEvt;
            console.log(slideEvt);
        });
        sliderFilter.on("slideStop", function (slideEvt) {
            //Call filter when change value here
            if (originalSliderVal != slideEvt) {
                //sliderFilter.disable();
                //alert("change " + slideEvt);
                //
                originalSliderVal = slideEvt;

                loadNewPrice(slideEvt);
            }
            console.log(slideEvt);
        });

    }

    //if ($('.custom-checkbox-input').length > 0) {
    //    LixiGlobal.Form.initCheckBox('.custom-checkbox-input');
    //}

    /* dumy event */
    $('.btn-has-link-event').click(function () {
        window.location = $(this).attr('data-link');
    });

    if ($('.selectpicker').length > 0) {
        $('.selectpicker').selectpicker();
    }

    if ($('.post-content-has-scroll').length > 0) {
        $(window).load(function () {
            $('.post-content-has-scroll').mCustomScrollbar();
        });
    }
    if ($('.form-add-a-payment').length > 0) {
        $('.form-add-a-payment').validate();
    }

    if ($('.quality-event').length > 0) {
        LixiGlobal.Quality.star('.quality-event');
    }
    if ($('.btn-support-chat-event').length > 0) {
        $('.btn-support-chat-event').click(function () {
            LixiGlobal.Chat.showPopup();
        });

    }
    if ($('.btn-support-chat-event-init').length > 0) {
        LixiGlobal.Chat.showPopup();
    }
    if ($('.input-group-event').length > 0) {
        $('.input-group-event .dropdown-menu a').click(function () {
            var obj = $(this);
            var value = obj.attr('data-value');
            obj.closest('.input-group-btn').find('.input-group-value').attr("value", value);
            obj.closest('.input-group-btn').find('.input-group-label').html(value);

        });
    }
    if ($('.support-phone-note').length > 0) {
        $('.support-phone-note').popover({
            trigger: 'hover',
            html: true,
            placement: 'right',
            title: function () {
                return $(this).html();
            },
            content: function () {
                return $('.support-phone-note-content').html();
            },
            container: 'body'
        });
    }
    if ($('.btn-verify-phone-number-event').length > 0) {
        LixiGlobal.User.initVerifyPhoneNumber();
    }
    if ($('.formVerifyCodePhoneNumber').length > 0) {
        LixiGlobal.User.initVerifyCodePhoneNumber();
    }
    if ($('.formChangePhoneNumber').length > 0) {
        LixiGlobal.User.initChangePhoneNumber();
    }
    if ($('form.formSupportEmail').length > 0) {
        LixiGlobal.Support.initSupportEmail();
    }
    if ($('.gift-filter-wrapper').length > 0) {
        LixiGlobal.Gift.initSentGiftPage();
    }
