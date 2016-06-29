<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Transaction Monitor">
    <jsp:attribute name="extraHeadContent">
        <style type="text/css">
            .popover{
                max-width:650px;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            jQuery(document).ready(function () {
                $(function(){
                    $('[rel="popover"]').popover({
                        container: 'body',
                        html: true,
                        placement:'left',
                        title : 'Details <a href="#" class="close" data-dismiss="alert">&times;</a>',
                        content: function () {
                            var clone = $($(this).data('popover-content')).clone(true).css("display", "block");//removeClass('hide');
                            return clone;
                        }
                    }).click(function(e) {
                        e.preventDefault();
                    });
                    $(document).on("click", ".popover .close" , function(e){
                        $(this).parents(".popover").popover('hide');
                    });
                });
            });
            
            function gotIt(id){
                overlayOn($('#rowMonitor'+id));
                $.ajax(
                {
                    url: '<c:url value="/Administration/TransactionMonitor/process/"/>' + id,
                    type: "GET",
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        if (data.error === '1') {
                            
                            alert('There is something wrong. Please try again!');
                        }
                        else {
                            $('#rowMonitor'+id).remove();
                        }
                        overlayOff();
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        //if fails  
                        overlayOff();
                    }
                });
            }
            function reSendOrder(id){
                if(confirm('Are you sure want to re-send this order?')){
                overlayOn($('#rowO' + id));
                $.ajax(
                {
                    url: '<c:url value="/Administration/Orders/reSendOrder/"/>' + id,
                    type: "GET",
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        $('#status' + id).html(data);

                        if (data.error === '0') {
                            alert('Re-Send the Order success');
                        }
                        else{
                            alert('Re-Send the Order failed');
                        }
                        /* */
                        overlayOff();
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        //if fails  
                        overlayOff();
                    }
                });
                }
            }
            
            function cancel(id){
                
                if(confirm('Are you sure want to CANCEL this order id '+ id + ' ???')){
                    
                    document.location.href = '<c:url value="/Administration/Orders/cancel/"/>' + id + '/monitor';
                }
            }
            function viewRecipient(id) {
                $.get('<c:url value="/Administration/SystemRecipient/edit/"/>' + id, function (data) {
                    enableEditRecipientHtmlContent(data);
                });
            }
            
            function enableEditRecipientHtmlContent(data) {

                $('#editRecipientContent').html(data);
                $('#editRecipientModal').modal({show: true});

                // handler submit form
                //callback handler for form submit
                $("#chooseRecipientForm").submit(function (e)
                {
                    //alert('hi');
                    var postData = $(this).serializeArray();
                    var formURL = $(this).attr("action");
                    $.ajax(
                    {
                        url: formURL,
                        type: "POST",
                        data: postData,
                        dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                            //data: return data from server
                            if (data.error === '0') {
                                // hide popup
                                $('#editRecipientModal').modal('hide');
                            }
                            else {
                                alert(SOMETHING_WRONG_ERROR);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown)
                        {
                            //if fails      
                        }
                    });
                    if (typeof e !== 'undefined') {
                        e.preventDefault(); //STOP default action
                        //e.unbind(); //unbind. to stop multiple form submit.
                    }
                });
            }
            
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/monitor_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/TransactionMonitor/report"/>">Transaction Monitor</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Transaction Monitor</h2>
        <p class="help-block">Gift Margin(*): For ONLY Allow Refund Orders, but Gifted by each user</p>
        <security:authentication property="principal.configs['LIXI_BAOKIM_TRANFER_PERCENT']" var="transferPercent" />
        <c:if test="${empty transferPercent}">
            <c:set var="transferPercent" value="95"/>
        </c:if>
        <div class="row">
            <div class="col-sm-12">
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive table-striped">
                                <thead>
                                    <tr>
                                        <th nowrap>Date</th><%-- 1 --%>
                                        <th nowrap style="text-align:center;">Order</th><%-- 2 --%>
                                        <th nowrap style="text-align:center;">Transaction No</th><%-- 3 --%>
                                        <th nowrap>Option</th><%-- 4 --%>
                                        <th>Sender</th><%-- 5 --%>
                                        <th style="text-align: center;">Receiver(s)</th><%-- 6 --%>
                                        <th style="text-align: right;">Amount</th><%-- 7 --%>
                                        <th nowrap style="text-align:right;" title="For Allow Refund Orders, but Gifted by user">Total Gift Margin(*)</th>
                                        <th style="text-align: center;">Status</th><%-- 8 --%>
                                        <th style="text-align: right;">#</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="countRec" value="0"/>
                                    <c:set var="totalAmountVnd" value="0"/>
                                    <c:set var="totalAmountUsd" value="0"/>
                                    <c:forEach items="${mOs}" var="m" varStatus="theCount">
                                        <c:set var="totalGiftMargin" value="0"/>
                                        <c:set var="countRec" value="${theCount.count}"/>
                                        <tr id="rowO${m.key.id}" <c:if test="${not empty m.key.invoice.monitored}">class="warning"</c:if>>
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/>
                                            </td>
                                            <td nowrap style="text-align:center;"><a href="<c:url value="/Administration/Orders/detail/${m.key.id}"/>">
                                                    <b>${m.key.invoice.invoiceCode}</b>
                                                </a>
                                                <br/>
                                                1 USD = ${m.key.lxExchangeRate.buy} VND
                                            </td>
                                            <td style="text-align:center;"><b>${m.key.invoice.netTransId}</b><br/>(${m.key.invoice.translatedStatus})</td>
                                            <td nowrap>
                                                <c:if test="${m.key.setting eq 0}">
                                                    Gift Only
                                                </c:if>
                                                <c:if test="${m.key.setting eq 1}">
                                                    Allow Refund
                                                </c:if>
                                            </td>
                                            <td>${m.key.sender.fullName}<br/><a target="_blank" href="<c:url value="/Administration/SystemSender/detail/${m.key.sender.id}"/>">${m.key.sender.beautyId}</a></td>
                                            <td style="text-align: center;">
                                                <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                                    <c:if test="${not empty rio.gifts}">
                                                    ${rio.recipient.fullName}<br/><a href="javascript:viewRecipient(${rio.recipient.id});">${rio.recipient.beautyId}</a><br/>
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td style="text-align: right;">
                                                <c:forEach items="${m.value}" var="rio">
                                                    <c:if test="${not empty rio.gifts}">
                                                    <c:set var="totalGiftMargin" value="${totalGiftMargin + rio.giftMargin}"/>
                                                    <fmt:formatNumber value="${rio.giftTotal.usd}" pattern="###,###.##"/> USD<br/>
                                                    <c:if test="${m.key.setting eq 0}">
                                                        <fmt:formatNumber value="${rio.giftTotal.vnd * transferPercent/100.0}" pattern="###,###.##"/> VND (${transferPercent}%)<br/>
                                                        <c:set var="totalAmountVnd" value="${totalAmountVnd + rio.giftTotal.vnd * transferPercent/100.0}"/>
                                                    </c:if>
                                                    <c:if test="${m.key.setting eq 1}">
                                                        <fmt:formatNumber value="${rio.giftTotal.vnd}" pattern="###,###.##"/> VND<br/>
                                                        <c:set var="totalAmountVnd" value="${totalAmountVnd + rio.giftTotal.vnd}"/>
                                                    </c:if>
                                                    <c:set var="totalAmountUsd" value="${totalAmountUsd + rio.giftTotal.usd}"/>
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td id="giftMargin${m.key.id}" style="text-align:right;"></td>
                                            <td style="text-align: center;">
                                                <a href="#" data-placement="left" rel="popover" data-popover-content="#detailStatusOrder${m.key.id}">
                                                    <c:choose>
                                                        <c:when test="${m.key.lixiStatus eq PROCESSING}">
                                                            Processing<br/>
                                                            <c:if test="${m.key.lixiSubStatus eq SENT_MONEY}">(Sent Money Info)</c:if>
                                                            <c:if test="${m.key.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                                        </c:when>
                                                        <c:when test="${m.key.lixiStatus eq COMPLETED}">
                                                            Completed
                                                        </c:when>
                                                        <c:when test="${m.key.lixiStatus eq CANCELED}">
                                                            Cancelled
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${m.key.lixiStatus}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                                <%@include  file="/WEB-INF/jsp/view/Administration/reports/detailStatusOrder.jsp" %>
                                            </td>
                                            <td style="text-align: right;" nowrap>
                                                <c:if test="${m.key.lixiStatus eq PROCESSED}">
                                                    <a href="javascript:reSendOrder(${m.key.id});">Re-Send</a> | 
                                                </c:if>
                                                <c:if test="${m.key.lixiStatus eq PROCESSED and (m.key.lixiSubStatus eq SENT_MONEY or m.key.lixiSubStatus eq SENT_INFO)}">
                                                    <a href="javascript:cancel(${m.key.id});">Cancel</a>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <c:if test="${not empty m.key.invoice.monitored}">
                                            <tr class="danger">
                                                <td colspan="9">
                                                    <c:if test="${m.key.invoice.monitored eq OVER_100_USD}">
                                                        *** Giao dịch trên 100$
                                                    </c:if>
                                                    <c:if test="${m.key.invoice.monitored eq NAME_ON_CARD_WRONG}">
                                                        *** Thông tin trên thẻ không trùng với người gửi
                                                    </c:if>
                                                    <c:if test="${m.key.invoice.monitored eq OVER_MAX_NUM_ORDER}">
                                                        *** Người gửi có từ 3 transaction trong trạng thái In Progress
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:if>
                                        <script>document.getElementById('giftMargin${m.key.id}').innerHTML='<fmt:formatNumber value="${totalGiftMargin}" pattern="###,###.##"/> VND';</script>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="10">
                                            <%-- Paging --%>
                                            <nav>
                                            <ul class="pagination pull-right">
                                                <c:forEach begin="1" end="${pOrders.totalPages}" var="i">
                                                    <c:choose>
                                                        <c:when test="${(i - 1) == pOrders.number}">
                                                            <li class="active">
                                                                <a href="javascript:void(0)">${i}</a>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li>
                                                                <a href="<c:url value="/Administration/TransactionMonitor/report">
                                                                       <c:param name="paging.page" value="${i}" />
                                                                       <c:param name="paging.size" value="50" />
                                                                   </c:url>">${i}</a>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </ul>
                                                </nav>
                                        </td>
                                    </tr>
                                </tfoot>
                                
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
