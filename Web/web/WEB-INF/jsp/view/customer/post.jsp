<template:Client htmlTitle="LiXi Global - Customer Service">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2>Help</h2>
                    <div class="form-group">
                        <div class="desc">
                            What can we help you with
                        </div>
                    </div>
                    <form:form class="form-horizontal" modelAttribute="customerProblemForm">
                        <div class="form-group">
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
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-6">
                                    <form:input path="otherSubject" cssClass="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    Content
                                </div>
                                <div class="col-md-6">
                                    <form:textarea path="content"  cssClass="form-control" rows="6"/>
                                    <span class="help-block errors"><form:errors path="content" /></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    How would you like us to contact you?
                                </div>
                                <div class="col-md-6">
                                    <form:select path="contactMethod" cssClass="form-control">
                                        <form:option value="1" label="Email"/>
                                        <form:option value="2" label="Phone Call"/>
                                        <form:option value="3" label="Chat"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    Please input your contact data
                                </div>
                                <div class="col-md-6">
                                    <form:input path="contactData" cssClass="form-control"/>
                                    <span class="help-block errors"><form:errors path="contactData" /></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    Please tell us your order Id<br/>
                                    <span class="help-block">(Check your email)</span>
                                </div>
                                <div class="col-md-6">
                                    <form:input path="orderId" cssClass="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                    <button class="btn btn-warning">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </div></div></section>    
    </jsp:body>
</template:Client>