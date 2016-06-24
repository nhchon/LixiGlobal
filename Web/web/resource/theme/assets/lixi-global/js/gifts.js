function showTooltip(){
    $('.tipso').each(function(){
        $(this).tipso({
            titleContent: $(this).attr('tooltipTitle')
            ,content: $('#'+$(this).attr("contentBy")).html()
            ,position:'top'
            ,width:500
        });
    });
    
    //$('[tooltipTitle]').each(function() { // Grab all elements with a title attribute,and set "this"
    //    $(this).qtip({ // 
    //        content: {
    //            title:$(this).text(),
    //            text: $('#'+$(this).attr("contentBy")).html() // WILL work, because .each() sets "this" to refer to each element
    //        }
            /*
            ,position: {
                my: 'top right',  // Position my top left...
                at: 'top left' // at the bottom right of...
                ,target:$('#'+$(this).attr("titlePosition"))
                ,adjust: {
                    method:"flipinvert"
                }
            }
            */
    //    });
    //});                
}
function loadPage(pageNum) {

    $.ajax({
        url: AJAX_LOAD_PRODUCTS_PATH + '/' + $('#recId').val() + '/' + pageNum,
        type: "get",
        dataType: 'html',
        success: function (data, textStatus, jqXHR)
        {
            //$('#divProducts').html("");
            $('#divProducts').html(data);
            //
            //addHandlerToCheckboxAndSelect();
            LixiGlobal.Gift.initSentGiftPage();
            $(".gift-product-thumb").each(function(){
                var zoom = $(this).attr("zoomWindowPosition");
                $(this).elevateZoom({zoomWindowPosition:parseInt(zoom)});
            });
            //
            showTooltip();
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert(errorThrown);
        }
    });
}
function loadNewPrice(price) {

    overlayOn($('.gift-filter-items'));
    
    $.ajax({
        url: CONTEXT_PATH + '/gifts/ajax/loadProductsByNewPrice/' + $('#recId').val() + '/1/' + price,
        type: "get",
        dataType: 'html',
        success: function (data, textStatus, jqXHR)
        {
            //$('#divProducts').html("");
            $('#divProducts').html(data);
            //
            //addHandlerToCheckboxAndSelect();
            LixiGlobal.Gift.initSentGiftPage();
            
            $(".gift-product-thumb").each(function(){
                var zoom = $(this).attr("zoomWindowPosition");
                $(this).elevateZoom({zoomWindowPosition:zoom});
            });
            
            overlayOff();
            
            var totalPage = $('#newTotalPages').val();
            if(totalPage === '' || totalPage ==='0'){
                totalPage = 1;
            }
            $('#pagination-data').twbsPagination('destroy');
            $('#pagination-data').twbsPagination({
                totalPages: totalPage,
                visiblePages: 5,
                onPageClick: function (event, page) {
                    /* load products - gifts.js */
                    loadPage(page);
                }
            });
            //
            showTooltip();
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert(errorThrown);
            //
            overlayOff();
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
function checkExceed(recId, productId, quantity) {
    if(isInteger(quantity)){
        if(parseInt(recId) > 0){
            $.ajax({
                url: AJAX_CHECK_EXCEED_PATH + '/' + recId + '/' + productId + '/' + quantity, // recId = 0
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
                        /* shopping cart */
                        updateShoppingCart(data.CURRENT_PAYMENT_USD, data.CURRENT_PAYMENT_VND);
                        //$('#topTotalCurrentOrderUsd').html("USD " + data.CURRENT_PAYMENT_USD)
                        //$('#topTotalCurrentOrderVnd').html("VND " + data.CURRENT_PAYMENT_VND)
                        /* */
                        if(quantity>0)
                            LixiGlobal.Gift.toCancelStatus($("#gift-product-item-"+productId));
                        else{
                            LixiGlobal.Gift.toBuyStatus($("#gift-product-item-"+productId));
                            $("#product" + productId).find("input[name='quantity']").val(1);
                        }
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
            alert("Please select a receiver !");
            $('#item'+productId).attr('checked', false);
            $('#recId').focus();
            overlayOff();
        }
    }
    else{
        alert("Please correct the quantity value");
        overlayOff();
        $("#product" + productId).find("input[name='quantity']").focus();
    }
}
