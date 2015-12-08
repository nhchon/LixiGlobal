function loadPage(pageNum) {

    $.ajax({
        url: AJAX_LOAD_PRODUCTS_PATH + '/' + pageNum,
        type: "get",
        dataType: 'html',
                success: function (data, textStatus, jqXHR)
                {
            //$('#divProducts').html("");
            $('#divProducts').html(data);
            //
            //addHandlerToCheckboxAndSelect();
            LixiGlobal.Gift.initSentGiftPage();
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert(errorThrown);
        }
    });
}
/**
 * 
 * check if order total is exceeded
 * 
 * @param {type} productId
 * @param {type} quantity
 * @returns {undefined}
 */
function checkExceed(productId, quantity) {
    $.ajax({
        url: AJAX_CHECK_EXCEED_PATH + '/0/' + productId + '/' + quantity, // recId = 0
        type: "get",
        dataType: 'json',
        success: function (data, textStatus, jqXHR)
        {
            overlayOff();
            if (data.exceed === '1') {
                //$('#divError').remove();
                //$('#divProducts').prepend('<div class="msg msg-error" id="divError">' + data.message + '</div>')
                // uncheck
                $('input[name=item]').each(function () {
                    if ($(this).val() == productId) {
                        
                        var giftItemObj = $(this).closest('.gift-product-item');
                        /* roll back value */
                        var resetQuantity = data.SELECTED_PRODUCT_QUANTITY;
                        if(resetQuantity === "") 
                            resetQuantity = "1";
                        
                        if (data.SELECTED_PRODUCT_ID > 0) {
                            giftItemObj.find("input[name='quantity']").val(resetQuantity);
                        }
                        else {
                            $(this).attr('checked', false); // Unchecks it
                            giftItemObj.find("input[name='quantity']").val(resetQuantity);
                        }
                        // out
                        return false;
                    }
                });
                alert(data.message);
            } else {
                // no exceed, remove error
                // update current payment
                $('#currentPaymentVND').html(data.CURRENT_PAYMENT_VND);
                $('#currentPaymentUSD').html(data.CURRENT_PAYMENT_USD);
                /* */
                if(quantity>0)
                    LixiGlobal.Gift.toCancelStatus($("#gift-product-item-"+productId));
                else
                    LixiGlobal.Gift.toBuyStatus($("#gift-product-item-"+productId));
            }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            overlayOff();
            alert(errorThrown);
            //alert('Đã có lỗi, vui lòng thử lại !'); 
        }
    });
}
