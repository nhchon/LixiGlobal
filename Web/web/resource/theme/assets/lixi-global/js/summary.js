function deleteGiftOnSummary(giftId){
   
    if(confirm(CONFIRM_DELETE_MESSAGE)){
        location.href= DELETE_GIFT_PATH +'/'+giftId;
    }
}

function deleteTopUpOnSummary(id){
   
    if(confirm(CONFIRM_DELETE_MESSAGE)){
        location.href= DELETE_TOPUP_PATH +'/'+id;
    }
}

/**
 * 
 * @param {type} id
 * @param {type} productId
 * @param {type} recId
 * @returns {undefined}
 */
function addBtn(id, productId, recId){
    
    var qObj = $('#quantity'+id);
    
    qObj.val(parseInt(qObj.val()) + 1);
    
    /**/
    overlayOn($("#giftRow"+id));
    checkExceedOnSummaryPage(id, productId, recId, qObj.val())
}

/**
 * 
 * @param {type} id
 * @param {type} productId
 * @param {type} recId
 * @returns {undefined}
 */
function subBtn(id, productId, recId){
    
    var qObj = $('#quantity'+id);
    
    var quantity = parseInt(qObj.val());
    if(quantity > 1){
        
        /* */
        qObj.val(quantity-1);
        /**/
        overlayOn($("#giftRow"+id));
        checkExceedOnSummaryPage(id, productId, recId, (quantity - 1))
    }
    
}

/**
 * 
 * @param {type} recId
 * @param {type} productId
 * @param {type} quantity
 * @returns {undefined}
 */
function checkExceedOnSummaryPage(id, productId, recId, quantity) {
    if(isInteger(quantity)){
    $.ajax({
        url: AJAX_CHECK_EXCEED_PATH + '/' + recId+ '/' + productId + '/' + quantity,
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
                    $('#quantity'+id).val(resetQuantity);
                }
                alert(data.message);
            } else {
                // update recipient's total
                $('#recPaymentUSD'+recId).html(data.RECIPIENT_PAYMENT_USD)
                $('#recPaymentVND'+recId).html(data.RECIPIENT_PAYMENT_VND)
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
    else{
        alert("Please correct the quantity value");
        overlayOff();
        $("#product" + productId).find("input[name='quantity']").focus();
    }
}
