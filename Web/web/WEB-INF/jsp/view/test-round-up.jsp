<c:set var="price" value="800000"/>
<c:set var="exchangeRate" value="20500"/>

<c:forEach begin="1" end="20" var="i">
    ${i} *  <fmt:formatNumber value="${price / exchangeRate}" pattern="###,###.##"/> <===>
    <fmt:formatNumber var="itemInUSD" value="${price / exchangeRate}" pattern="###,###.##"/>
    <fmt:formatNumber value="${i * itemInUSD}" pattern="###,###.##"/><br/>
</c:forEach>