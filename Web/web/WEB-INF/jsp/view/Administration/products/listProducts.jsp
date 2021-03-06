<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            $(document).ready(function () {
                $('#category').change(function(){
                    document.location.href = '<c:url value="/Administration/Products/redirect2List/"/>' + $(this).val();
                });
            });
            
            function doActive(id, active){
                var selectedCat = $('#category').val();
                postInvisibleForm('<c:url value="/Administration/Products/activate"/>', {id:id, catId:selectedCat, active:active});
                return false;
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Products/list/0"/>">List Product</a></li>
        </ul>

        <!-- main -->
        <div class="row">
            <div class="col-md-8">
                <h2 class="sub-header">List Products</h2>
            </div>
            <div class="col-md-4">
                <select id="category" name="category" class="form-control">
                    <option value="0">All Products</option>
                    <c:forEach items="${categories}" var="c">
                    <option value="${c.vatgiaId.id}" <c:if test="${c.vatgiaId.id eq catId}">selected=""</c:if>>${c.vietnam} - ${c.english}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <!-- Content -->
                <table class="table table-hover table-responsive table-striped">
                    <thead>
                        <tr>
                            <th>#ID</th>
                            <th></th>
                            <th>Name</th>
                            <th nowrap>Original Price</th>
                            <th nowrap>Sell Price</th>
                            <th>Active</th>
                            <th style="text-align: right;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pRs.content}" var="p">
                            <tr <c:if test="${p.alive eq 0}">class="warning"</c:if>>
                            <td>${p.id}</td>
                            <td><img src="${p.imageUrl}" class="img-rounded" alt="..." width="50" height="50"></td>
                            <td>
                                <a style="font-weight: bold;color: black;" href="<c:url value="/gifts/detail/${p.id}"/>" target="_blank">${p.name}</a><br/>
                                Source: <a href="${p.linkDetail}" target="_blank">${p.linkDetail}</a>
                                
                            </td>
                            <td><fmt:formatNumber value="${p.originalPrice}" pattern="###,###.##"/></td>
                            <td><fmt:formatNumber value="${p.price}" pattern="###,###.##"/></td>
                            <td>
                                ${p.alive}
                            </td>
                            <td nowrap>
                                <a href="<c:url value="/Administration/Products/input/${p.id}"/>">Edit</a>&nbsp;&nbsp;
                                <c:if test="${p.alive eq 1}">
                                    <a href="javascript:void(0);" onclick="doActive(${p.id}, 0)">Deactivate</a>
                                </c:if>
                                <c:if test="${p.alive eq 0}">
                                    <a href="javascript:void(0);" onclick="doActive(${p.id}, 1)">Activate</a>
                                </c:if>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="7">
                                <%-- Paging --%>
                                <nav>
                                    <ul class="pagination pull-right">
                                        <c:forEach begin="1" end="${pRs.totalPages}" var="i">
                                            <c:choose>
                                                <c:when test="${(i - 1) == pRs.number}">
                                                    <li class="active">
                                                        <a href="javascript:void(0)">${i}</a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li>
                                                        <a href="<c:url value="/Administration/Products/list/${catId}">
                                                           <c:param name="paging.page" value="${i}" />
                                                           <c:param name="paging.sort" value="alive,DESC" />
                                                           <c:param name="paging.sort" value="id,DESC" />
                                                           <c:param name="paging.size" value="50" />
                                                       </c:url>">${i}</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </ul>
                                </nav>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- /main -->
    </jsp:body>
</template:Admin>
