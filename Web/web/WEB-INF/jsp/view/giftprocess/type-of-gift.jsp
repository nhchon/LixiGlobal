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
                                                <label>
                                                    <input class="lixi-radio" type="radio" name="type-of-gift" checked>
                                                    <span class="lixi-radio"><span></span></span>
                                                    <span class="txt">Top up mobile minutes</span>
                                                </label>
                                            </div>
                                        </li>
                                        <c:forEach items="${LIXI_CATEGORIES}" var="c">
                                            <li>
                                                <div class="radio">
                                                    <label>
                                                        <input class="lixi-radio" type="radio" name="type-of-gift">
                                                        <span class="lixi-radio"><span></span></span>
                                                        <span class="txt">${c.name}</span>
                                                    </label>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a href="value-of-gift.html" class="btn btn-primary">Back</a>
                                        <a href="choose-the-gift.html" class="btn btn-primary">Next</a>
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