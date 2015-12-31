<template:Client htmlTitle="Lixi Global - Email address already in use">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            var CONTEXT_PATH = '${pageContext.request.contextPath}';
            $(document).ready(function () {
                $('#captchaImg').on({
                    'click': function(){
                        $('#captchaImg').attr('src',CONTEXT_PATH + '/captcha?time='+(new Date()).getTime());
                    }
                });
            });
            
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
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="title">Verify email</h2>
                        <div>Before we continue, we need to verify your email address</div>
                        
                        <h5>Your email:</h5>
                        <div>${inUseEmail}</div>
                        <br/>
                        <div style="font-size: 16px;">Type the characters you see in this image</div>
                        <div>
                            <img style="cursor: pointer;" title="Click to Reload Image" id="captchaImg" alt="Captcha" src="<c:url value="/captcha"/>" />
                        </div>
                        
                        <div>Type character</div>
                        <div>
                            <input type="text" name="captcha" id="captcha" class="form-control"/>
                        </div>
                        <br/>
                        <div>
                            <button class="btn btn-primary" onclick="postInvisibleForm('<c:url value="/user/verify/sendEmail"/>', {captcha: $('#captcha').val()})">Continue</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>