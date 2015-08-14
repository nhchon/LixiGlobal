<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/type-of-gift.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="type-of-gift">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <form class="form-horizontal">
                            <fieldset>
                                <legend>Choose Type of Gift</legend>
                                <div class="form-group">
                                    <ul id="types" class="list-unstyled">
                                        <li>
                                            <div class="radio">
                                                <img src="<c:url value="/resource/theme/assets/lixiglobal/img/mobile.minutes.jpg"/>" />
                                                <label>
                                                    <span class="txt">Top up mobile minutes</span>
                                                    <br />
                                                    <input class="lixi-radio" type="radio" name="type-of-gift" checked>
                                                    <span class="lixi-radio"><span></span></span>
                                                </label>
                                            </div>
                                        </li>
                                        <c:forEach items="${LIXI_CATEGORIES}" var="lxc">
                                        <li>
                                            <div class="radio">
                                                <img  width="125" height="161"  src="<c:url value="/showImages/"/>${lxc.icon}" />
                                                <label>
                                                    <span class="txt">${lxc.name}</span>
                                                    <br />
                                                    <input class="lixi-radio" type="radio" name="type-of-gift">
                                                    <span class="lixi-radio"><span></span></span>
                                                </label>
                                            </div>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a href="<c:url value="/gifts/value"/>" class="btn btn-primary"><spring:message code="message.back"/></a>
                                        <button type="submit" id="btnSubmit" class="btn btn-primary"><spring:message code="message.next"/></button>
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