<template:Client htmlTitle="Lixi Global - Choose Type of Gift">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/type-of-gift.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            $(document).ready(function () {

                $('#btnSubmit').click(function () {

                    var value = $('input[name=type-of-gift]:checked', '#typeOfGiftForm').val();

                    if (value === 'MOBILE_MINUTES') {

                        alert('Sorry ! This function is in developement');
                        return false;
                    }
                    else {

                        if ($.trim(value) === '') {

                            alert('Please choose type of gift');

                            return false;
                        }
                    }
                    //
                    document.location.href = "<c:url value="/gifts/choose/"/>" + value;
                    return true;
                });
                
                addHandlerToCheckboxAndSelect();
            });

            function addHandlerToCheckboxAndSelect(){
                // check the gift
                $('input[name=gift]').change(function(){
                   
                    var productId = $(this).val();
                    var quantity = $('#quantity-' + productId).val();
                    
                    // uncheck product
                    if($(this).prop("checked") === false){
                        quantity = -quantity;
                    }
                    
                    checkExceed(${SELECTED_RECIPIENT_ID}, productId, quantity);
                });
                
                // change the quantity
                $( "select" ).change(function (){
                
                    var name = $(this).attr('name')
                    var res = name.split("-");
                    var productId = res[1];
                    var quantity = $(this).val();
                    
                    $('input[name=gift]').each(function(){
                        if($(this).val() == productId && $(this).prop("checked")){
                            
                            checkExceed(${SELECTED_RECIPIENT_ID}, productId, quantity);
                            // out
                            return false;
                        }
                    });
                });
            }
            function checkExceed(recId, productId, quantity){
                $.ajax({
                    url : '<c:url value="/gifts/checkExceed"/>' + '/'+recId+'/'+productId+ '/' + quantity,
                    type: "get",
                    dataType: 'json',
                    success:function(data, textStatus, jqXHR) 
                    {
                        if(data.data.exceed == '1'){
                            $('#divError').remove();
                            $('#contentDiv').prepend('<div class="msg msg-error" id="divError">' + data.data.message + '</div>')
                            // uncheck
                            $('input[name=gift]').each(function(){
                                if($(this).val() == productId && $(this).prop("checked")){
                                    
                                    /* roll back value */
                                    if(data.data.SELECTED_PRODUCT_ID > 0){
                                        $('#quantity-' + $(this).val()).val(data.data.SELECTED_PRODUCT_QUANTITY);
                                    }
                                    else{
                                        $(this).attr('checked', false); // Unchecks it
                                        // reset quantity
                                        $('#quantity-' + $(this).val()).val(1);
                                    }
                                    // out
                                    return false;
                                }
                            });
                            alert(data.data.message);
                        }else{
                            // no exceed, remove error
                            $('#divError').remove();
                            // update current payment
                            $('#currentPaymentVND').html(data.data.CURRENT_PAYMENT_VND);
                            $('#currentPaymentUSD').html(data.data.CURRENT_PAYMENT_USD);
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    { 
                        //alert(errorThrown);
                        //alert('Đã có lỗi, vui lòng thử lại !'); 
                    }    
                });
            }

            function loadPage(category, pageNum) {

                $.ajax({
                    url: '<c:url value="/gifts/ajax/products"/>' + '/' + category + '/' + pageNum,
                    type: "get",
                    dataType: 'html',
                    success: function (data, textStatus, jqXHR)
                    {
                        $('#contentDiv').html(data);
                        //
                        addHandlerToCheckboxAndSelect();
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        alert(errorThrown);
                        //alert('Đã có lỗi, vui lòng thử lại !'); 
                    }
                });
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="type-of-gift">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <fieldset>
                            <legend>Choose Type of Gift</legend>
                        </fieldset>        
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <ul class="list-group">
                                        <li class="list-group-item">
                                            <div class="radio" style="text-align: center;">
                                                <a href="<c:url value="/topUp"/>">
                                                    <img  width="125" height="161"  src="<c:url value="/resource/theme/assets/lixiglobal/img/mobile.minutes.jpg"/>" />
                                                    <br/>
                                                    Top up mobile minutes
                                                </a>
                                            </div>
                                        </li>
                                        <c:forEach items="${LIXI_CATEGORIES}" var="lxc" varStatus="theCount">
                                            <li class="list-group-item<c:if test="${lxc.id eq SELECTED_LIXI_CATEGORY_ID}"> active</c:if>">
                                                    <div class="radio" style="text-align: center;">
                                                        <a href="<c:url value="/gifts/type/${lxc.id}"/>">
                                                        <img  width="125" height="161"  src="<c:url value="/showImages/"/>${lxc.icon}" />
                                                        <br/>
                                                        ${lxc.name}
                                                    </a>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="col-md-9">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <ol class="breadcrumb">
                                                <li class="active">${SELECTED_LIXI_CATEGORY_NAME}</li>
                                            </ol>    
                                        </div>
                                    </div>
                                    <c:if test="${not empty PRODUCTS}">
                                        <div class="row">
                                            <div class="col-md-12"><p>(<spring:message code="gift.closest_price"/>)</p></div>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty PRODUCTS}">
                                        <div class="row">
                                            <div class="col-md-12"><p>There is no product in this category.</p></div>
                                        </div>
                                    </c:if>
                                    <div class="row">
                                        <div class="col-md-12" id="contentDiv">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <c:forEach items="${PRODUCTS}" var="p" varStatus="theCount">
                                                        <c:if test="${theCount.index%3 eq 0}">
                                                            <div class="row">
                                                            </c:if>
                                                            <%-- Show product --%>
                                                            <div class="col-lg-4 col-md-4" style="text-align:center;">
                                                                <div><img width="144" height="144" alt="" src="${p.imageUrl}" /></div>
                                                                <br />
                                                                <a class="name">${p.name}</a>
                                                                <br />
                                                                <a class="price"><fmt:formatNumber value="${p.price}" pattern="###,###.##"/> VND</a>
                                                                <br />
                                                                <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                                                                <a class="price"><fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> USD</a>
                                                                <br/>
                                                                <label>
                                                                    <input type="checkbox" name="gift" value="${p.id}" <c:if test="${p.selected eq true}">checked</c:if>>
                                                                        <span class="lixi-radio"><span></span></span>
                                                                    </label>
                                                                    <input type="hidden" name="price-${p.id}" value="${p.price}"/>
                                                                <input type="hidden" name="name-${p.id}" value="${p.name}"/>
                                                                <input type="hidden" name="image-${p.id}" value="${p.imageUrl}"/>
                                                                <div style="text-align: center;">
                                                                    <select class="form-control lixi-select" name="quantity-${p.id}" id="quantity-${p.id}">
                                                                        <c:forEach var="i" begin="1" end="5">
                                                                            <option value="${i}" <c:if test="${(p.selected eq true) && (p.quantity == i)}">selected</c:if>>${i}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>        
                                                            <%-- // End of Show product --%>
                                                            <c:if test="${theCount.count%3 eq 0 or theCount.last}">
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-12">&nbsp;</div>
                                                            </div>
                                                        </c:if>        
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <%-- Paging --%>
                                            <div class="row">
                                                <div class="col-md-12" style="text-align: right;">
                                                    <ul class="pagination">
                                                        <c:forEach begin="1" end="${PAGES.totalPages}" var="i">
                                                            <c:choose>
                                                                <c:when test="${(i - 1) == PAGES.number}">
                                                                    <li class="paginate_button active" aria-controls="datatable-column-interactive" tabindex="0">
                                                                        <a href="javascript:void(0)">${i}</a>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li class="paginate_button" aria-controls="datatable-column-interactive" tabindex="0">
                                                                        <a href="javascript:loadPage(${SELECTED_LIXI_CATEGORY_ID}, ${i - 1})">${i}</a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>
                                            <%-- current payment --%>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="row">
                                                        <div class="col-lg-8">Your maximum payment amount:</div>
                                                        <div class="col-lg-4" style="padding-left: 0px;text-align: right;">
                                                            <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount * LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/>&nbsp;VND</strong>
                                                            <br/>
                                                            <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount}" pattern="###,###.##"/>&nbsp;${USER_MAXIMUM_PAYMENT.code}</strong>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="pull-right">
                                                        Current payment: <strong><span id="currentPaymentVND"><fmt:formatNumber value="${CURRENT_PAYMENT}" pattern="###,###.##"/></span> VND</strong>
                                                        <br/>
                                                        <div class="pull-right"><strong><span id="currentPaymentUSD"><fmt:formatNumber value="${CURRENT_PAYMENT_USD}" pattern="###,###.##"/></span> USD</strong></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><%-- // End of contentDiv --%>
                                    </div>
                                    <div class="form-group right">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <a href="<c:url value="/gifts/value"/>" class="btn btn-primary"><spring:message code="message.back"/></a>
                                                <a href="<c:url value="/gifts/more-recipient"/>" class="btn btn-primary"><spring:message code="message.next"/></a>
                                            </div>
                                        </div>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    </div>
                </div>
            </section>
    </jsp:body>
</template:Client>