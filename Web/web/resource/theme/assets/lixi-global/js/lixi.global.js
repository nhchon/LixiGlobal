/* global BootstrapDialog */
var LixiGlobal = {
    Const: {
        VND: 20000,
        ThemeName: 'theme-name',
        defaultTheme: 'default',
        valentineTheme: 'valentine',
        tetTheme: 'tet'
    }
};
LixiGlobal.Browser = {
    getAppName: function (p) {
        var s = p.split("/").reverse();
        s.splice(0, 1);
        return s.reverse().join("/");
    },
    getPath: function () {
        var p = window.location.pathname;
        var s = p.split("/").reverse();
        s.splice(0, 1);
        return s.reverse().join("/");
    },
    getHost: function () {
        var p = window.location.origin;
        return p;
    },
    getParam: function (url, name) {
        var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(url);
        if (results === null) {
            return null;
        } else {
            return results[1] || 0;
        }
    },
    getUrl: function () {
        siteUrl = siteUrl.split(";jsessionid")[0];
        return siteUrl;
    },
    getWebroot: function () {
        var p = window.location.pathname;
        var s = p.split("/").reverse();
        s.splice(0, 2);
        return s.reverse().join("/");
    },
    getSiteUrl: function () {
        return this.getHost();// + this.getPath();
    }
};
var siteUrl = LixiGlobal.Browser.getSiteUrl();
var THEME_PATH = CONTEXT_PATH + "/resource/theme/assets/lixi-global/themes/";
var originalSliderVal = 10;
var firedSlideStart = false;
Number.prototype.formatCurency = function (n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
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
LixiGlobal.Gift = {
    initAddBtn: function (_obj) {
        var obj = $(_obj);
        var inputObj = obj.closest('.gift-number-box').find('.gift-number');
        inputObj.val(parseInt(inputObj.val()) + 1);

        var giftItemObj = obj.closest('.gift-product-item');
        var productId = giftItemObj.find("input[name='item']").val();
        var quantity = giftItemObj.find("input[name='quantity']").val();
        //alert(productId + " " + quantity)
        overlayOn($("#product" + productId));
        alert(quantity)
        checkExceed($('#recId').val(), productId, quantity);
        return  false;
    },
    initSubBtn: function (_obj) {
        var obj = $(_obj);
        var inputObj = obj.closest('.gift-number-box').find('.gift-number');
        if (parseInt(inputObj.val()) > 1) {
            inputObj.val(parseInt(inputObj.val()) - 1);
        }
        var giftItemObj = obj.closest('.gift-product-item');
        var productId = giftItemObj.find("input[name='item']").val();
        var quantity = giftItemObj.find("input[name='quantity']").val();
        //alert(productId + " " + quantity)
        overlayOn($("#product" + productId));
        checkExceed($('#recId').val(), productId, quantity);
        return  false;
    },
    chooseGiftItem: function (_obj) {
        var obj = $(_obj);
        var giftItemObj = obj.closest('.gift-product-item');
        //var selectedClass = 'gift-product-item-selected';
        //var buyBtnObj = giftItemObj.find('.btn-buy-item-event');
        if (obj.is(":checked")) {
            //alert('hi im checked')
            var productId = giftItemObj.find("input[name='item']").val();
            var quantity = giftItemObj.find("input[name='quantity']").val();
            overlayOn($("#product" + productId));
            checkExceed($('#recId').val(), productId, quantity);
        } else {
            //giftItemObj.removeClass(selectedClass);
            //buyBtnObj.html("Buy").attr('data-action', 'Buy');
            var productId = giftItemObj.find("input[name='item']").val();
            var quantity = giftItemObj.find("input[name='quantity']").val();
            overlayOn($("#product" + productId));
            checkExceed($('#recId').val(), productId, -quantity);
        }
    },
    toBuyStatus: function (giftItemObj) {
        /* */
        giftItemObj.find('.gift-item-checkbox input').prop("checked", false);
        giftItemObj.find('.gift-item-checkbox .custom-checkbox').removeClass("selected");
        giftItemObj.find(".btn-buy-item-event").html("Buy").attr('data-action', 'Buy');
    },
    toCancelStatus: function (giftItemObj) {
        /* */
        giftItemObj.find('.gift-item-checkbox input').prop("checked", true);
        giftItemObj.find('.gift-item-checkbox .custom-checkbox').addClass("selected");
        giftItemObj.addClass("'gift-product-item-selected'");
        giftItemObj.find(".btn-buy-item-event").html("Cancel").attr('data-action', 'Cancel');
    },
    initSentGiftPage: function () {
        $('.btn-buy-item-event').click(function () {
            var obj = $(this);
            var giftItemObj = obj.closest('.gift-product-item');
            if ((typeof obj.attr('data-action') !== "undefined") && (obj.attr('data-action') === "Cancel")) {
                /* */
                var productId = giftItemObj.find("input[name='item']").val();
                var quantity = giftItemObj.find("input[name='quantity']").val();
                overlayOn($("#product" + productId));
                checkExceed($('#recId').val(), productId, -1);
            } else {
                /* */
                var productId = giftItemObj.find("input[name='item']").val();
                var quantity = giftItemObj.find("input[name='quantity']").val();
                overlayOn($("#product" + productId));
                checkExceed($('#recId').val(), productId, quantity);
            }
        });

        $("gift-item-checkbox input[type='checkbox']").on('change', function () {
            if (this.checked) {
                //do your stuff
                console.log(1);
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
LixiGlobal.Theme = {
    changeLanguageTemplate: function () {
        var html = '<li class="has-dropdown dropdown nav-change-theme">'
                + '<a class="hvr-underline-from-center" data-toggle="dropdown" href="#change-theme"><span class="theme-name">Theme</span> <i class="fa fa-angle-down"></i></a>'
                + '<ul class="dropdown-menu">'
                + ' <li class="active">'
                + '     <a data-theme="' + LixiGlobal.Const.defaultTheme + '" href="#">Default theme</a>'
                + ' </li>	'
                + ' <li>'
                + '      <a data-theme="' + LixiGlobal.Const.valentineTheme + '" href="#">Valentine theme</a>'
                + ' </li>'
                + ' <li>'
                + '      <a data-theme="' + LixiGlobal.Const.tetTheme + '" href="#">TET theme</a>'
                + '  </li>'
                + '  </ul>'
                + '</li>';
        if ($('#navbar-collapse-top .nav-change-theme').length <= 0) {
            $('#navbar-collapse-top ul:first').append(html);
        }
    },
    initTheme: function () {
        this.changeLanguageTemplate();
        var themeName = LixiGlobal.Cookie.readCookie(LixiGlobal.Const.ThemeName);
        console.log($('#originalTheme').attr('href'));
        if (typeof themeName !== "undefined" && themeName !== null) {
            $('.nav-change-theme .dropdown-menu li').removeClass('active');
            $('.nav-change-theme .dropdown-menu a[data-theme=' + themeName + ']').closest('li').addClass('active');
            this.setTheme(themeName);
        } else {
            themeName = $('.nav-change-theme .dropdown-menu .active a').attr('data-theme');
            this.setTheme(themeName);
        }
        if (themeName !== LixiGlobal.Const.defaultTheme) {
            $('.navbar-brand img').attr('src', THEME_PATH + themeName + "/images/logo.png");
        }
        $('.nav-change-theme .dropdown-menu a').click(function () {
            var obj = $(this);
            $('.nav-change-theme .dropdown-menu li').removeClass('active');
            obj.closest('li').addClass('active');
            LixiGlobal.Theme.setTheme(obj.attr('data-theme'));
            window.location.reload();
        });
    },
    setTheme: function (name) {
        var styleObj = $('#originalTheme');
        var cssUrl = THEME_PATH + name + "/css/style.css";
        LixiGlobal.Cookie.createCookie(LixiGlobal.Const.ThemeName, name, 30);
        if (styleObj.length > 0) {
            $('#originalTheme').attr('href', cssUrl);
        } else {
            $('html head').append('<link id="originalTheme" rel="stylesheet" type="text/css" href="' + cssUrl + '">');
        }

    }
};
LixiGlobal.Slider = {
    carousel: function (element) {
        var sliderObj = $(element);
        if (typeof sliderObj !== "undefined" || sliderObj.length > 0) {
            sliderObj.carousel({
                interval: 1000 * 10
            });
        }
    }
};

jQuery(document).ready(function () {
    if ($('.gift-filter-slider-input').length > 0) {
        var sliderFilter = new Slider('.gift-filter-slider-input', {
            tooltip: 'always',
            formatter: function (value) {
                //Call filter here
                return "USD $" + value + " ~ VND " + (value * LixiGlobal.Const.VND).formatCurency();
            }
        });
        sliderFilter.on("slideStart", function (slideEvt) {
            originalSliderVal = slideEvt;
            firedSlideStart = true;
        });
        sliderFilter.on("slideStop", function (slideEvt) {
            //Call filter when change value here
            if (originalSliderVal != slideEvt || (firedSlideStart===true)) {
                originalSliderVal = slideEvt;
                firedSlideStart = false;
                loadNewPrice(slideEvt, sliderFilter);
            }
            //console.log(slideEvt);
        });

    }
    
});
