<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            
            jQuery(document).ready(function () {
                $('#btnSubmit').click(function () {

                    if ($('#oStatus').val() === '') {

                        alert("Please select the order's status");
                        $('#oStatus').focus();

                        //return false;
                    }

                    document.location.href = '<c:url value="/Administration/Orders/newOrders/"/>' + $('#oStatus').val();
                });
            });
            
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
                                        <th nowrap>Order</th><%-- 2 --%>
                                        <th nowrap>Transaction No</th><%-- 3 --%>
                                        <th>Sender</th><%-- 4 --%>
                                        <th style="text-align: center;">Receiver(s)</th><%-- 5 --%>
                                        <th style="text-align: right;">Amount</th><%-- 6 --%>
                                        <th style="text-align: right;">Action</th><%-- 7 --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="countRec" value="0"/>
                                    <c:set var="totalAmountVnd" value="0"/>
                                    <c:set var="totalAmountUsd" value="0"/>
                                    <c:forEach items="${mOs}" var="m" varStatus="theCount">
                                        <c:set var="countRec" value="${theCount.count}"/>
                                        <c:set var="totalAmountVnd" value="${totalAmountVnd + m.key.invoice.totalAmountVnd}"/>
                                        <c:set var="totalAmountUsd" value="${totalAmountUsd + m.key.invoice.totalAmount}"/>
                                        <tr id="rowO${m.key.id}">
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/>
                                            </td>
                                            <td><a href="<c:url value="/Administration/Orders/detail/${m.key.id}"/>">${m.key.invoice.invoiceCode}</a></td>
                                            <td>${m.key.invoice.netTransId}</td>
                                            <td>${m.key.sender.fullName}</td>
                                            <td style="text-align: center;">
                                                <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                                    ${rio.recipient.fullName}<br/><a href="javascript:alert('In Implementation');">${rio.recipient.beautyId}</a><br/>
                                                </c:forEach>
                                            </td>
                                            <td style="text-align: right;">
                                                <c:forEach items="${m.value}" var="rio">
                                                    <fmt:formatNumber value="${rio.allTotal.usd}" pattern="###,###.##"/> USD<br/><fmt:formatNumber value="${rio.allTotal.vnd}" pattern="###,###.##"/> VND<br/>
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
            <div class="col-md-8"></div>
            <div class="col-md-4">
                <table class="table table-responsive" style="font-size: 14px;">
                    <thead>
                    <th colspan="3">Summary:</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Total:</td>
                            <td style="text-align: right;">${countRec}</td>
                            <td>Receivers</td>
                        </tr>
                        <tr>
                            <td>Total Amount(fee, tax,...):</td>
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
                                            
    </jsp:body>
</template:Admin>
