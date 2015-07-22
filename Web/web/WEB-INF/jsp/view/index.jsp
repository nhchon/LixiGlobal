<template:Client htmlTitle="LiXi Global">
    
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/home.css"/>" type="text/css" />
    </jsp:attribute>
        
    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var startViewport = null;
            var resizing = false;
            var getViewport = function () {
                var viewPortWidth;
                var viewPortHeight;
                if (typeof window.innerWidth != 'undefined') {
                    viewPortWidth = window.innerWidth,
                            viewPortHeight = window.innerHeight
                }
                else if (typeof document.documentElement != 'undefined'
                        && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0) {
                    viewPortWidth = document.documentElement.clientWidth,
                            viewPortHeight = document.documentElement.clientHeight
                }
                else {
                    viewPortWidth = document.getElementsByTagName('body')[0].clientWidth,
                            viewPortHeight = document.getElementsByTagName('body')[0].clientHeight
                }
                return [viewPortWidth, viewPortHeight];
            };
            var resize = function () {
                resizing = true;
                var viewport = getViewport();
                var width = viewport[0];
                var height = viewport[1];
                var bodyHeight = $('#wrapper').outerHeight() + 95;
                if (bodyHeight < height) {
                    var val = (height - bodyHeight) / 2;
                    var imgWidth = 1280;
                    var imgHeight = 825;
                    var ratio = imgWidth / imgHeight;
                    var maxHeight = width / ratio;
                    var homeHeight = $('#home').outerHeight() + val + val;
                    $('#home').css({
                        paddingTop: val + 'px'
                    });
                    $('#star-desc').css({
                        paddingTop: (val + 15) + 'px'
                    });
                    if (homeHeight > maxHeight) {
                        $('#home').addClass('bg-height-full');
                    } else {
                        $('#home').removeClass('bg-height-full');
                    }
                } else {
                    $('#home').css({
                        paddingTop: '0px'
                    });
                    $('#star-desc').css({
                        paddingTop: '0px'
                    });
                }
                resizing = false;
            };
            $(document).ready(function () {
                startViewport = getViewport();
                resize();
                setInterval(function () {
                    if (resizing)
                        return;
                    var newViewport = getViewport();
                    if (newViewport[0] != startViewport[0] || newViewport[1] != startViewport[1]) {
                        startViewport = newViewport;
                        resize();
                    }
                }, 200)
            });
        </script>
    </jsp:attribute>
        
    <jsp:body>
            <section id="home">
                <div class="container">
                    <div class="row">
                        <div class="usp-wrapper">
                            <div class="usp">
                                <spring:message code="message.gift_easier"/>...
                                <br />
                                <spring:message code="message.in"/>&nbsp;<span class="strong"><spring:message code="message.three_steps"/></span>
                                <br />
                                <spring:message code="message.with_a_simple_fee"/>&nbsp;<span class="price">$1.00</span><span class="star">*</span>
                            </div>
                        </div>
                        <div class="desc">
                            <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 img choose-value">
                                <p><spring:message code="message.step1"/></p>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-1 col-xs-12 img arrow"></div>
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 img make-payment">
                                <p><spring:message code="message.step2"/></p>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-1 col-xs-12 img arrow"></div>
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 img send-gift">
                                <p><spring:message code="message.step3"/></p>
                            </div>
                            <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
                        </div>
                        <div class="desc-txt hidden-xs">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                <p><spring:message code="message.step1"/></p>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                <p><spring:message code="message.step2"/></p>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                <p><spring:message code="message.step3"/></p>
                            </div>
                        </div>
                        <div id="star-desc" class="col-lg-12 col-md-12 col-sm-12 col-xs-12 star-desc">
                            * <spring:message code="message.lixi_note"/>
                        </div>
                    </div>
                </div>
            </section>
    </jsp:body>
</template:Client>