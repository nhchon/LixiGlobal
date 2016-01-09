<template:Client htmlTitle="Lixi Global - Customer Service">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            jQuery(document).ready(function () {
                $('#subject').change(function(){
                    if($(this).val() == '-1'){
                        $('#newSubjectDiv').show();
                    }
                    else{
                        $('#newSubjectDiv').hide();
                    }
                });
            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title">Help</h2>
                    <p>
                        <b>What can we help you with</b>
                    </p>
                    <form:form class="form-horizontal" modelAttribute="customerProblemForm">

                        <div class="row">
                            <div class="col-md-3">
                                Please select an issue
                            </div>
                            <div class="col-md-6">
                                <form:select path="subject" cssClass="form-control">
                                    <form:option value="0" label="--- Select ---"/>
                                    <form:options items="${subjects}" itemLabel="subject" itemValue="id"/>
                                    <form:option value="-1" label="Other"/>
                                </form:select>
                            </div>
                        </div>

                        <div class="row" id="newSubjectDiv" style="display:none;">
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-6">
                                <form:input path="otherSubject" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                Content
                            </div>
                            <div class="col-md-6">
                                <form:textarea path="content"  cssClass="form-control" rows="6"/>
                                <span class="help-block errors"><form:errors path="content" /></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                How would you like us to contact you?
                            </div>
                            <div class="col-md-6">
                                <form:select path="contactMethod" cssClass="form-control">
                                    <option value="1" <c:if test="${empty method}"> selected=""</c:if> label="Email">Email</option>
                                    <option value="2" <c:if test="${method eq 'Phone'}"> selected=""</c:if> label="Phone Call">Phone</option>
                                    <option value="3" <c:if test="${method eq 'Chat'}"> selected=""</c:if> label="Chat">Chat</option>
                                </form:select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                Please input your contact data
                            </div>
                            <div class="col-md-6">
                                <form:input path="contactData" cssClass="form-control"/>
                                <span class="help-block errors"><form:errors path="contactData" /></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                Please tell us your order Id<br/>
                                <span class="help-block">(Check your email)</span>
                            </div>
                            <div class="col-md-6">
                                <form:input path="orderId" cssClass="form-control"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-6">
                                <button type="submit" class="btn btn-primary">Submit</button>
                                <button class="btn btn-warning">Cancel</button>
                            </div>
                        </div>
                    </form:form>
                </div>
        </section>    
    </jsp:body>
</template:Client>