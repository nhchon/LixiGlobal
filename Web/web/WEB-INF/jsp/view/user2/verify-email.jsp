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
                        <h2 class="title"><spring:message code="mess.verify-email"/></h2>
                        <div><spring:message code="mess.before-we-continue"/></div>
                        
                        <h5><spring:message code="mess.your-email"/>:</h5>
                        <div>${inUseEmail}</div>
                        <br/>
                        <div style="font-size: 16px;"><spring:message code="mess.type-the-char"/></div>
                        <div>
                            <img style="cursor: pointer;" title="Click to Reload Image" id="captchaImg" alt="Captcha" src="<c:url value="/captcha"/>" />
                        </div>
                        
                            <div><spring:message code="mess.type-character"/></div>
                        <div>
                            <input type="text" name="captcha" id="captcha" class="form-control"/>
                        </div>
                        <br/>
                        <div>
                            <button class="btn btn-primary" onclick="postInvisibleForm('<c:url value="/user/verify/sendEmail"/>', {captcha: $('#captcha').val()})"><spring:message code="mess.continue"/></button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>