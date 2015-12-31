<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <script type="text/javascript">
            var BUY = [];
            var SELL = [];
        </script>
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
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

                // default
                $('#vcbBuy').val(BUY[$("#currency option:selected").text()]);
                $('#vcbSell').val(SELL[$("#currency option:selected").text()]);
                // onchange
                $('#currency').change(function () {
                    $('#vcbBuy').val(BUY[$("#currency option:selected").text()]);
                    $('#vcbSell').val(SELL[$("#currency option:selected").text()]);
                });
            });

        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-85-0">
            <div class="container">
                <fieldset>
                    <legend>Welcome ${TRADER_LOGIN_USERNAME} ! Please input your exchange rate</legend>
                    <div class="row">
                        <div class="col-lg-12">
                            <h4><spring:message code="message.vcb_official"/> at ${VCB.time}</h4>
                            <a href="http://www.vietcombank.com.vn/ExchangeRates/" target="_blank">http://www.vietcombank.com.vn/ExchangeRates/</a>
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
                                        <script type="text/javascript">
                                            BUY['${ex.code}'] = '${ex.buy}';
                                            SELL['${ex.code}'] = '${ex.sell}';
                                        </script>
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
                    <h4>Your Exchange Rate</h4>
                    <div class="row">
                        <c:if test="${validationErrors != null}"><div class="errors">
                                <ul>
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div></c:if>
                        <form:form method="post" role="form" modelAttribute="traderExchangeRateForm">
                            <div class="col-lg-2">
                                <label for="dateInput"><spring:message code="message.date"/></label>
                                <input name="dateInput" id="dateInput" type="text" class="form-control" readonly=""/>
                            </div>
                            <div class="col-lg-2">
                                <label for="timeInput"><spring:message code="message.time"/></label>
                                <input name="timeInput" id="timeInput" class="form-control" readonly=""/>
                            </div>
                            <div class="col-lg-2">
                                <label for="currency"><spring:message code="message.currency"/></label>
                                <select name="currency" id="currency" class="form-control">
                                    <c:forEach items="${CURRENCIES}" var="cur">
                                        <c:if test="${cur.code != 'VND'}">
                                            <option value="${cur.id}">${cur.code}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-lg-2">
                                <label for="buy"><spring:message code="message.buy"/></label>
                                <form:input path="buy" class="form-control"/>
                                <span class="help-block with-errors errors"><form:errors path="buy" /></span>
                            </div>
                            <div class="col-lg-2">
                                <label for="sell"><spring:message code="message.sell"/></label>
                                <form:input path="sell" class="form-control"/>
                                <span class="help-block with-errors errors"><form:errors path="sell" /></span>
                            </div>
                            <div class="col-lg-2">
                                <label>&nbsp;</label>
                                <button type="submit" class="btn btn-primary form-control" style="margin-top: 0px;">Save</button>
                            </div>
                            <input type="hidden" name="vcbBuy" id="vcbBuy"/>
                            <input type="hidden" name="vcbSell" id="vcbSell"/>
                        </form:form>
                    </div>

                    <h4>Your History</h4>
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
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
                                    <c:forEach items="${EXCHANGE_RATES}" var="exr" varStatus="status">
                                        <tr <c:if test="${status.count==1}">class="warning"</c:if>>
                                            <th scope="row"><fmt:formatDate value="${exr.dateInput}" pattern="dd/MM/yyyy"/></th>
                                            <td><fmt:formatDate value="${exr.timeInput}" pattern="HH:mm:ss"/></td>
                                            <td>${exr.currency.code}</td>
                                            <td>${exr.buy}</td>
                                            <td>${exr.buyPercentage}</td>
                                            <td>${exr.sell}</td>
                                            <td>${exr.sellPercentage}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </fieldset>
            </div>
        </section>
    </jsp:body>
</template:Client>