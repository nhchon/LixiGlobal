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
 * @param {type} obj
 * @returns {undefined}
 */
function overlayOn(obj){
    var overlayDiv = $('#overlay');
    overlayDiv.positionOn(obj);
    overlayDiv.show();
}

function overlayOff(){
    $('#overlay').hide();
}