<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/jquery.dataTables.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.colVis.bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.colReorder.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.tableTools.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/dataTables.bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/king-table.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <!-- top general alert -->
        <div class="alert alert-danger top-general-alert">
            <span>If you <strong>can't see the logo</strong> on the top left, please reset the style on right style switcher (for upgraded theme only).</span>
            <button type="button" class="close">&times;</button>
        </div>
        <!-- end top general alert -->

        <!-- content-wrapper -->
        <div class="col-md-10 content-wrapper">
            <div class="row">
                <div class="col-lg-4 ">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i><a href="#">Home</a></li>
                        <li><a href="#">Tables</a></li>
                        <li class="active">Dynamic Table</li>
                    </ul>
                </div>
                <div class="col-lg-8 ">
                    <div class="top-content">
                        <ul class="list-inline quick-access">
                            <li>
                                <a href="charts-statistics-interactive.html">
                                    <div class="quick-access-item bg-color-green">
                                        <i class="fa fa-bar-chart-o"></i>
                                        <h5>CHARTS</h5><em>basic, interactive, real-time</em>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="page-inbox.html">
                                    <div class="quick-access-item bg-color-blue">
                                        <i class="fa fa-envelope"></i>
                                        <h5>INBOX</h5><em>inbox with gmail style</em>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="tables-dynamic-table.html">
                                    <div class="quick-access-item bg-color-orange">
                                        <i class="fa fa-table"></i>
                                        <h5>DYNAMIC TABLE</h5><em>tons of features and interactivity</em>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- main -->
            <div class="content">
                <div class="main-header">
                    <h2>Dog Friendly Attractions</h2>
                    <em>tables with lot of features and interactivity</em>
                </div>
                <div class="main-content">
                    <!-- SHOW HIDE COLUMNS DATA TABLE -->
                    <div class="widget widget-table">
                        <div class="widget-header">
                            <h3><i class="fa fa-table"></i> Drap/Drop and Show/Hide Column</h3> <em> - <a href="http://datatables.net/" target="_blank">jQuery Data Table</a> enable to show/hide and drap-drop column</em>
                        </div>
                        <div class="widget-content">
                            <table id="datatable-column-interactive" class="table table-sorting table-hover table-bordered datatable">
                                <thead>
                                    <tr>
                                        <th>#ID</th>
                                        <th>City Name</th>
                                        <th>Photo</th>
                                        <th>Park Name</th>
                                        <th>Address</th>
                                        <th>Description</th>
                                        <th>Created Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${dogParks.content}" var="park">
                                        <tr>
                                            <td><c:out value="${park.id}" /></td>
                                            <td><c:out value="${park.cityId.cityName}" /></td>
                                            <td><img width="158" height="108" src="<c:out value="${park.photoUrl}" />" alt="Photo"/></td>
                                            <td><c:out value="${park.parkName}" /></td>
                                            <td><c:out value="${park.address1}" /><br/><c:out value="${park.address2}" /><br/>
                                                <c:out value="${park.address3}" />
                                            </td>
                                            <td><c:out value="${park.description}" /></td>
                                            <td><c:out value="${park.createdDate}" /></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="dataTables_paginate paging_simple_numbers" id="datatable-column-interactive_paginate">
                                        <ul class="pagination">
                                            <c:forEach begin="1" end="${dogParks.totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${(i - 1) == dogParks.number}">
                                                        <li class="paginate_button active" aria-controls="datatable-column-interactive" tabindex="0">
                                                            <a href="javascript:void(0)">${i}</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button" aria-controls="datatable-column-interactive" tabindex="0">
                                                            <a href="<c:url value="/Administration/Fido/parks">
                                                                   <c:param name="paging.page" value="${i}" />
                                                                   <c:param name="paging.size" value="50" />
                                                               </c:url>">${i}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <!-- END SHOW HIDE COLUMNS DATA TABLE -->

                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
