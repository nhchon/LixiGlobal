<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Product Statistic">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemStatistic/product"/>">Product Statistic</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Product Statistic</h2>
        <table class="table table-hover table-responsive table-striped">
            <thead>
                <th class="success">Candies</th>
                <th><b>${SIZE_CANDY} alive products</b></th>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr>
                    <td>Lowest</td>
                    <td>${LOWEST_CANDY.name}</td>
                    <td>VND <fmt:formatNumber value="${LOWEST_CANDY.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${LOWEST_CANDY.id}"/>" target="_blank"><c:url value="/gifts/detail/${LOWEST_CANDY.id}"/></a></td>
                </tr>
                <tr>
                    <td>Highest</td>
                    <td>${HIGHEST_CANDY.name}</td>
                    <td>VND <fmt:formatNumber value="${HIGHEST_CANDY.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${HIGHEST_CANDY.id}"/>" target="_blank"><c:url value="/gifts/detail/${HIGHEST_CANDY.id}"/></a></td>
                </tr>
                <tr>
                    <td>Avg</td>
                    <td>VND <fmt:formatNumber value="${AVG_CANDY}" pattern="###,###.##"/></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
                    
        <table class="table table-hover table-responsive table-striped">
            <thead>
                <th class="success">JEWELRIES</th>
                <th><b>${SIZE_JEW} alive products</b></th>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr>
                    <td>Lowest</td>
                    <td>${LOWEST_JEW.name}</td>
                    <td>VND <fmt:formatNumber value="${LOWEST_JEW.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${LOWEST_JEW.id}"/>" target="_blank"><c:url value="/gifts/detail/${LOWEST_JEW.id}"/></a></td>
                </tr>
                <tr>
                    <td>Highest</td>
                    <td>${HIGHEST_JEW.name}</td>
                    <td>VND <fmt:formatNumber value="${HIGHEST_JEW.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${HIGHEST_JEW.id}"/>" target="_blank"><c:url value="/gifts/detail/${HIGHEST_JEW.id}"/></a></td>
                </tr>
                <tr>
                    <td>Avg</td>
                    <td>VND <fmt:formatNumber value="${AVG_JEW}" pattern="###,###.##"/></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table class="table table-hover table-responsive table-striped">
            <thead>
                <th class="success">PERFUME</th>
                <th><b>${SIZE_PER} alive products</b></th>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr>
                    <td>Lowest</td>
                    <td>${LOWEST_PER.name}</td>
                    <td>VND <fmt:formatNumber value="${LOWEST_PER.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${LOWEST_PER.id}"/>" target="_blank"><c:url value="/gifts/detail/${LOWEST_PER.id}"/></a></td>
                </tr>
                <tr>
                    <td>Highest</td>
                    <td>${HIGHEST_PER.name}</td>
                    <td>VND <fmt:formatNumber value="${HIGHEST_PER.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${HIGHEST_PER.id}"/>" target="_blank"><c:url value="/gifts/detail/${HIGHEST_PER.id}"/></a></td>
                </tr>
                <tr>
                    <td>Avg</td>
                    <td>VND <fmt:formatNumber value="${AVG_PER}" pattern="###,###.##"/></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table class="table table-hover table-responsive table-striped">
            <thead>
                <th class="success">COSMETICS</th>
                <th><b>${SIZE_COS} alive products</b></th>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr>
                    <td>Lowest</td>
                    <td>${LOWEST_COS.name}</td>
                    <td>VND <fmt:formatNumber value="${LOWEST_COS.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${LOWEST_COS.id}"/>" target="_blank"><c:url value="/gifts/detail/${LOWEST_COS.id}"/></a></td>
                </tr>
                <tr>
                    <td>Highest</td>
                    <td>${HIGHEST_COS.name}</td>
                    <td>VND <fmt:formatNumber value="${HIGHEST_COS.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${HIGHEST_COS.id}"/>" target="_blank"><c:url value="/gifts/detail/${HIGHEST_COS.id}"/></a></td>
                </tr>
                <tr>
                    <td>Avg</td>
                    <td>VND <fmt:formatNumber value="${AVG_COS}" pattern="###,###.##"/></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table class="table table-hover table-responsive table-striped">
            <thead>
                <th class="success">CHILDREN TOYS</th>
                <th><b>${SIZE_TOY} alive products</b></th>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr>
                    <td>Lowest</td>
                    <td>${LOWEST_TOY.name}</td>
                    <td>VND <fmt:formatNumber value="${LOWEST_TOY.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${LOWEST_TOY.id}"/>" target="_blank"><c:url value="/gifts/detail/${LOWEST_TOY.id}"/></a></td>
                </tr>
                <tr>
                    <td>Highest</td>
                    <td>${HIGHEST_TOY.name}</td>
                    <td>VND <fmt:formatNumber value="${HIGHEST_TOY.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${HIGHEST_TOY.id}"/>" target="_blank"><c:url value="/gifts/detail/${HIGHEST_TOY.id}"/></a></td>
                </tr>
                <tr>
                    <td>Avg</td>
                    <td>VND <fmt:formatNumber value="${AVG_TOY}" pattern="###,###.##"/></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table class="table table-hover table-responsive table-striped">
            <thead>
                <th class="success">FLOWER</th>
                <th><b>${SIZE_FLO} alive products</b></th>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr>
                    <td>Lowest</td>
                    <td>${LOWEST_FLO.name}</td>
                    <td>VND <fmt:formatNumber value="${LOWEST_FLO.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${LOWEST_FLO.id}"/>" target="_blank"><c:url value="/gifts/detail/${LOWEST_FLO.id}"/></a></td>
                </tr>
                <tr>
                    <td>Highest</td>
                    <td>${HIGHEST_FLO.name}</td>
                    <td>VND <fmt:formatNumber value="${HIGHEST_FLO.price}" pattern="###,###.##"/></td>
                    <td><a href="<c:url value="/gifts/detail/${HIGHEST_FLO.id}"/>" target="_blank"><c:url value="/gifts/detail/${HIGHEST_FLO.id}"/></a></td>
                </tr>
                <tr>
                    <td>Avg</td>
                    <td>VND <fmt:formatNumber value="${AVG_FLO}" pattern="###,###.##"/></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <!-- /main -->
    </jsp:body>
</template:Admin>
