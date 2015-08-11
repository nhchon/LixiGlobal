<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/value-of-gift.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="value-of-gift">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <form id="SignInForm" class="form-horizontal">
                            <fieldset>
                                <legend><spring:message code="gift.choose_value"/></legend>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="value" class="control-label">
                                            <spring:message code="gift.what_is_the_amount"/>
                                            <br />
                                            <span style="font-weight: normal"><spring:message code="gift.maximum"/></span>
                                        </label>
                                    </div>
                                    <div class="col-lg-7 col-md-7 row">
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <select class="form-control">
                                                <c:forEach items="${CURRENCIES}" var="c">
                                                    <option value="${c.id}">${c.code}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" id="value" placeholder="55" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="rate-from" class="control-label"><spring:message code="gift.conversion_rate"/></label>
                                    </div>
                                    <div class="col-lg-7 col-md-7 row">
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" id="rate-from" placeholder="1 USD" />
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                            <img alt="" src="<c:url value="/resource/theme/assets/lixiglobal/img/currency.exchange.jpg"/>" />
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" id="rate-to" placeholder="20.330 VND" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="value" class="control-label"><spring:message code="gift.gift_in"/></label>
                                    </div>
                                    <div class="col-lg-7 col-md-7 row">
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <select class="form-control">
                                                <c:forEach items="${CURRENCIES}" var="c">
                                                    <option value="${c.id}">${c.code}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                            <img alt="" src="<c:url value="/resource/theme/assets/lixiglobal/img/currency.exchange.jpg"/>" />
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" id="value" placeholder="1.118.150" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <button class="btn btn-primary"><spring:message code="message.back"/></button>
                                        <button class="btn btn-primary"><spring:message code="message.next"/></button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>