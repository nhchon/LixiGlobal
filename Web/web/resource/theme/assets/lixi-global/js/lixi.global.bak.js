LixiGlobal.Menu = {
    effectMainMenu: function () {
        if ($(window).width() > 768) {
            // ADD SLIDEDOWN ANIMATION TO DROPDOWN //
            $('.navbar .dropdown').on('show.bs.dropdown', function (e) {
                $(this).find('.dropdown-menu').first().stop(true, true).slideDown();
            });
            // ADD SLIDEUP ANIMATION TO DROPDOWN //
            $('.navbar .dropdown').on('hide.bs.dropdown', function (e) {
                $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
            });
            $('.navbar .dropdown').hover(function () {
                $(this).find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
            }, function () {
                $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp();
            });
        }
    }
};
LixiGlobal.User = {
    registerPopup: function () {
        BootstrapDialog.show({
            size: BootstrapDialog.SIZE_WIDE,
            cssClass: 'dialog-no-header',
            title: 'Register',
            message: $('<div class="login-register-wrapper"><span class="loading-progress"></span></div>').load(siteUrl + 'register.html')
        });
    },
    loginFormInit: function () {
        var form = $('form.login-form');
        form.validate();
    },
    registerFormInit: function () {
        var form = $('form.register-form');
        form.validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                password: {
                    required: true,
                    minlength: 3,
                    maxlength: 100
                },
                rePassword: {
                    minlength: 3,
                    equalTo: "#password"
                }
            },
            submitHandler: function (form) {
                BootstrapDialog.show({
                    cssClass: 'dialog-no-header',
                    message: '<div class="text-center"><h2 class="title">THANK YOU FOR REGISTERING WITH US</h2><p>Find the email in your inbox. You may also contact<br> <a href="#">Customer service</a> for helping</p>'
                            + '<p>An Email was sent to ABC@gmail.com.<br> In order to complete the email verification process,<br> you must click on the email wwe sent you.<br> Be sure to checck your spam filters if you can’t</p></div>'
                });
            }
        });
    },
    initVerifyPhoneNumber: function () {
        var form = $('form.formVerifyPhoneNumber');
        form.validate({
            rules: {
                phoneNumber: {
                    required: true
                }
            },
            submitHandler: function (form) {
                var area = $(form).find('.input-group-value').val();
                var phoneNumber = $(form).find('#phoneNumber').val();
                BootstrapDialog.show({
                    cssClass: 'dialog-no-header',
                    message: '<div class="text-center"><h2 class="title">VERIFICATION</h2><p>We will send you a text to verify this number:</p>'
                            + '<p class="text-color-link text-uppercase">' + area + ' ' + phoneNumber + '</p>'
                            + '<p><span  class="border-bottom">Message ans Date robes may apply</span></p>'
                            + '<p><button class="btn btn-default text-uppercase" onclick="LixiGlobal.Form.onCloseDialog(this);">Cancel</button> <button class="btn btn-primary text-uppercase" data-link="account-verify-phone-number.html" onclick="LixiGlobal.Form.sendRedirect(this);">Ok</button></p>'
                });
            }
        });
    },
    initVerifyCodePhoneNumber: function () {
        var form = $('.formVerifyCodePhoneNumber');
        form.validate({
            rules: {
                phoneNumber: {
                    required: true
                }
            },
            submitHandler: function (form) {
                window.location = "account-change-mobile-phone-number.html";
            }
        });
    },
    initChangePhoneNumber: function () {
        var form = $('.formChangePhoneNumber');
        form.validate({
            rules: {
                password: {
                    required: true
                }
            },
            submitHandler: function (form) {
                window.location = "account.html";
            }
        });
    }
};
LixiGlobal.Quality = {
    star: function (element) {
        var obj = $(element);
        console.log(1);
        if (typeof obj.attr('data-max') !== "undefined") {
            var maxStar = parseInt(obj.attr('data-max'));
            var selectedStar = parseInt(obj.attr('data-selected'));
            if (selectedStar > maxStar) {
                selectedStar = maxStar;
            }
            var selected = '';
            var htmlBuffer = [];
            for (var i = 1; i <= maxStar; i++) {
                selected = (i <= selectedStar) ? ' quality-star-selected' : '';
                htmlBuffer.push('<span class="quality-star' + selected + '"></span>');
            }
            obj.html(htmlBuffer.join("\n"));
        }
    }
};
LixiGlobal.Chat = {
    showPopup: function () {
        BootstrapDialog.show({
            cssClass: 'dialog-no-header',
            title: 'Chat',
            message: $('<div class="chat-support-wrapper"><span class="loading-progress"></span></div>').load(siteUrl + '/support-chat-popup.html')
        });
    },
    initOnOffSound: function () {
        $('.sound-icon').click(function () {
            var obj = $(this);
            if (obj.hasClass('sound-off')) {
                obj.removeClass('sound-off').addClass('sound-on');
                obj.find('input').val(1);
            } else {
                obj.removeClass('sound-on').addClass('sound-off');
                obj.find('input').val(0);
            }
        });
    },
    submit: function () {
        $('.btn-cancel-dialog').click(function () {
            var obj = $(this);
            obj.closest('.modal-dialog').find('.bootstrap-dialog-close-button .close').click();
        });
        var form = $('.chat-form');
        form.validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                name: {
                    required: true
                },
                content: {
                    required: true,
                    minlength: 10
                }
            },
            submitHandler: function (form) {
                LixiGlobal.Dialog.showDialog("Connecting...", "Please waiting for minutes.");
                return  false;
            }
        });
    }
};
LixiGlobal.Support = {
    initSupportEmail: function () {
        var form = $('.formSupportEmail');
        form.validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                yourName: {
                    required: true
                }
            },
            submitHandler: function (form) {
                LixiGlobal.Dialog.showDialog("Thank you!", "We will support to you.");
                return  false;
            }
        });
    }
};

/* Ec Cookie */
LixiGlobal.Cookie = {
    createCookie: function (name, value, days) {
        var expires;

        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toGMTString();
        } else {
            expires = "";
        }
        document.cookie = escape(name) + "=" + escape(value) + expires + "; path=/";
    },
    readCookie: function (name) {
        var nameEQ = escape(name) + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) === ' ')
                c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) === 0)
                return unescape(c.substring(nameEQ.length, c.length));
        }
        return null;
    },
    eraseCookie: function (name) {
        this.createCookie(name, "", -1);
    }
};
LixiGlobal.Dialog = {
    setTitleMessage: function (title, message) {
        return '<div class="text-center"><h2 class="title">' + title + '</h2><div>' + message + '</div></div>';
    },
    showDialog: function (title, content) {
        BootstrapDialog.show({
            cssClass: 'dialog-no-header',
            message: LixiGlobal.Dialog.setTitleMessage(title, content)
        });
    }
};

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
