<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Choose Receiver to Sent Gift | Lixi.global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/select-receiver.js"/>"></script>
        <script type="text/javascript">
            var CHOOSE_RECEIVER_PATH = '<c:url value="/gifts/chooseRecipient/"/>';
            var LOAD_RECEIVER_PATH = '<c:url value="/gifts/loadRec"/>';
            /** Page Script **/
            $(document).ready(function () {

            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="section-gift bg-default section-wrapper">
            <div class="container">
                <c:set var="localStep" value="2"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <spring:message code="message.first_name" var="firstNameMessage"/>
                <spring:message code="message.middle_ini" var="middleMessage"/>
                <spring:message code="message.last_name" var="lastNameMessage"/>
                <spring:message code="message.email_place_holder" var="emailMessage"/>
                <form:form modelAttribute="chooseRecipientForm"  class="receiver-form">
                    <div class="section-receiver">
                        <h2 class="title">Receiver</h2>
                        <c:if test="${not empty RECIPIENTS}">
                            <div class="form-group form-group-inline">
                                <label for="input-receiver" class="form-control-with-select-box">Select a previous receiver :</label>
                                <select class="selectpicker" id="recId" name="recId">
                                    <option value="0"><spring:message code="gift.select_recipient"/></option>
                                    <c:forEach items="${RECIPIENTS}" var="rec">
                                        <option value="${rec.id}" <c:if test="${chooseRecipientForm.recId == rec.id}">selected</c:if>>${rec.firstName}&nbsp;${rec.middleName}&nbsp;${rec.lastName} </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>
                        <h4><c:if test="${not empty RECIPIENTS}"><spring:message code="message.or"/>&nbsp;</c:if><spring:message code="gift.input_recipient"/>:</h4>
                            <div class="row">
                                <div class="col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="firstName">First Name:</label>
                                    <form:input path="firstName" class="form-control" placeholder="${firstNameMessage}" />
                                    <div class="has-error"><form:errors path="firstName" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="middleName">Middle Name:</label>
                                    <form:input path="middleName" class="form-control" placeholder="${middleMessage}" />
                                    <div class="has-error"><form:errors path="middleName" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="lastName">Last Name:</label>
                                    <form:input path="lastName" class="form-control" placeholder="${lastNameMessage}" />
                                    <div class="has-error"><form:errors path="lastName" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="emailAddress">Email Address:</label>
                                    <form:input path="email" class="form-control" placeholder="${emailMessage}" />
                                    <div class="has-error"><form:errors path="email" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>

                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="phoneNumber">Phone Number:</label>
                                    <div class="row">
                                        <div class="col-md-2" style="padding-right: 0px;">
                                            <form:select path="dialCode"  class="form-control">
                                                <option value="+84">+84</option>
                                                <option value="+1">+1</option>
                                            </form:select>
                                        </div>
                                        <div class="col-md-10" style="padding-left: 0px;">
                                            <form:input path="phone" class="form-control"/>
                                            <div class="has-error"><form:errors path="phone" cssClass="help-block" element="div"/></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="messenger">Messenger:</label>
                            <form:textarea class="form-control" path="note" maxlength="128"/>
                        </div>
                    </div>
                    <div class="button-control gift-total-wrapper text-center text-uppercase">
                        <div class="button-control-page">
                            <button class="btn btn-default btn-has-link-event" type="button">BACK</button>
                            <button class="btn btn-primary btn-has-link-event" type="submit">NEXT</button>
                        </div>
                    </div>
                </form:form>
            </div>
        </section>
    </jsp:body>
</template:Client>