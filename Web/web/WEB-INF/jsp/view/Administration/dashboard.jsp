<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            function abc() {};
        </script>
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
                        <li><a href="#">Pages</a></li>
                        <li class="active">Blank Page</li>
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
                    <h2>Blank Page</h2>
                    <em>an example of blank page</em>
                </div>

                <div class="main-content">
                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>