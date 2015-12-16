<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemFee/list"/>">Fees</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Lixi Global Fees</h2>
        <div class="row">
            <div class="col-md-12">
                <!-- Content -->
                <div class="table-responsive">
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th nowrap>Country</th>
                                <th>Payment</th>
                                <th>Value</th>
                                <th>Gift Only</th>
                                <th>Allow Refund</th>
                                <th>Max</th>
                                <th>Lixi Handling Fee</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:url value="/Administration/SystemFee/save" var="saveFeeUrl"/>
                            <c:forEach items="${countries}" var="c" varStatus="theCount">
                                <tr>
                                    <form action="${saveFeeUrl}" method="post">
                                    <td>#</td>
                                    <td nowrap>
                                        ${c.name}
                                        <input type="hidden" name="country" value="${c.id}"/>
                                    </td>
                                    <td>
                                        <select class="form-control" name="payment">
                                            <option value="0">Credit Card</option>
                                            <c:if test="${c.name eq 'US'}">
                                            <option value="1">Checking Account</option>
                                            </c:if>
                                        </select>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-addon" id="basic-addon1">&lt;=</span>
                                            <input type="text" name="amount" class="form-control" placeholder="Amount" aria-describedby="basic-addon1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                        <input type="text" name="giftOnly" class="form-control"/>
                                        <span class="input-group-addon" id="basic-addon1">%</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                        <input type="text" name="allowRefund" class="form-control"/>
                                        <span class="input-group-addon" id="basic-addon1">%</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                        <input type="text" name="maxFee" class="form-control"/>
                                        <span class="input-group-addon" id="basic-addon1">%</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                        <span class="input-group-addon" id="basic-addon1">$</span>
                                        <input type="text" name="lixiFee" class="form-control" value="0.99"/>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-primary">Save</button></td>
                                    </form>
                                </tr>
                                <c:forEach items="${c.fees}" var="f" varStatus="theCount">
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td nowrap><c:if test="${f.paymentMethod eq 0}">Credit Card</c:if>
                                            <c:if test="${f.paymentMethod eq 1}">Checking account</c:if>
                                        </td>
                                        <td><b>&lt;=</b> $ <fmt:formatNumber value="${f.amount}" pattern="###,###.##"/></td>
                                        <td><fmt:formatNumber value="${f.giftOnlyFee}" pattern="###,###.##"/>%</td>
                                        <td><fmt:formatNumber value="${f.allowRefundFee}" pattern="###,###.##"/>%</td>
                                        <td>$ <fmt:formatNumber value="${f.maxFee}" pattern="###,###.##"/></td>
                                        <td>$ <fmt:formatNumber value="${f.lixiFee}" pattern="###,###.##"/></td>
                                        <td></td>
                                    </tr>

                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>
            </div>
        </div>

        <!-- /main -->
    </jsp:body>
</template:Admin>
