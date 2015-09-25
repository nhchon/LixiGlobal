<div class="row">
    <div class="col-md-12">
        <c:forEach items="${PRODUCTS}" var="p" varStatus="theCount">
            <c:if test="${theCount.index%3 eq 0}">
                <div class="row">
                </c:if>
                <%-- Show product --%>
                <div class="col-lg-4 col-md-4" style="text-align:center;">
                    <div><img width="144" height="144" alt="" src="${p.imageUrl}" /></div>
                    <br />
                    <a class="name">${p.name}</a>
                    <br />
                    <a class="price"><fmt:formatNumber value="${p.price}" pattern="###,###.##"/> VND</a>
                    <br />
                    <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                    <a class="price"><fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> USD</a>
                    <br/>
                    <label>
                        <input type="checkbox" name="gift" value="${p.id}" <c:if test="${p.selected eq true}">checked</c:if>>
                            <span class="lixi-radio"><span></span></span>
                        </label>
                        <input type="hidden" name="price-${p.id}" value="${p.price}"/>
                    <input type="hidden" name="name-${p.id}" value="${p.name}"/>
                    <input type="hidden" name="image-${p.id}" value="${p.imageUrl}"/>
                    <div style="text-align: center;">
                        <select class="form-control lixi-select" name="quantity-${p.id}" id="quantity-${p.id}">
                            <c:forEach var="i" begin="1" end="5">
                                <option value="${i}"  <c:if test="${(p.selected eq true) && (p.quantity == i)}">selected</c:if>>${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>        
                <%-- // End of Show product --%>
                <c:if test="${theCount.count%3 eq 0 or theCount.last}">
                </div>
                <div class="row">
                    <div class="col-md-12">&nbsp;</div>
                </div>
            </c:if>        
        </c:forEach>
    </div>
</div>
<%-- Paging --%>
<div class="row">
    <div class="col-md-12" style="text-align: right;">
        <ul class="pagination">
            <c:forEach begin="1" end="${PAGES.totalPages}" var="i">
                <c:choose>
                    <c:when test="${(i - 1) == PAGES.number}">
                        <li class="paginate_button active" aria-controls="datatable-column-interactive" tabindex="0">
                            <a href="javascript:void(0)">${i}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="paginate_button" aria-controls="datatable-column-interactive" tabindex="0">
                            <a href="javascript:loadPage(${SELECTED_LIXI_CATEGORY_ID}, ${i - 1})">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
</div>
<%-- current payment --%>
<div class="row">
    <div class="col-lg-6">
        <div class="row">
            <div class="col-lg-8">Your maximum payment amount:</div>
            <div class="col-lg-4" style="padding-left: 0px;text-align: right;">
                <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount * LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> VND</strong>
                <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount}" pattern="###,###.##"/> ${USER_MAXIMUM_PAYMENT.code}</strong>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div  style="padding-left: 0px;text-align: right;">
            Current payment: <strong><span id="currentPaymentVND"><fmt:formatNumber value="${CURRENT_PAYMENT}" pattern="###,###.##"/></span> VND</strong><br/>
            <strong><span id="currentPaymentUSD"><fmt:formatNumber value="${CURRENT_PAYMENT_USD}" pattern="###,###.##"/></span> USD</strong>
        </div>
    </div>
</div>