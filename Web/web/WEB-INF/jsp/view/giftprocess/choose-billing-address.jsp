<template:Client htmlTitle="Lixi Global - Choose a Billing Address">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var BILLING_ADDRESS_MODAL_URL = '<c:url value="/checkout/billing-address-modal"/>';
            var NOT_NULL_MESSAGE = '<spring:message code="validate.not_null"/>';
        </script>
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/billingAddress.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class="section-85-0">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <c:if test="${validationErrors != null}"><div class="msg msg-error">
                                <ul style="margin-bottom: 0px;">
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div></c:if>
                        <c:if test="${card_failed eq 1 || param.card_failed eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.checkout.card_failed"/>
                            </div>
                        </c:if>                        
                        <fieldset>
                            <legend>Choose a billing address</legend>
                            <div class="row">
                                <div class="col-md-12">
                                    Please choose a billing address from your address book below, or <a href="javascript:newBillingAddress();">enter a new billing address</a>
                                </div>
                            </div>
                            <div class="page-header">
                                <h3>Your address book</h3>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <c:forEach items="${BILLING_ADDRESS_ES.content}" var="ba" varStatus="theCount">
                                        <c:if test="${theCount.index%3 eq 0}">
                                            <div class="row">
                                            </c:if>
                                            <div class="col-lg-4">
                                                <b>${ba.fullName}</b>
                                                <br/>
                                                ${fn:substring(ba.add1, 0, 35)}...<br/>
                                                <c:if test="${not empty ba.add2}">${ba.add2}<br/></c:if>
                                                ${ba.city}
                                                <br/>
                                                ${ba.state}&nbsp;${ba.zipCode}
                                                <br/>
                                                Phone: ${ba.phone}
                                                <br/><br/>
                                                <button type="button" onclick="document.location.href='<c:url value="/checkout/billing-address/${ba.id}"/>';" class="btn btn-primary">Use this address</button>
                                            </div>
                                            <c:if test="${theCount.count%3 eq 0 or theCount.last}">
                                                <p>&nbsp;</p>
                                            </div>
                                        </c:if>
                                        <input type="hidden" id="billingAdd-${ba.id}" value="${ba.fullName}, ${ba.add1}
                                               <c:if test="${not empty ba.add2}">&nbsp; ${ba.add2}}</c:if>
                                                   , ..."/>
                                    </c:forEach>
                                </div></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <nav style="text-align: right;">
                                        <ul class="pagination">
                                            <c:forEach begin="1" end="${BILLING_ADDRESS_ES.totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${(i - 1) == BILLING_ADDRESS_ES.number}">
                                                        <li class="paginate_button active">
                                                            <a href="javascript:void(0)">${i}</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button">
                                                            <a href="<c:url value="/checkout/choose-billing-address">
                                                                   <c:param name="paging.page" value="${i}" />
                                                                   <c:param name="paging.size" value="6" />
                                                               </c:url>">${i}</a>                            
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </ul>
                                    </nav>    

                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>
        <!-- Billing Address Modal -->
        <div class="modal fade" id="billingAddressListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="billingAddressListContent">
                </div>
            </div>
        </div>

    </jsp:body>
</template:Client>