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
                
                overlayOn($('#rowO'+id));
                $("#orderSubmitForm input[name=id]").val(id);
                
                $.ajax(
                {
                    url: '<c:url value="/Administration/Orders/submit2BK/"/>' + id,
                    type: "GET",
                    dataType: 'html',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        $('#status'+id).html(data);
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
            
            function cancel(id){
                
                if(confirm('Are you sure want to CANCEL this order id '+ id + ' ???')){
                    
                }
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/newOrders/-1"/>">New Orders</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">New Orders</h2>
        <div class="row">
            <div class="col-md-12">
                <form role="form" id="reportForm" action="<c:url value="/Administration/Orders/newOrders"/>" method="post">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="email">New Order's Status:</label>
                                <select class="form-control" id="oStatus" name="oStatus">
                                    <option value="">Please select status</option>
                                    <option value="-1" <c:if test="${oStatus eq '-1'}">selected=""</c:if>>New Order</option>
                                    <option value="0" <c:if test="${oStatus eq '0'}">selected=""</c:if>>Already Sent information to BaoKim Service</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <button type="button" id="btnSubmit" class="btn btn-primary">Run Report</button>
                </form>                
            </div>
        </div>
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
                                        <th>Status</th><%-- 7 --%>
                                        <th style="text-align: right;">Action</th><%-- 8 --%>
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
                                            <td>
                                                <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/>
                                                <br/>
                                                <fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/>
                                            </td>
                                            <td>${m.key.invoice.invoiceCode}</td>
                                            <td>${m.key.invoice.netTransId}</td>
                                            <td>${m.key.sender.fullName}</td>
                                            <td style="text-align: center;">
                                                <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                                    ${rio.recipient.fullName}
                                                    <br/>
                                                    <a href="javascript:void(0);">${rio.recipient.beautyId}</a>
                                                    <br/>
                                                </c:forEach>
                                            </td>
                                            <td style="text-align: right;">
                                                <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                                <fmt:formatNumber value="${rio.allTotal.usd}" pattern="###,###.##"/> USD
                                                <br/>
                                                <fmt:formatNumber value="${rio.allTotal.vnd}" pattern="###,###.##"/> VND
                                                <br/>
                                                </c:forEach>
                                            </td>
                                            <td id="status${m.key.id}">
                                                <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                                    <c:choose>
                                                        <c:when test="${rio.bkStatus eq 'Not Sent'}">
                                                           <span class="alert-danger">${rio.bkStatus}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="alert-success">${rio.bkStatus}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <br/>
                                                    <br/>
                                                </c:forEach>
                                            </td>
                                            <td style="text-align: right;">
                                                <c:if test="${oStatus eq '-1'}">
                                                    <a href="javascript:sent(${m.key.id});">Send</a>
                                                </c:if>
                                                <c:if test="${oStatus eq '0'}"><a href="javascript:void(0);">Cancel</a></c:if>
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
