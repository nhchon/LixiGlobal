<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                tinymce.init({
                    selector: '#description',
                    height: 300,
                    menubar: false,
                    statusbar: false,
                    theme: 'modern',
                    plugins: [
                        'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                        'searchreplace wordcount visualblocks visualchars code fullscreen',
                        'insertdatetime media nonbreaking save table contextmenu directionality',
                        'emoticons template paste textcolor colorpicker textpattern imagetools'
                    ],
                    toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | forecolor backcolor emoticons',
                    image_advtab: true
                });
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
                <c:if test="${validationErrors != null}">
                    <div class="msg msg-error">
                        <ul>
                            <c:forEach items="${validationErrors}" var="error">
                                <li><c:out value="${error.message}" /></li>
                                </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${param.success eq '1'}">
                    <div class="alert alert-success" role="alert">Insert success!</div>
                </c:if>
                <form:form modelAttribute="inputProductForm">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Product Name:</label>
                                <form:input path="name" class="form-control"/>
                                <div class="has-error"><form:errors path="name" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Category Name:</label>
                                <form:select path="category" class="form-control">
                                    <c:forEach items="${categories}" var="c">
                                        <option value="${c.id}">${c.english}</option>
                                    </c:forEach>
                                </form:select>
                                <div class="has-error"><form:errors path="category" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Price:</label>
                                <form:input path="price" class="form-control"/>
                                <span class="help-block">(Minimum 10$ ~ 200000 VND)</span>
                                <div class="has-error"><form:errors path="price" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Image Url:</label>
                                <form:input path="imageUrl" class="form-control"/>
                                <div class="has-error"><form:errors path="imageUrl" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Description:</label>
                                <form:textarea path="description"></form:textarea>
                                <div class="has-error"><form:errors path="description" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Product Source:</label>
                                <form:input path="productSource" class="form-control" placeholder="Ex, http://www.lazada.vn/nuoc-hoa-nu-tom-ford-black-orchid-eau-de-parfum-100ml-1753161.html"/>
                                <div class="has-error"><form:errors path="productSource" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8" style="text-align: center;">
                            <button class="btn btn-primary" style="width: 200px;">Save</button>
                            <button class="btn btn-warning" type="button">Cancel</button>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                </form:form>

            </div>
        </div>

        <!-- /main -->
    </jsp:body>
</template:Admin>
