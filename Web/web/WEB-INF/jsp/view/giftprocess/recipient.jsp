<template:Client htmlTitle="LiXi Global - Choose Recipient">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/recipient.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            $(document).ready(function () {
                
                $('#recId').change(function () {
                    
                    if($(this).val() > 0){
                        
                        document.location.href = '<c:url value="/gifts/chooseRecipient/"/>'+$(this).val();
                    }
                    else{
                        
                        if($(this).val() == 0){
                            // clear form
                            clearRecipientForm();
                        }
                    }
                });
                // clear button
                $('#btnClear').click(function(){
                    
                    clearRecipientForm();
                    
                });
            });
            
            function clearRecipientForm(){
                // recipient
                $('#recId').val('0');
                // first name
                $('#firstName').val('');
                // middle
                $('#middleName').val('');
                // last
                $('#lastName').val('');
                // email
                $('#email').val('');
                // phone
                $('#phone').val('');
                // note
                $('#note').val('');
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <section id="recipient">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <spring:message code="message.first_name" var="firstNameMessage"/>
                        <spring:message code="message.middle_ini" var="middleMessage"/>
                        <spring:message code="message.last_name" var="lastNameMessage"/>
                        <spring:message code="message.email_place_holder" var="emailMessage"/>
                        <c:if test="${validationErrors != null}"><div class="msg msg-error">
                        <ul style="margin-bottom: 0px;">
                            <c:forEach items="${validationErrors}" var="error">
                                <li><c:out value="${error.message}" /></li>
                            </c:forEach>
                        </ul>
                        </div></c:if>
                        <form:form modelAttribute="chooseRecipientForm"  class="form-horizontal">
                            
                            <c:if test="${not empty RECIPIENTS}">
                                <fieldset>
                                <legend><spring:message code="gift.select_recipient"/></legend>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <select class="form-control" id="recId" name="recId">
                                            <option value="0"><spring:message code="gift.select_recipient"/></option>
                                            <c:forEach items="${RECIPIENTS}" var="rec">
                                                <option value="${rec.id}" <c:if test="${chooseRecipientForm.recId == rec.id}">selected</c:if>>${rec.firstName}&nbsp;${rec.middleName}&nbsp;${rec.lastName} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                </fieldset>
                                            <br/>
                            </c:if>
                            
                            <fieldset>
                                <legend><c:if test="${not empty RECIPIENTS}"><spring:message code="message.or"/>&nbsp;</c:if><spring:message code="gift.input_recipient"/></legend>
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
                                        <form:input path="phone" class="form-control"/>
                                        <span class="help-block errors"><form:errors path="phone" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label class="control-label"><spring:message code="gift.note"/></label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:textarea class="form-control" path="note" maxlength="128" placeholder="Happy birthday"/>
                                    </div>
                                </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <span class="errors">*</span> : <i>is required</i>
                                        </div>
                                    </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <button id="btnClear" type="button" class="btn btn-warning"><spring:message code="message.clear"/></button>
                                        <button type="submit" class="btn btn-primary"><spring:message code="message.next"/></button>
                                    </div>
                                </div>
                            </fieldset>
                        </form:form>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>