<nav>
    <ul class="pagination pull-right">
        <c:set var="numPage" value="2"/>
        <c:if test="${PAGES.totalPages < 2}">
            <c:set var="numPage" value="1"/>
        </c:if>
        <c:forEach begin="1" end="${numPage}" var="i">
            <c:choose>
                <c:when test="${(i - 1) == PAGES.number}">
                    <li class="active">
                        <a href="javascript:void(0)">${i}</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="javascript:void(0);" onclick="loadPage(${i})">${i}</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </ul>
</nav>
