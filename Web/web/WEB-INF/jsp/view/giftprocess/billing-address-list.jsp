<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">Choose a billing address</h4>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-md-12" style="padding-left: 30px;">
            Please choose a billing address from your address book below, or <a href="">enter a new billing address</a>
        </div>
    </div>
    <div class="page-header" style="margin:20px 10px 20px">
        <h3>Your address book</h3>
    </div>
    <div class="row">
        <div class="col-md-12" style="padding-left: 30px;">
            <c:forEach items="${BILLING_ADDRESS_ES.content}" var="ba" varStatus="theCount">
                <c:if test="${theCount.index%3 eq 0}">
                    <div class="row">
                </c:if>
                    <div class="col-lg-4">
                        <b>${ba.fullName}</b>
                        <br/>
                        ${fn:substring(ba.add1, 0, 35)}...<br/>
                        <c:if test="${not empty ba.add2}">${ba.add2}<br/></c:if>
                        ${ba.city}
                        <br/>
                        ${ba.state}&nbsp;${ba.zipCode}
                        <br/>
                        Phone: ${ba.phone}
                        <br/><br/>
                        <button type="button" onclick="useThisAddress(${ba.id})" class="btn btn-primary">Use this address</button>
                    </div>
                <c:if test="${theCount.count%3 eq 0 or theCount.last}">
                        <p>&nbsp;</p>
                    </div>
                </c:if>
                        <input type="hidden" id="billingAdd-${ba.id}" value="${ba.fullName}, ${ba.add1}
                                    <c:if test="${not empty ba.add2}">&nbsp; ${ba.add2}}</c:if>
                        , ..."/>
            </c:forEach>
        </div></div>
</div>
<div class="modal-footer">
    <nav>
        <ul class="pagination">
            <c:forEach begin="1" end="${BILLING_ADDRESS_ES.totalPages}" var="i">
                <c:choose>
                    <c:when test="${(i - 1) == BILLING_ADDRESS_ES.number}">
                        <li class="paginate_button active">
                            <a href="javascript:void(0)">${i}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="paginate_button">
                            <a href="javascript:showPageBillAdd(${i})">${i}</a>                               
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </nav>    
</div>