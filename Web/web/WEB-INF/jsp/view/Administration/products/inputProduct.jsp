<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                tinymce.init({ selector:'textarea' });
            });
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Input New Product</h2>
        <div class="row">
            <div class="col-md-12">
                <!-- Content -->
                <textarea>Easy! You should check out MoxieManager!</textarea>
            </div>
        </div>

        <!-- /main -->
    </jsp:body>
</template:Admin>
