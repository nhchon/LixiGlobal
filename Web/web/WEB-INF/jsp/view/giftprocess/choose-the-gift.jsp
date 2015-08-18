<template:Client htmlTitle="LiXi Global - Choose the Gift">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/choose-the-gift.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            $(document).ready(function () {
                var checkitem = function () {
                    var $this;
                    $this = $("#carousel");
                    if ($("#carousel .carousel-inner .item:first").hasClass("active")) {
                        $this.children(".left").hide();
                        $this.children(".right").show();
                    } else if ($("#carousel .carousel-inner .item:last").hasClass("active")) {
                        $this.children(".right").hide();
                        $this.children(".left").show();
                    } else {
                        $this.children(".carousel-control").show();
                    }
                };

                checkitem();
                $("#carousel").on("slid.bs.carousel", "", checkitem);

                // validate on submit form
                $('#btnSubmit').click(function () {

                    if (typeof $('input[name=gift]:checked', '#chooseGiftForm').val() === "undefined") {

                        alert("<spring:message code="validate.please_choose_the_gift"/>");

                        return false;
                    }
                    else {

                        return true;
                    }
                });
            })

        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="choose-the-gift">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 hidden-sm col-xs-1"></div>
                    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-10">
                        <c:if test="${wrong eq 1 || param.wrong eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.please_choose_the_gift"/>
                            </div>
                        </c:if>
                        <form id="chooseGiftForm" class="form-horizontal" action="${pageContext.request.contextPath}/gifts/choose" method="post">
                            <fieldset>
                                <legend><spring:message code="gift.choose_the_gift"/></legend>
                                <p><spring:message code="gift.closest_price"/></p>
                                <div class="form-group">
                                    <div id="carousel" class="carousel slide" data-ride="carousel" data-interval="0" data-wrap="false">
                                        <div class="carousel-inner" role="listbox">
                                            <c:forEach items="${PRODUCTS.data}" var="p" varStatus="theCount">
                                                <c:if test="${theCount.index%5 eq 0}">
                                                    <div class="item<c:if test="${theCount.index eq 0}"> active</c:if>">
                                                            <div class="hidden-xs hidden-sm row">
                                                                <div class="col-lg-1 col-md-1"></div>
                                                        </c:if>

                                                        <%-- Show product --%>
                                                        <div class="col-lg-2 col-md-2 gift">
                                                            <div><img width="144" height="144" alt="" src="${p.image_url}" /></div>
                                                            <br />
                                                            <a class="name">${p.name}</a>
                                                            <br />
                                                            <a class="price">${p.price} VND</a>
                                                            <br />
                                                            <label>
                                                                <input class="lixi-radio" type="radio" name="gift" value="${p.id}" <c:if test="${LIXI_ORDER_GIFT_PRODUCT_ID == p.id}">checked</c:if>>
                                                                <span class="lixi-radio"><span></span></span>
                                                            </label>
                                                            <input type="hidden" name="price-${p.id}" value="${p.price}"/>
                                                            <input type="hidden" name="name-${p.id}" value="${p.name}"/>
                                                            <input type="hidden" name="image-${p.id}" value="${p.image_url}"/>
                                                            <div style="text-align: center;">
                                                                <select class="form-control lixi-select" name="quantity-${p.id}">
                                                                    <c:forEach var="i" begin="1" end="5">
                                                                        <option value="${i}" <c:if test="${(LIXI_ORDER_GIFT_PRODUCT_ID == p.id) && (LIXI_ORDER_GIFT_PRODUCT_QUANTITY == i)}">selected</c:if>>${i}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <%-- // End of Show product --%>
                                                        <c:if test="${theCount.count%5 eq 0 or theCount.last}">
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <!-- Controls -->
                                        <a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
                                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                        </a>
                                        <a class="right carousel-control" href="#carousel" role="button" data-slide="next">
                                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                        </a>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a href="<c:url value="/gifts/type"/>" class="btn btn-primary"><spring:message code="message.back"/></a>
                                        <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="message.next"/></button>
                                    </div>
                                </div>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                    </div>
                    <div class="col-lg-1 col-md-1 hidden-sm col-xs-1"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>