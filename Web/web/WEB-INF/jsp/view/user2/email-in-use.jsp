<template:Client htmlTitle="Lixi Global - Email address already in use">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var postInvisibleForm = function (url, fields) {
                var form = $('<form id="mapForm" method="post"></form>')
                        .attr({action: url, style: 'display: none;'});
                for (var key in fields) {
                    if (fields.hasOwnProperty(key))
                        form.append($('<input type="hidden">').attr({
                            name: key, value: fields[key]
                        }));
                }
                form.append($('<input type="hidden">').attr({
                    name: '${_csrf.parameterName}', value: '${_csrf.token}'
                }));
                $('body').append(form);
                form.submit();
            };
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="alert alert-warning" role="alert">
                                <strong>Email address already in use</strong><br/>
                                You indicated your are a new customer, but an account already exists with 
                                the e-mail <b>${inUseEmail}</b>
                            </div>
                            <h4>A you a returning customer?</h4>
                            <a href="<c:url value="/user/signIn"/>">Sign In</a><br/>
                            <a href="<c:url value="/user/passwordAssistance2"/>">Forgot your password?</a>

                            <h4>New to Lixi.Global?</h4>
                            <div>Create a new account with <a href="<c:url value="/user/signUp"/>">a different e-mail address</a></div>
                            <div>Create a new account with <a href="javascript:postInvisibleForm('<c:url value="/user/verifyThisEmail"/>', {inUseEmail:'${inUseEmail}'});">this e-mail address</a></div>

                            <h4>Still need help?</h4>
                            <a href="<c:url value="/support/post?method=Email"/>">Contact Customer Service</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>