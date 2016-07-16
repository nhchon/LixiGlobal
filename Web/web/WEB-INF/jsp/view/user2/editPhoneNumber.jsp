<template:Client htmlTitle="Lixi Global - Edit Your Phone Number">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var PHONE_REQUIRED = '<spring:message code="validate.phone_required" text="The phone number is required."/>';
            jQuery(document).ready(function () {
                $("#phone").mask("(999) 999-999?9");
            })
            
            function checkPhone(){
                if($("#phone").val()==''){
                    alert(PHONE_REQUIRED);
                    return false;
                }
                
                return true;
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="main-section bg-default">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <c:if test="${validationErrors != null}"><div class="msg msg-error">
                            <ul>
                                <c:forEach items="${validationErrors}" var="error">
                                    <li><c:out value="${error.message}" /></li>
                                    </c:forEach>
                            </ul>
                        </div></c:if>
                    <%-- place holder message --%>
                    <%-- // End place holder message --%>
                    <c:url value="/user/editPhoneNumber" var="formEditPhoneNumberUrl"/>
                    <h2 class="title"><spring:message code="message.change_mobile_number"/></h2>
                    <form role="form" method="post" action="${formEditPhoneNumberUrl}" onsubmit="return checkPhone()">
                        <div class="row">
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label class="control-label"><spring:message code="message.mobile_number"/></label>
                            </div>
                        </div>
                        <div class="row">
                                <div class="col-md-1" style="padding-right: 0px;margin-bottom: 10px;">
                                    <select class="form-control" name="dialCode" id="dialCode">
                                        <option value="+1" <c:if test="${dialCode eq '+1'}">selected=""</c:if>>+1</option>
                                        <option value="+84" <c:if test="${dialCode eq '+84'}">selected=""</c:if>>+84</option>
                                    </select>
                                    </div>
                                <div class="col-md-7" style="padding-left: 0px;margin-bottom: 10px;">
                                   <input type="text" class="form-control" name="phone" id="phone" value="<c:out value="${phone}"/>"/>
                                </div>
                            <%--
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label class="control-label"><spring:message code="message.mobile_number"/></label>
                                <input type="text" class="form-control" name="phone" id="phone" value="<c:out value="${phone}"/>"/>
                            </div>
                            --%>
                        </div>
                        <div class="row right">
                            <div class="col-md-8">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="button" class="btn btn-warning btn-has-link-event" data-link="<c:url value="/user/yourAccount"/>"><spring:message code="message.cancel"/></button>
                                <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="message.save_changes"/></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>