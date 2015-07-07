<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/jquery.dataTables.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.colVis.bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.colReorder.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.tableTools.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/dataTables.bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/king-table.js"/>"></script>
        <script type="text/javascript">
            var BUY = [];
            var SELL = [];
            <c:forEach items="${VCB.exrates}" var="ex">
                BUY['${ex.code}'] = ${ex.buy};
                SELL['${ex.code}'] = ${ex.sell};
            </c:forEach>
            $(document).ready(function () {
                setInterval(function () {

                    var curDate = new Date();
                    var dayStr = curDate.getDate() + "/" + (curDate.getMonth() + 1) + "/" + curDate.getFullYear();
                    var timeStr = (curDate.getHours() < 10 ? '0' + curDate.getHours() : curDate.getHours()) + ":"
                            + (curDate.getMinutes() < 10 ? '0' + curDate.getMinutes() : curDate.getMinutes()) + ":"
                            + (curDate.getSeconds() < 10 ? '0' + curDate.getSeconds() : curDate.getSeconds());
                    //
                    $('#dateInput').val(dayStr);
                    $('#timeInput').val(timeStr);
                }, 1000);
                
                // set default value for exchange rate
                resetBuyByPercentage();
                resetSellByPercentage();
                
                // check number percentage
                $('#buyPercentage').on('input', function(){
                    
                    if(!$.isNumeric(parseFloat($('#buyPercentage').val()))){
                        alert('<spring:message code="typeMismatch.java.lang.Double"/>');
                        $('#buyPercentage').focus();
                    }
                    else{
                        resetBuyByPercentage();
                    }
                    
                });
                $('#sellPercentage').on('input', function(){
                    
                    if(!$.isNumeric(parseFloat($('#sellPercentage').val()))){
                        alert('<spring:message code="typeMismatch.java.lang.Double"/>');
                        $('#sellPercentage').focus();
                    }
                    else{
                        resetSellByPercentage();
                    }
                    
                });
                
                $('#buy').on('input', function(){
                
                    if(!$.isNumeric(parseFloat($('#buy').val()))){
                        alert('<spring:message code="typeMismatch.java.lang.Double"/>');
                        $('#buy').focus();
                    }
                    else{
                        if(BUY[$("#currency option:selected").text()] === 0) 
                            $('#buyPercentage').val('0');
                        //
                        var p = parseFloat($('#buy').val())/BUY[$("#currency option:selected").text()]*100.0 - 100.0;
                        //alert(p + " : "+Math.round(p * 100.0) / 100.0)
                        $('#buyPercentage').val(Math.round(p * 100.0) / 100.0);
                    }
                    
                });
                
                $('#sell').on('input', function(){
                
                    if(!$.isNumeric(parseFloat($('#sell').val()))){
                        alert('<spring:message code="typeMismatch.java.lang.Double"/>');
                        $('#sell').focus();
                    }
                    else{
                        if(SELL[$("#currency option:selected").text()] === 0) 
                            $('#sellPercentage').val('0');
                        //
                        var p = parseFloat($('#sell').val())/SELL[$("#currency option:selected").text()]*100.0 - 100.0;
                        //alert(p + " : "+Math.round(p * 100.0) / 100.0)
                        $('#sellPercentage').val(Math.round(p * 100.0) / 100.0);
                    }
                    
                });

            });
            
            /**
             * 
             *
             * @returns {undefined}             
             */
            function resetBuyByPercentage(){
                $('#buy').val(BUY[$("#currency option:selected").text()]+(BUY[$("#currency option:selected").text()]*parseFloat($('#buyPercentage').val())/100.0));
            };
            
            /**
             * 
             */
            function resetSellByPercentage(){
                $('#sell').val(SELL[$("#currency option:selected").text()]+(SELL[$("#currency option:selected").text()]*parseFloat($('#sellPercentage').val())/100.0));
            };
        </script>
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <div class="col-md-10 content-wrapper" style="background-color: #ffffff">
            <div class="row">
                <div class="col-lg-4 ">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                        <li><a href="<c:url value="/Administration/SystemConfig/lixiExchangeRate"/>">LiXi Exchange Rates</a></li>
                    </ul>
                </div>
            </div>

            <!-- main -->
            <div class="content">
                <div class="main-header">
                    <h2 style="border-right:none;"><spring:message code="message.lixi_exchange_rates"/></h2>
                </div>
                <div class="main-content">
                    <div class="row">
                        <div class="col-sm-12">
                            <h4><spring:message code="message.vcb_official"/> at ${VCB.time}</h4>
                            <a href="http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx" target="_blank">http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx</a>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th><spring:message code="message.currency"/></th>
                                        <th><spring:message code="message.buy"/></th>
                                        <th><spring:message code="message.sell"/></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${VCB.exrates}" var="ex">
                                        <c:if test="${ex.code == 'USD'}">
                                            <tr>
                                                <th scope="row">${ex.code}</th>
                                                <td>${ex.buy}</td>
                                                <td>${ex.sell}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- From traders -->
                    <div class="row">
                        <div class="col-sm-12">
                            <h4 style="text-transform: capitalize;"><spring:message code="message.from_trader"/></h4>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th><spring:message code="message.name"/></th>
                                        <th><spring:message code="message.date"/></th>
                                        <th><spring:message code="message.time"/></th>
                                        <th><spring:message code="message.currency"/></th>
                                        <th><spring:message code="message.buy"/></th>
                                        <th><spring:message code="message.sell"/></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${EXCHANGE_RATES}" var="exr" varStatus="status">
                                        <tr>
                                            <td scope="row">${exr.traderId.name}</td>
                                            <td><fmt:formatDate value="${exr.dateInput}" pattern="dd/MM/yyyy"/></td>
                                            <td><fmt:formatDate value="${exr.timeInput}" pattern="HH:mm:ss"/></td>
                                            <td>${exr.currencyId.code}</td>
                                            <td>${exr.buy}</td>
                                            <td>${exr.sell}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="widget">
                        <div class="widget-header">
                            <h3><i class="fa fa-edit"></i><spring:message code="message.lixi_exchange_rates"/></h3>
                        </div>
                        <div class="widget-content">
                            <form:form method="post" role="form" modelAttribute="liXiExchangeRateForm" class="form-horizontal" novalidate="true">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label" for="dateInput"><spring:message code="message.date"/></label>
                                            <input name="dateInput" id="dateInput" type="text" class="form-control" readonly=""/>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label" for="timeInput"><spring:message code="message.time"/></label>
                                            <input name="timeInput" id="timeInput" class="form-control" readonly=""/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label for="currency"><spring:message code="message.currency"/></label>
                                            <select name="currency" id="currency" class="form-control">
                                                <c:forEach items="${CURRENCIES}" var="cur">
                                                    <c:if test="${cur.code != 'VND'}">
                                                        <option value="${cur.id}">${cur.code}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label for="buyPercentage">%</label>
                                            <form:input type="number" step="0.25" path="buyPercentage" class="form-control" value="-5" style="padding:6px 3px;"/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="buyPercentage" /></li></ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="buy"><spring:message code="message.buy"/></label>
                                            <form:input path="buy" class="form-control"/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="buy" /></li></ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label for="sellPercentage">%</label>
                                            <form:input type="number" step="0.25" path="sellPercentage" class="form-control" value="5" style="padding:6px 3px;"/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="sellPercentage" /></li></ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="sell"><spring:message code="message.sell"/></label>
                                            <form:input path="sell" class="form-control"/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="sell" /></li></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4"></div>
                                    <div class="col-sm-4">
                                        <button class="btn btn-primary" type="submit">Save Echange Rate</button>
                                    </div>
                                    <div class="col-sm-4"></div>
                                </div>
                            </form:form>
                        </div>
                    </div>            
                    <div class="row">
                        <div class="col-sm-12">
                            <h4><spring:message code="message.lixi_exchange_rates_history"/></h4>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th><spring:message code="message.name"/></th>
                                        <th><spring:message code="message.date"/></th>
                                        <th><spring:message code="message.time"/></th>
                                        <th><spring:message code="message.currency"/></th>
                                        <th><spring:message code="message.buy"/></th>
                                        <th>%</th>
                                        <th><spring:message code="message.sell"/></th>
                                        <th>%</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${LIXI_EXCHANGE_RATES}" var="lxexr" varStatus="status">
                                        <tr <c:if test="${status.count==1}">class="success"</c:if>>
                                            <td scope="row">${lxexr.createdBy}</td>
                                            <td><fmt:formatDate value="${lxexr.dateInput}" pattern="dd/MM/yyyy"/></td>
                                            <td><fmt:formatDate value="${lxexr.timeInput}" pattern="HH:mm:ss"/></td>
                                            <td>${lxexr.currency.code}</td>
                                            <td <c:if test="${status.count==1}">class="warning"</c:if>><b>${lxexr.buy}</b></td>
                                            <td><b>${lxexr.buyPercentage}%</b></td>
                                            <td <c:if test="${status.count==1}">class="warning"</c:if>><b>${lxexr.sell}</td>
                                            <td><b>${lxexr.sellPercentage}%</b></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
