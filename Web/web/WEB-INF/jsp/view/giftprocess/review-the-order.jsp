<template:Client htmlTitle="LiXi Global - Review The Order">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="email-already-in-use" class="normal-page">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <h1><spring:message code="gift.review_order"/></h1>
                        <br/>
                        <div class="row">
                            <div class="col-lg-2 col-md-2">
                                <spring:message code="message.exchange_rate"/>:
                            </div>
                            <div class="col-lg-10 col-md-10">
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                    <input type="text" class="form-control" id="rate-from" value="1 ${LIXI_ORDER.lxExchangeRate.currency.code}" readonly=""/>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2" style="text-align: center;">
                                    <img alt="" src="<c:url value="/resource/theme/assets/lixiglobal/img/currency.exchange.jpg"/>" />
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                    <input type="text" class="form-control" name="exchangeRate" id="exchangeRate" value="${LIXI_ORDER.lxExchangeRate.buy} VND" readonly=""/>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <table class="table">
                                    <thead>
                                    <th>Name</th>
                                    <th>Gift</th>
                                    <th>Quantity</th>
                                    <th style="text-align: right;">Price</th>
                                    <th style="text-align: right;">Total</th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <c:set var="total" value="0"/>
                                        <c:forEach items="${REC_GIFTS}" var="entry">
                                            <tr style="background-color: #f9f9f9;">
                                                <td class="col-md-2"><strong>${entry.key.firstName}&nbsp;${entry.key.middleName}&nbsp;${entry.key.lastName}</strong></td>
                                                <td class="col-md-2"></td>
                                                <td class="col-md-1"></td>
                                                <td class="col-md-2" style="text-align: right;"></td>
                                                <td class="col-md-2" style="text-align: right;"></td>
                                                <td class="col-md-3" style="text-align: right;"><a href="<c:url value="/gifts/add-more/${entry.key.id}"/>" class="btn btn-sm btn-success">Add More</a></td>
                                            </tr>
                                            <c:set var="recTotal" value="0"/>
                                            <c:forEach items="${entry.value}" var="g">
                                                <tr>
                                                    <td class="col-md-2"></td>
                                                    <td class="col-md-2">${g.productName}</td>
                                                    <td class="col-md-1">${g.productQuantity}</td>
                                                    <td class="col-md-2" style="text-align: right;">
                                                        <fmt:formatNumber value="${g.productPrice / LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/> USD <br/>
                                                        <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND
                                                    </td>
                                                    <td class="col-md-2" style="text-align: right;">
                                                        <fmt:formatNumber value="${g.productPrice * g.productQuantity / LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/> USD<br/>
                                                        <fmt:formatNumber value="${g.productPrice * g.productQuantity}" pattern="###,###.##"/> VND
                                                    </td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <a href="<c:url value="/gifts/change/${g.id}"/>" class="btn btn-sm btn-primary">Change</a>
                                                        <a href="javascript:confirmDeleteItem(${g.id})" class="btn btn-sm btn-danger">Delete</a>
                                                    </td>
                                                    <c:set var="total" value="${total + g.productPrice * g.productQuantity}"/>
                                                    <c:set var="recTotal" value="${recTotal + g.productPrice * g.productQuantity}"/>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">
                                                <strong><fmt:formatNumber value="${recTotal / LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/></strong> USD<br/>
                                                <strong><fmt:formatNumber value="${recTotal}" pattern="###,###.##"/></strong> VND
                                            </td>
                                            <td></td>
                                            </tr>                                                
                                            <!-- // message -->
                                            <tr>
                                                <td class="col-md-2">Message:</td>
                                                <td class="col-md-7" colspan="5">
                                                    <div class="row">
                                                        <div class="col-md-10">
                                                            <textarea class="form-control">${entry.key.note}</textarea>
                                                        </div>
                                                        <div class="col-md-2" style="vertical-align: middle;">
                                                            <button class="btn btn-sm btn-primary">Edit</button>
                                                        </div>
                                                    </div>
                                                </td>
                                                
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">
                                                <strong><fmt:formatNumber value="${total / LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/></strong> USD<br/>
                                                <strong><fmt:formatNumber value="${total}" pattern="###,###.##"/></strong> VND
                                            </td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="btns">
                            <a href="billing-address.php" class="btn btn-primary left">Back</a>
                            <a href="pay-by-card.php" class="btn btn-primary">Pay by Card</a>
                            <a href="pay-by-bank-account.php" class="btn btn-primary">Pay by Bank Account</a>
                        </div>                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>