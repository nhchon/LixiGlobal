<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">Enter a new billing address</h4>
</div>
<div class="modal-body">
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
    <form:form class="form-horizontal" modelAttribute="billingAddressForm">
        <fieldset>
            <legend><spring:message code="ba.title"/></legend>
            <div class="form-group">
                <div class="col-lg-4 col-md-4">
                    <label for="fullname" class="control-label"><spring:message code="ba.full_name"/></label>
                </div>
                <div class="col-lg-8 col-md-8">
                    <form:input path="fullName" class="form-control"/>
                    <span id="fullNameErrorSpan" class="help-block errors "><form:errors path="fullName" /></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-4 col-md-4">
                    <label for="address-1" class="control-label"><spring:message code="ba.add1"/></label>
                </div>
                <div class="col-lg-8 col-md-8">
                    <form:input path="add1" class="form-control" placeholder="" />
                    <span class="help-block errors "><form:errors path="add1" /></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-4 col-md-4">
                    <label for="address-2" class="control-label"><spring:message code="ba.add2"/></label>
                </div>
                <div class="col-lg-8 col-md-8">
                    <form:input path="add2" class="form-control" placeholder="" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-4 col-md-4">
                    <label for="city" class="control-label"><spring:message code="ba.city"/></label>
                </div>
                <div class="col-lg-8 col-md-8">
                    <form:input path="city" class="form-control" placeholder="" />
                    <span class="help-block errors "><form:errors path="city" /></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-4 col-md-4">
                    <label for="state" class="control-label"><spring:message code="ba.state"/></label>
                </div>
                <div class="col-lg-3 col-md-3">
                    <form:input path="state" class="form-control" placeholder="" />
                    <span class="help-block errors "><form:errors path="state" /></span>
                </div>
                <div class="col-lg-2 col-md-2">
                    <label for="zip" class="control-label"><spring:message code="ba.zip"/></label>
                </div>
                <div class="col-lg-3 col-md-3">
                    <form:input path="zipCode" class="form-control" placeholder="" />
                    <span class="help-block errors "><form:errors path="zipCode" /></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-4 col-md-4">
                    <label for="phone" class="control-label"><spring:message code="ba.phone"/></label>
                </div>
                <div class="col-lg-8 col-md-8">
                    <form:input path="phone" class="form-control" placeholder="" />
                    <span class="help-block errors "><form:errors path="phone" /></span>
                </div>
            </div>
            <div class="form-group right">
                <div class="col-lg-4 col-md-4"></div>
                <div class="col-lg-8 col-md-8">
                    <button onclick="return saveNewBillingAddress();" type="submit" class="btn btn-primary"><spring:message code="message.save"/></button>
                </div>
            </div>
        </fieldset>
    </form:form>
</div>