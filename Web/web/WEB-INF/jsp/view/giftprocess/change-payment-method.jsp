<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-85-0">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <form action="${pageContext.request.contextPath}/checkout/cards/change" method="post">
                            <fieldset>
                                <legend>Change Payment Method</legend>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Your credit and debit cards</th>
                                            <th>Name on card</th>
                                            <th>Expires on</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${CARDS}" var="c">
                                            <tr>
                                                <td>
                                                    <c:set var="lengthCard" value="${fn:length(c.cardNumber)}"/>
                                                    <div class="radio">
                                                        <label><input <c:if test="${LIXI_ORDER.card.id == c.id}">checked=""</c:if> type="radio" name="cardId" value="${c.id}"> <b>${c.cardTypeName}</b> ending in ${fn:substring(c.cardNumber, lengthCard-4, lengthCard)}</label>
                                                        </div>
                                                    </td>
                                                    <td>${c.cardName}</td>
                                                <td><c:if test="${c.expMonth < 10}">0${c.expMonth}</c:if><c:if test="${c.expMonth >= 10}">${c.expMonth}</c:if>/${c.expYear}</td>
                                                </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td><button type="submit" class="btn btn-primary">Use this payment method</button></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>