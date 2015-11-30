/* global BootstrapDialog */

var siteUrl = '';
Number.prototype.formatCurency = function (n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};
var LixiGlobal = {
    Const: {
        VND: 20000
    }
};
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
LixiGlobal.Form = {
    initCheckBox: function (checkboxElement) {
        var checkBox = $(checkboxElement);
        $(checkBox).each(function () {
            $(this).wrap("<span class='custom-checkbox'></span>");
            if ($(this).is(':checked')) {
                $(this).parent().addClass("selected");
            }
        });
        $(checkBox).click(function () {
            $(this).parent().toggleClass("selected");
        });
    },
    sendRedirect: function (_obj) {
        var obj = $(_obj);
        var link = obj.attr('data-link');
        window.location = link;
    },
    onCloseDialog: function (_obj) {
        var obj = $(_obj);
        obj.closest('.modal-dialog').find('.bootstrap-dialog-close-button .close').click();
    }
};
LixiGlobal.Gift = {
    initAddBtn: function (_obj) {
        var obj = $(_obj);
        var inputObj = obj.closest('.gift-number-box').find('.gift-number');
        inputObj.val(parseInt(inputObj.val()) + 1);
        return  false;
    },
    initSubBtn: function (_obj) {
        var obj = $(_obj);
        var inputObj = obj.closest('.gift-number-box').find('.gift-number');
        if (parseInt(inputObj.val()) > 1) {
            inputObj.val(parseInt(inputObj.val()) - 1);
        }
        return  false;
    },
    chooseGiftItem: function (_obj) {
        var obj = $(_obj);
        var giftItemObj = obj.closest('.gift-product-item');
        var selectedClass = 'gift-product-item-selected';
        var buyBtnObj = giftItemObj.find('.btn-buy-item-event');
        if (obj.is(":checked")) {
            giftItemObj.addClass(selectedClass);
            buyBtnObj.html("Cancel").attr('data-action', 'Cancel');
        } else {
            giftItemObj.removeClass(selectedClass);
            buyBtnObj.html("Buy").attr('data-action', 'Buy');
        }
    },
    initSentGiftPage: function () {
        $('.btn-buy-item-event').click(function () {
            var obj = $(this);
            var giftItemObj = obj.closest('.gift-product-item');
            if ((typeof obj.attr('data-action') !== "undefined") && (obj.attr('data-action') === "Cancel")) {
                giftItemObj.find('.gift-item-checkbox input').prop("checked", false);
                giftItemObj.find('.gift-item-checkbox .custom-checkbox').removeClass("selected");
                obj.html("Buy").attr('data-action', 'Buy');
            } else {
                giftItemObj.find('.gift-item-checkbox input').prop("checked", true);
                giftItemObj.find('.gift-item-checkbox .custom-checkbox').addClass("selected");
                giftItemObj.addClass(selectedClass);
                obj.html("Cancel").attr('data-action', 'Cancel');
            }
        });
        var items = $('.gift-filter-items').find('.gift-product-item-col');
        if (items.length > 0) {
            var selectedClass = 'gift-product-item-selected';
            $('.gift-filter-items').find('.gift-product-item-col').each(function (index) {
                var objItem = $(this);
                if (objItem.find('.gift-item-checkbox input').is(":checked")) {
                    objItem.find('.gift-product-item').addClass(selectedClass);
                    var buyBtnObj = objItem.find('.btn-buy-item-event');
                    buyBtnObj.html("Cancel").attr('data-action', 'Cancel');
                }
            });
        }
        $('#pagination-data').twbsPagination({
            totalPages: 90,
            visiblePages: 9,
            onPageClick: function (event, page) {
                console.log(page);
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
            message: $('<div class="chat-support-wrapper"><span class="loading-progress"></span></div>').load(siteUrl + 'support-chat-popup.html')
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
jQuery(document).ready(function () {
    $('.nav-login-event, .nav-register-event').click(function () {
        LixiGlobal.User.registerPopup();
    });
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
        sliderFilter.on("slide", function (slideEvt) {
            //Call filter when change value here
            console.log(slideEvt);
        });

    }
    if ($('.custom-checkbox-input').length > 0) {
        LixiGlobal.Form.initCheckBox('.custom-checkbox-input');
    }
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
});
