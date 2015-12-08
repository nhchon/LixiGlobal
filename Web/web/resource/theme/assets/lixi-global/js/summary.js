function addBtn(id){
    
    var qObj = $('#quantity'+id);
    
    qObj.val(parseInt(qObj.val()) + 1);
    
    /**/
    overlayOn($("#giftRow"+id));
    checkExceedOnSummaryPage(id, qObj.val())
}

function checkExceedOnSummaryPage(productId, quantity) {
    $.ajax({
        url: AJAX_CHECK_EXCEED_PATH + '/' + productId + '/' + quantity,
        type: "get",
        dataType: 'json',
        success: function (data, textStatus, jqXHR)
        {
            overlayOff();
            if (data.exceed === '1') {
                var resetQuantity = data.SELECTED_PRODUCT_QUANTITY;
                if(resetQuantity === "") 
                    resetQuantity = "1";

                if (data.SELECTED_PRODUCT_ID > 0) {
                    $('#quantity'+productId).val(resetQuantity);
                }
                alert(data.message);
            } else {
                // no exceed, remove error
                // update current payment
                $('#currentPaymentVND').html(data.CURRENT_PAYMENT_VND);
                $('#currentPaymentUSD').html(data.CURRENT_PAYMENT_USD);
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
