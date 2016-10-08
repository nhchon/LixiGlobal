<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title"><spring:message code="edit-rec"/></h4>
</div>
<div class="modal-body">
    <c:if test="${validationErrors != null}"><div class="msg msg-error">
            <ul style="margin-bottom: 0px;">
                <c:forEach items="${validationErrors}" var="error">
                    <li><c:out value="${error.message}" /></li>
                    </c:forEach>
            </ul>
        </div></c:if>
    <c:if test="${duplicate eq 1 || param.duplicate eq 1}">
        <div class="msg msg-error">
            <spring:message code="validate.dup_reci">
                <spring:argument value="${recipientName}"/>
                <spring:argument value="${recipientPhone}"/>
            </spring:message>
        </div>
    </c:if>                        
    <spring:message code="message.first_name" var="firstNameMessage"/>
    <spring:message code="message.middle_ini" var="middleMessage"/>
    <spring:message code="message.last_name" var="lastNameMessage"/>
    <spring:message code="message.email_place_holder" var="emailMessage"/>
    <spring:message code="signup.retype_email" var="retypeEmail"/>
    <c:url value="/recipient/editRecipient" var="editRecipientUrl"/>
    <c:if test="${not empty adminEditRecipient}">
        <c:url value="${adminEditRecipient}" var="editRecipientUrl"/>
    </c:if>
    <form:form action="${editRecipientUrl}" modelAttribute="chooseRecipientForm" class="form-horizontal">
        <div class="form-group name">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.name_of_recipient"/><span class="errors">*</span></label>
            </div>
            <div class="col-lg-7 col-md-7">
                <div class="row">
                    <div class="col-lg-4 col-md-4">
                        <form:input path="firstName" class="form-control" placeholder="${firstNameMessage}" />
                        <span class="help-block errors " style="font-size: 12px;"><form:errors path="firstName" /></span>
                    </div>
                    <div class="col-lg-4 col-md-4">
                        <form:input path="middleName" class="form-control" placeholder="${middleMessage}" />
                        <span class="help-block errors"><form:errors path="middleName" /></span>
                    </div>
                    <div class="col-lg-4 col-md-4">
                        <form:input path="lastName" class="form-control" placeholder="${lastNameMessage}" />
                        <span class="help-block errors" style="font-size: 12px;"><form:errors path="lastName" /></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.email_of_recipient"/><span class="errors">*</span></label>
            </div>
            <div class="col-lg-7 col-md-7">
                <form:input path="email" class="form-control" placeholder="${emailMessage}" autocomplete="off" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"></label>
            </div>
            <div class="col-lg-7 col-md-7">
                <form:input path="confEmail" class="form-control" placeholder="${retypeEmail}" autocomplete="off" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.phone_of_recipient"/><span class="errors">*</span></label>
            </div>
            <div class="col-lg-7 col-md-7">
                <div class="row">
                    <div class="col-md-2" style="padding-right: 0px;">
                        <form:select class="form-control" path="dialCode">
                            <option value="+84" <c:if test="${chooseRecipientForm.dialCode eq '+84'}">selected=""</c:if>>+84</option>
                            <option value="+1" <c:if test="${chooseRecipientForm.dialCode eq '+1'}">selected=""</c:if>>+1</option>
                        </form:select>
                        </div>
                    <div class="col-md-10" style="padding-left: 0px;">
                        <form:input path="phone" class="form-control"/>

                        <span class="help-block errors"><form:errors path="phone" /></span>
                    </div>
                </div>
            <div class="row">
                <div class="col-md-12"><span class="help-block">(<spring:message code="phone-example"/>)</span></div>
            </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.note"/></label>
            </div>
            <div class="col-lg-7 col-md-7">
                <form:textarea class="form-control" path="note" maxlength="128"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-12">
                <span class="errors">*</span> : <i><spring:message code="is-required"/></i>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-lg-4" style="text-align: left;">
                <c:if test="${not empty chooseRecipientForm.recId and empty adminEditRecipient}">
                    
                    <button id="btnDeleteRec" class="btn btn-danger" type="button" onclick="deleteRecipient()"><spring:message code="message.delete"/></button>
                </c:if>
            </div>
            <div class="col-lg-8" style="text-align: right;">
                <form:hidden path="recId"/>
                <form:hidden path="action"/>
                <button onclick="return checkSubmitRecipientFormOnModal();" id="btnSave" type="button" class="btn btn-primary"><spring:message code="message.save"/></button>
                <button id="btnCancel" type="button" class="btn btn-warning"  data-dismiss="modal"><spring:message code="message.cancel"/></button>
            </div>
        </div>
    </form:form>
</div>