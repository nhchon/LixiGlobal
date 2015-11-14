<template:Client htmlTitle="LiXi Global - Customer Service">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-85-0">
            <div class="container">
                <fieldset>
                    <legend>Help</legend>
                    <div class="form-group">
                    <div class="desc">
                        What can we help you with
                    </div>
                        </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3">
                                Please select an issue
                            </div>
                            <div class="col-md-6">
                                <select id="issues" class="form-control">
                                    <option value="0">Please make a selection</option>
                                    <option value="1">I cannot access my account.</option>
                                    <option value="-1">Other</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-6">
                                <input type="text" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3">
                               Content
                            </div>
                            <div class="col-md-6">
                                <textarea class="form-control" rows="6"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3">
                                How would you like us to contact you?
                            </div>
                            <div class="col-md-6">
                                <select id="issues" class="form-control">
                                    <option value="0">Email</option>
                                    <option value="1">Phone Call</option>
                                    <option value="-1">Chat</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3">
                                Please input your contact data
                            </div>
                            <div class="col-md-6">
                                <input type="text" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3">
                                Please tell us your order Id<br/>
                                <span class="help-block">(check your email)</span>
                            </div>
                            <div class="col-md-6">
                                <input type="number" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-6">
                                <button class="btn btn-primary">Submit</button>
                                <button class="btn btn-warning">Cancel</button>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </section>
    </jsp:body>
</template:Client>