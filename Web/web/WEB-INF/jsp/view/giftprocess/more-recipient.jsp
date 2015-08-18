<template:Client htmlTitle="LiXi Global - Add Additional Recipient?">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var CONFIRM_MESSAGE = "<spring:message code="gift.delete_confirm"/>";
            function confirmDeleteItem(id) {

                if (confirm(CONFIRM_MESSAGE)) {
                    document.location.href = "<c:url value="/gifts/delete?gift="/>" + id;
                }

            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="email-already-in-use" class="normal-page">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <c:if test="${wrong eq 1 || param.wrong eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.there_is_something_wrong"/>
                            </div>
                        </c:if>

                        <h1>Summary</h1>
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
                                            <c:forEach items="${entry.value}" var="g">
                                                <tr>
                                                    <td class="col-md-2"></td>
                                                    <td class="col-md-2">${g.productName}</td>
                                                    <td class="col-md-1">${g.productQuantity}</td>
                                                    <td class="col-md-2" style="text-align: right;"><fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/></td>
                                                    <td class="col-md-2" style="text-align: right;"><fmt:formatNumber value="${g.productPrice * g.productQuantity}" pattern="###,###.##"/></td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <a href="<c:url value="/gifts/change/${g.id}"/>" class="btn btn-sm btn-primary">Change</a>
                                                        <a href="javascript:confirmDeleteItem(${g.id})" class="btn btn-sm btn-danger">Delete</a>
                                                    </td>
                                                    <c:set var="total" value="${total + g.productPrice * g.productQuantity}"/>
                                                </tr>
                                            </c:forEach>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td></td>
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
                            <a href="<c:url value="/gifts/review"/>" class="btn btn-primary">No, thank you</a>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>