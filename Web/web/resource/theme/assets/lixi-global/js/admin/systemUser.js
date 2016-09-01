jQuery(document).ready(function () {
    $('input:checkbox').change(function () {
        if ($(this).prop('checked')) {
            var parentId = $(this).attr('parentId');
            if (parentId !== undefined) {
                if (parentId !== '') {
                    // set parent checked
                    $('input:checkbox').each(function () {
                        //alert($(this).val())
                        if ($(this).val() === parentId) {
                            $(this).prop('checked', true);
                            return;
                        }
                    });
                }
            }
        } else {
            var parentId = $(this).attr('parentId');
            if (parentId === undefined) {
                var pVal = $(this).val();
                $('input:checkbox').each(function () {
                    //alert($(this).val())
                    if ($(this).attr('parentId') === pVal) {
                        $(this).prop('checked', false);
                    }
                });
            }
        }
    });

});
/**
 * 
 * @param {type} id
 * @returns {undefined}
 */
function showDescription(id) {
    $('#description_' + id).show();
}

/**
 * 
 * @param {type} id
 * @returns {undefined}
 */
function hideDescription(id) {
    $('#description_' + id).hide();
}
