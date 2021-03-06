<section class="section-gift main-section">
    <div class="container border-top">
        <div class="gift-selection">
            <div class="gift-selection-icon text-center">
                <div class="row">
                    <div class="col-md-2 col-sm-3 col-xs-3 col-for-seven">
                        <div class="gift-icon">
                            <a href="#">
                                <span class="gift-icon-category gift-icon-1"></span>
                                <h5>Mobile Top up</h5>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3 col-xs-3 col-for-seven">
                        <div class="gift-icon">
                            <a <c:if test="${SELECTED_LIXI_CATEGORY_ID eq LIXI_CATEGORIES.candies.id}">class="active"</c:if> href="<c:url value="/gifts/chooseCategory/${LIXI_CATEGORIES.candies.id}"/>">
                                <span class="gift-icon-category gift-icon-2"></span>
                                <h5><spring:message code="mess.candies"/></h5>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3 col-xs-3 col-for-seven">
                        <div class="gift-icon">
                            <a <c:if test="${SELECTED_LIXI_CATEGORY_ID eq LIXI_CATEGORIES.jewelries.id}">class="active"</c:if> href="<c:url value="/gifts/chooseCategory/${LIXI_CATEGORIES.jewelries.id}"/>">
                                <span class="gift-icon-category gift-icon-3"></span>
                                <h5><spring:message code="mess.jewelries"/></h5>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3 col-xs-3 col-for-seven">
                        <div class="gift-icon">
                            <a <c:if test="${SELECTED_LIXI_CATEGORY_ID eq LIXI_CATEGORIES.perfume.id}">class="active"</c:if> href="<c:url value="/gifts/chooseCategory/${LIXI_CATEGORIES.perfume.id}"/>">
                                <span class="gift-icon-category gift-icon-4"></span>
                                <h5><spring:message code="mess.perfume"/></h5>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3 col-xs-3 col-for-seven">
                        <div class="gift-icon">
                            <a <c:if test="${SELECTED_LIXI_CATEGORY_ID eq LIXI_CATEGORIES.cosmetics.id}">class="active"</c:if> href="<c:url value="/gifts/chooseCategory/${LIXI_CATEGORIES.cosmetics.id}"/>">
                                <span class="gift-icon-category gift-icon-5"></span>
                                <h5><spring:message code="mess.cosmetic"/></h5>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3 col-xs-3 col-for-seven">
                        <div class="gift-icon">
                            <a <c:if test="${SELECTED_LIXI_CATEGORY_ID eq LIXI_CATEGORIES.childrentoy.id}">class="active"</c:if> href="<c:url value="/gifts/chooseCategory/${LIXI_CATEGORIES.childrentoy.id}"/>">
                                <span class="gift-icon-category gift-icon-6"></span>
                                <h5><spring:message code="mess.children-toy"/></h5>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3 col-xs-3 col-for-seven">
                        <div class="gift-icon">
                            <a <c:if test="${SELECTED_LIXI_CATEGORY_ID eq LIXI_CATEGORIES.flowers.id}">class="active"</c:if> href="<c:url value="/gifts/chooseCategory/${LIXI_CATEGORIES.flowers.id}"/>">
                                <span class="gift-icon-category gift-icon-7"></span>
                                <h5><spring:message code="mess.flowers"/></h5>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
