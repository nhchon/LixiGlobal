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
        <div class="row">
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${LOWEST_CANDY.imageUrl}" alt="..." height="230" width="215">
                    <div class="caption">
                        <h3>${LOWEST_CANDY.name}</h3>
                        <p>...</p>
                        <h4>VND <fmt:formatNumber value="${LOWEST_CANDY.price}" pattern="###,###.##"/></h4>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${HIGHEST_CANDY.imageUrl}" alt="..." height="230" width="215">
                    <div class="caption">
                        <h3>${HIGHEST_CANDY.name}</h3>
                        <p>...</p>
                        <h4>VND <fmt:formatNumber value="${HIGHEST_CANDY.price}" pattern="###,###.##"/></h4>
                    </div>
                </div>
            </div>
        </div>

        <!-- /main -->
    </jsp:body>
</template:Admin>
