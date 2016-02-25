<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            
            jQuery(document).ready(function () {
                
                $('input[name=oIds]').change(function(){
                    
                    var count = 0;
                    var totalVnd = 0;
                    var totalUsd = 0;
                    $('input[name=oIds]').each(function(){
                       
                       if($(this).prop( "checked" )){
                           //alert($(this).attr('totalAmountVnd'));
                           count++;
                           totalVnd = totalVnd + parseFloat($(this).attr('totalAmountVnd'));
                           totalUsd = totalUsd + parseFloat($(this).attr('totalAmountUsd'));
                       }
                    });
                    $('#tdOnSelectCount').html(count + '');
                    $('#tdOnSelectVnd').html(totalVnd + '');
                    $('#tdOnSelectUsd').html(totalUsd.toFixed(2) + '');
                });
                
            });

            function checkForm(){
                
                var rs = false;
                $('input[name=oIds]').each(function(){
                       
                       if($(this).prop( "checked" )){
                           //alert($(this).attr('totalAmountVnd'));
                           rs =  true;
                       }
                });
                
                if(rs === false){
                    alert('Please check atleast one order');
                }
                
                return rs;
            }
            
            function sent(id){
                
                if(confirm('Send payment notification of this order id '+ id + ' to BaoKim ???')){
                    
                    document.location.href = '<c:url value="/Administration/Orders/sendMoneyInfo/"/>' + id;
                }
            }
            
            function cancel(id){
                
                if(confirm('Are you sure want to CANCEL this order id '+ id + ' ???')){
                    
                    document.location.href = '<c:url value="/Administration/Orders/cancel/"/>' + id + '/money';
                }
            }
            
            function viewRecipient(id) {
                $.get('<c:url value="/Administration/SystemRecipient/view/"/>' + id, function (data) {
                    $('#editRecipientContent').html(data);
                    $('#editRecipientModal').modal({show: true});

                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })
                });
            }

            function viewSender(id) {
                $.get('<c:url value="/Administration/SystemSender/view/"/>' + id, function (data) {
                    $('#editRecipientContent').html(data);
                    $('#editRecipientModal').modal({show: true});

                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })
                });
            }
            
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%-- EnumLixiOrderStatus.java --%>
        <c:set var="UNFINISHED" value="-9"/>
        <c:set var="NOT_YET_SUBMITTED" value="-8"/>
        <c:set var="SENT_INFO" value="-7"/>
        <c:set var="SENT_MONEY" value="-6"/>
        <c:set var="PROCESSING" value="0"/>
        <c:set var="COMPLETED" value="1"/>
        <c:set var="CANCELED" value="2"/>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/sendMoneyInfo"/>">Order Send Money</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Order Send Money</h2>
        <c:url value="/Administration/Orders/sendMoneyInfo" var="postMoneyInfo"/>
        <c:set var="transferPercent" value="95"/>
        <c:if test="${not empty sessionScope['scopedTarget.loginedUser'].configs['LIXI_BAOKIM_TRANFER_PERCENT']}">
            <c:set var="transferPercent" value="${sessionScope['scopedTarget.loginedUser'].configs['LIXI_BAOKIM_TRANFER_PERCENT']}"/>
        </c:if>
        <form action="${postMoneyInfo}" method="post" onsubmit="return checkForm()">
        <div class="row">
            <div class="col-sm-12">
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th nowrap>Date</th><%-- 1 --%>
                                        <th nowrap style="text-align:center;">Order</th><%-- 2 --%>
                                        <th nowrap style="text-align:center;">Transaction No</th><%-- 3 --%>
                                        <th nowrap>Option</th><%-- 4 --%>
                                        <th>Sender</th><%-- 5 --%>
                                        <th style="text-align: center;">Receiver(s)</th><%-- 6 --%>
                                        <th style="text-align: right;">Amount</th><%-- 7 --%>
                                        <th style="text-align: right;">Action</th><%-- 8 --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="countRec" value="0"/>
                                    <c:set var="totalAmountVnd" value="0"/>
                                    <c:set var="totalAmountUsd" value="0"/>
                                    <c:forEach items="${mOs}" var="m" varStatus="theCount">
                                        <c:set var="countRec" value="${theCount.count}"/>
                                        <tr id="rowO${m.key.id}">
                                            <td><input type="checkbox" value="${m.key.id}" name="oIds" id="oId${m.key.id}" class="checkbox" totalAmountVnd="${m.key.invoice.totalAmountVnd}" totalAmountUsd="${m.key.invoice.totalAmount}"/></td>
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/>
                                            </td>
                                            <td nowrap style="text-align:center;"><a href="<c:url value="/Administration/Orders/detail/${m.key.id}"/>">
                                                    ${m.key.invoice.invoiceCode}
                                                </a>
                                                <br/>
                                                1 USD = ${m.key.lxExchangeRate.buy} VND
                                            </td>
                                            <td style="text-align:center;">${m.key.invoice.netTransId}<br/>(${m.key.invoice.translatedStatus})</td>
                                            <td nowrap>
                                                <c:if test="${m.key.setting eq 0}">
                                                    Gift Only
                                                </c:if>
                                                <c:if test="${m.key.setting eq 1}">
                                                    Allow Refund
                                                </c:if>
                                            </td>
                                            <td>${m.key.sender.fullName}<br/><a href="<c:url value="/Administration/SystemSender/detail/${m.key.sender.id}"/>">${m.key.sender.beautyId}</a></td>
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
                                            <td style="text-align: right;">
                                                <a href="javascript:sent(${m.key.id});">Send</a> | <a href="javascript:cancel(${m.key.id});">Cancel</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <table class="table table-responsive" style="font-size: 14px;">
                    <thead>
                    <th colspan="3">On-Select Summary:</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Total:</td>
                            <td style="text-align: right;" id="tdOnSelectCount"></td>
                            <td>Record(s)</td>
                        </tr>
                        <tr>
                            <td>Total Amount(fee, tax,...):</td>
                            <td style="text-align: right;" id="tdOnSelectUsd"></td>
                            <td>USD</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="text-align: right;" id="tdOnSelectVnd"></td>
                            <td>VND</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <table class="table table-responsive" style="font-size: 14px;">
                    <thead>
                    <th colspan="3">Summary:</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Total:</td>
                            <td style="text-align: right;">${countRec}</td>
                            <td>Record(s)</td>
                        </tr>
                        <tr>
                            <td>Total Amount:</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${totalAmountUsd}" pattern="###,###.##"/></td>
                            <td>USD</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="text-align: right;"><fmt:formatNumber value="${totalAmountVnd}" pattern="###,###.##"/></td>
                            <td>VND</td>
                        </tr>
                        <c:if test="${not empty VCB}">
                        <tr>
                            <td nowrap>Current FX Rate<br/>(${VCB.time})</td>
                            <c:set var="currentFX" value="0"/>
                            <c:forEach items="${VCB.exrates}" var="ex">
                            <c:if test="${ex.code == 'USD'}">
                                <c:set var="currentFX" value="${ex.buy}"/>
                            </c:if>
                        </c:forEach>                            
                            <td nowrap style="text-align: right;">1 USD = <fmt:formatNumber value="${currentFX}" pattern="###,###.##"/></td>
                            <td>VND</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4" style="text-align: center;">
                <button class="btn btn-primary" type="submit">Sent Selected Orders</button>
            </div>
            <div class="col-md-4"></div>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
