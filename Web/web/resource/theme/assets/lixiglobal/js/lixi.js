$(document).ready(function(){
	$('#menu-toggle').click(function(){
		var sender = $(this);
		if(sender.hasClass('opened')) {
			$('#menu-items').slideUp(200);
			sender.removeClass('opened');
		} else {
			$('#menu-items').slideDown(200);
			sender.addClass('opened');
		}
	});
});

/**
 * 
 * @returns {Boolean}
 */
$.fn.isValidEmailAddress = function() {

    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(this.val());
    
};

/**
 * 
 * @returns {Boolean}
 */
$.fn.isInteger = function() {

    var val = this.val();
    
    return Math.floor(val) == val && $.isNumeric(val);
    
};

/**
 * 
 * 
 */
$.fn.isValidPassword = function(){
    
    if(this.val() === '')
        return false;

    var isAtLeast8 = this.val().length >= 8;
    var hasUppercase = !(this.val() === this.val().toLowerCase());
    // has number
    var regex = /\d/g;
    var hasNumber = regex.test(this.val());
    // only normal chars
    var normalChars = /^[a-zA-Z0-9- ]*$/.test(this.val());
    
    return (isAtLeast8 && hasUppercase && hasNumber && !normalChars);;
}
/**
 * 
 * @param {type} element
 * @param {type} align
 * @returns {unresolved}
 */
$.fn.positionOn = function(element) {
  return this.each(function() {
    var target   = $(this);
    var position = element.offset();
    if(typeof position !== 'undefined'){

        var x      = position.left; 
        var y      = position.top;
        var width  = element.width() + parseInt(element.css('padding-left'))  + parseInt(element.css('padding-right'));
        var height = element.height() + parseInt(element.css('padding-top'))  + parseInt(element.css('padding-bottom'));;

        target.css({
          position: 'absolute',
          opacity:0.9,
          zIndex:   99999,
          top:      y, 
          left:     x,
          width: width,
          height: height
        });
    }
  });
};

/**
 * 
 * @param {type} emailAddress
 * @returns {Boolean}
 */
function isValidEmailAddress(emailAddress) {
    
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(emailAddress);
    
};

/**
 * 
 * check password is At least 8 characters with Capital
 * 
 * @param {type} password
 * @returns {Boolean}
 */
function isValidPassword(password){
    
    if(password==null || password=='')
        return false;
    
    var isAtLeast8 = password.length >= 8;
    var hasUppercase = !(password === password.toLowerCase());
    
    return (isAtLeast8 && hasUppercase);;
}