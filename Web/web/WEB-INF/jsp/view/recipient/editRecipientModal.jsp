<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">Edit Receiver Information</h4>
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
    <c:url value="/recipient/editRecipient" var="editRecipientUrl"/>
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
                <label class="control-label"><spring:message code="gift.email_of_recipient"/></label>
            </div>
            <div class="col-lg-7 col-md-7">
                <form:input path="email" class="form-control" placeholder="${emailMessage}" />
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
                <%--
            <div class="row">
                <div class="col-md-12"><span class="help-block">(Only mobile phone number. No first 0 i.e. 967 00 78 69, 169 262 31 88)</span></div>
            </div>
                --%>
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
                <span class="errors">*</span> : <i>is required</i>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-lg-12" style="text-align: right;">
                <form:hidden path="recId"/>
                <button id="btnCancel" type="button" class="btn btn-warning"  data-dismiss="modal"><spring:message code="message.cancel"/></button>
                <button onclick="return checkSubmitRecipientFormOnModal();" id="btnSave" type="button" class="btn btn-primary"><spring:message code="message.save"/></button>
            </div>
        </div>
    </form:form>
</div>