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