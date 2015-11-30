/* 
 * Copyright Retrace Corp Inc. 2015
 */

(function () {
    if (!jQuery.validator)
        throw new Error("jquery.validate.js required");
    jQuery.validator.setDefaults({
        "highlight": function (a) {
            return jQuery(a).closest(".form-group").addClass("has-error");
        },
        "unhighlight": function (a) {
            return jQuery(a).closest(".form-group").removeClass("has-error").find("help-block-hidden").removeClass("help-block-hidden").addClass("help-block").show();
        },
        "errorElement": "div",
        "errorClass": "jquery-validate-error",
        "errorPlacement": function (a, b) {
            var c, d, e;
            return e = b.is('input[type="checkbox"]') || b.is('input[type="radio"]'), d = b.closest(".form-group").find(".jquery-validate-error").length, e && d ? void 0 : (d || b.closest(".form-group").find(".help-block").removeClass("help-block").addClass("help-block-hidden").hide(), a.addClass("help-block"), e ? b.closest('[class*="col-"]').append(a) : (c = b.parent(), c.is(".input-group") ? c.parent().append(a) : c.append(a)));
        }
    });
})(jQuery);

