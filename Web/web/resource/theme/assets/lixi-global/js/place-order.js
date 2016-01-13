$(document).ready(function () {

    $('input[name=setting]').change(function () {

        if ($(this).prop("checked")) {

            $.ajax({
                url: CALCULATE_FEE_PATH + '/' + $(this).val(),
                type: "get",
                dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                    if (data.error == '0') {
                        $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY)
                        $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL)
                    }
                    else {
                        // TODO 
                    }
                },
                error: function (jqXHR, textStatus, errorThrown)
                {
                    //alert(errorThrown);
                    //alert('Đã có lỗi, vui lòng thử lại !'); 
                }
            });

        }
    });


});

function checkExceedTopUpOnPlaceOrder(id, amount) {
    if(isInteger(amount)){
        $.ajax({
            url: AJAX_CHECK_TOPUP_EXCEED_PATH + '/' + id+ '/' + amount,
            type: "get",
            dataType: 'json',
            success: function (data, textStatus, jqXHR)
            {
                overlayOff();
                if (data.exceed === '1') {
                    alert(data.message);
                } else {
                    // update amount
                    $('#topUp'+id).html(amount);
                    $('#topUpUsd'+id).html(data.TOP_UP_AMOUNT);
                    $('#topUpVnd'+id).html(data.TOP_UP_IN_VND);
                    
                    $('#topUpDiv'+id).attr("amount", data.TOP_UP_AMOUNT);
                    cancelEditTopUp(id);
                    
                    $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                    $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                    $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                    $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                    $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                    /* */
                    updateShoppingCart(data.LIXI_GIFT_PRICE, data.LIXI_GIFT_PRICE_VND);
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


