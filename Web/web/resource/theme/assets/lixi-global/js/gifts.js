function showTooltip(){
    $('.tipso').each(function(){
        $(this).tipso({
            titleBackground   : '#0090d0',
            titleColor        : '#fff',
            color             : '#413833',
            background: '#faf9f5',
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
    overlayOn($('.gift-filter-items'));
    $.ajax({
        url: AJAX_LOAD_PRODUCTS_PATH + '/' + pageNum,
        type: "get",
        dataType: 'html',
        success: function (data, textStatus, jqXHR)
        {
            $('#divProducts').html(data);
            overlayOff();
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert(errorThrown);
            overlayOff();
        }
    });
}
function loadNewPrice(price, sliderFilter) {

    overlayOn($('.gift-filter-items'));
    sliderFilter.disable();
    
    $.ajax({
        url: CONTEXT_PATH + '/gifts/ajax/loadProductsByNewPrice/1/' + price,
        type: "get",
        dataType: 'html',
        success: function (data, textStatus, jqXHR)
        {
            //$('#divProducts').html("");
            $('#divProducts').html(data);
            overlayOff();
            sliderFilter.enable();
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert(errorThrown);
            //
            overlayOff();
            sliderFilter.enable();
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
            $.ajax({
                url: AJAX_CHECK_EXCEED_PATH + '/' + recId + '/' + productId + '/' + quantity, // recId = 0
                type: "get",
                dataType: 'json',
                success: function (data, textStatus, jqXHR)
                {
                    overlayOff();
                    if (data.exceed === '1') {
                        $('#quantity').val(parseInt(data.SELECTED_PRODUCT_QUANTITY) - 1);
                        alert(data.message);
                    } else {
                        // update current payment
                        $('#currentPaymentVND').html(data.CURRENT_PAYMENT_VND);
                        $('#currentPaymentUSD').html(data.CURRENT_PAYMENT_USD);
                        /* shopping cart */
                        //updateShoppingCart(data.CURRENT_PAYMENT_USD, data.CURRENT_PAYMENT_VND);
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
        $("#giftNumberBox").find("input[name='quantity']").focus();
    }
}
