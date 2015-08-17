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
                        <h1>Review The Order</h1>
                        <div class="row">

                            <div class="col-lg-3 col-md-3">
                                Exchange Rate
                            </div>
                            <div class="col-lg-9 col-md-9">
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                    <input type="text" class="form-control" id="rate-from" value="1 ${LIXI_ORDER.lxExchangeRate.currency.code}" readonly=""/>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                    <img alt="" src="<c:url value="/resource/theme/assets/lixiglobal/img/currency.exchange.jpg"/>" />
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                    <input type="text" class="form-control" name="exchangeRate" id="exchangeRate" value="${LIXI_ORDER.lxExchangeRate.buy} VND" readonly=""/>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <table class="table table-striped">
                                    <thead>
                                    <th>Name</th>
                                    <th>Gift</th>
                                    <th></th>
                                    <th style="text-align: right;">Price</th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <c:set var="total" value="0"/>
                                        <c:forEach items="${LIXI_ORDER.gifts}" var="g">
                                            <tr>
                                                <td class="col-md-3">${g.recipient.firstName}&nbsp;${g.recipient.middleName}&nbsp;${g.recipient.lastName}</td>
                                                <td class="col-md-2">${g.productName}</td>
                                                <td class="col-md-2"><img width="144" height="144" alt="" src="${g.productImage}" /></td>
                                                <td class="col-md-2" style="text-align: right;"><fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/></td>
                                                <td class="col-md-3" style="text-align: right;">
                                                    <a href="<c:url value="/gifts/chooseRecipient/${g.recipient.id}"/>" class="btn btn-sm btn-primary">Edit</a>
                                                    <a href="javascript:confirmDeleteItem(${g.id})" class="btn btn-sm btn-danger">Delete</a>
                                                </td>
                                                <c:set var="total" value="${total + g.productPrice}"/>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;"><strong><fmt:formatNumber value="${total}" pattern="###,###.##"/></strong></td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <h1>Add Additional Recipient?</h1>
                        <br />
                        <p>Do you want to send a gift to another person?</p>
                        <div class="btns">
                            <a href="<c:url value="/gifts/recipient"/>" class="btn btn-primary">Yes, I do</a>
                            <a href="javascript:alert('In Development');" class="btn btn-primary">No, thank you</a>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>