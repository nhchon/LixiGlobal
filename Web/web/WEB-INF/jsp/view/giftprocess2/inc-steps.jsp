<div class="gift-selection-step text-center">
    <div class="row">
        <div class="col-md-3 gift-selection-step-first">
            <div class="gift-step">
                <a class="<c:if test="${localStep eq 4}">active </c:if> hvr-radial-out" href="<c:url value="/gifts/choose"/>">
                    <span class="step-number">1</span>
                </a>
                <h5><spring:message code="choose-gift"/></h5>
            </div>
        </div>
        <div class="col-md-3">
            <div class="gift-step">
                <a class="<c:if test="${localStep eq 5}">active </c:if> hvr-radial-out" href="<c:url value="/gifts/order-summary"/>">
                    <span class="step-number">2</span>
                </a>
                    <h5><spring:message code="order-summary"/></h5>
            </div>
        </div>
        <div class="col-md-3">
            <div class="gift-step">
                <a class="<c:if test="${localStep eq 6}">active </c:if> hvr-radial-out" href="<c:url value="/checkout/paymentMethods"/>">
                    <span class="step-number">3</span>
                </a>
                    <h5><spring:message code="choose-payment"/></h5>
            </div>
        </div>
        <div class="col-md-3 gift-selection-step-last">
            <div class="gift-step">
                <a class="<c:if test="${localStep eq 7}">active </c:if>hvr-radial-out" href="<c:url value="/checkout/place-order"/>">
                    <span class="step-number">4</span>
                </a>
                    <h5><spring:message code="place-order"/></h5>
            </div>
        </div>
    </div>
</div>
