<!-- main-nav -->
<nav class="main-nav">
    <ul class="main-menu">
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-dashboard fa-fw"></i><span class="text">Dashboard</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu">
                <li><a href="<c:url value="/Administration/Dashboard"/>"><span class="text">Dashboard</span></a></li>
            </ul>
        </li>
        <li class="active">
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-dashboard fa-fw"></i><span class="text">Orders</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu open">
                <li class="active"><a href="<c:url value="/Administration/Orders/newOrders"/>"><span class="text">New Orders</span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-dashboard fa-fw"></i><span class="text">System Config</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu open">
                <li><a href="<c:url value="/Administration/SystemConfig/categories"/>"><span class="text">Categories</span></a></li>
                <li><a href="<c:url value="/Administration/SystemConfig/lixiExchangeRate"/>"><span class="text">LiXi Exchange Rate</span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-dashboard fa-fw"></i><span class="text">System Users</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu open">
                <li><a href="<c:url value="/Administration/SystemUser/list"/>"><span class="text">User List</span></a></li>
                <li><a href="<c:url value="/Administration/SystemUser/add"/>"><span class="text">Add New</span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-dashboard fa-fw"></i><span class="text">Customer Service</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu open">
                <li><a href="<c:url value="/Administration/SystemSupport/list"/>"><span class="text">Issue List</span></a></li>
            </ul>
        </li>
        <!--
        <li class="active">
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-dashboard fa-fw"></i><span class="text">BringFido</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu open">
                <li class="active"><a href="<c:url value="/Administration/Fido/cities"/>"><span class="text">Cities</span></a></li>
                <li><a href="<c:url value="/Administration/Fido/parks"/>"><span class="text">Dog Parks</span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-clipboard fa-fw"></i><span class="text">Pages</span>
                <i class="toggle-icon fa fa-angle-down"></i>
            </a>
            <ul class="sub-menu">
                <li><a href="page-profile.html"><span class="text">Profile</span></a></li>
                <li><a href="page-invoice.html"><span class="text">Invoice</span></a></li>
                <li><a href="page-knowledgebase.html"><span class="text">Knowledge Base</span></a></li>
                <li><a href="page-inbox.html"><span class="text">Inbox</span></a></li>
                <li><a href="page-new-message.html"><span class="text">New Message</span></a></li>
                <li><a href="page-view-message.html"><span class="text">View Message</span></a></li>
                <li><a href="page-search-result.html"><span class="text">Search Result</span></a></li>
                <li><a href="page-submit-ticket.html"><span class="text">Submit Ticket</span></a></li>
                <li><a href="page-file-manager.html"><span class="text">File Manager <span class="badge element-bg-color-blue">New</span></span></a></li>
                <li><a href="page-projects.html"><span class="text">Projects <span class="badge element-bg-color-blue">New</span></span></a></li>
                <li><a href="page-project-detail.html"><span class="text">Project Detail <span class="badge element-bg-color-blue">New</span></span></a></li>
                <li><a href="page-faq.html"><span class="text">FAQ <span class="badge element-bg-color-blue">New</span></span></a></li>
                <li><a href="page-register.html"><span class="text">Register</span></a></li>
                <li><a href="page-login.html"><span class="text">Login</span></a></li>
                <li><a href="page-404.html"><span class="text">404</span></a></li>
                <li><a href="page-blank.html"><span class="text">Blank Page</span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-bar-chart-o fw"></i><span class="text">Charts &amp; Statistics</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu ">
                <li><a href="charts-statistics.html"><span class="text">Charts</span></a></li>
                <li><a href="charts-statistics-interactive.html"><span class="text">Interactive Charts</span></a></li>
                <li><a href="charts-statistics-real-time.html"><span class="text">Realtime Charts</span></a></li>
                <li><a href="charts-d3charts.html"><span class="text">D3 Charts</span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-edit fw"></i><span class="text">Forms</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu ">
                <li><a href="form-inplace-editing.html"><span class="text">In-place Editing</span></a></li>
                <li><a href="form-elements.html"><span class="text">Form Elements</span></a></li>
                <li><a href="form-layouts.html"><span class="text">Form Layouts</span></a></li>
                <li><a href="form-bootstrap-elements.html"><span class="text">Bootstrap Elements</span></a></li>
                <li><a href="form-validations.html"><span class="text">Validation</span></a></li>
                <li><a href="form-file-upload.html"><span class="text">File Upload</span></a></li>
                <li><a href="form-text-editor.html"><span class="text">Text Editor</span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-list-alt fw"></i><span class="text">UI Elements</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu ">
                <li><a href="ui-elements-general.html"><span class="text">General Elements</span></a></li>
                <li><a href="ui-elements-tabs.html"><span class="text">Tabs</span></a></li>
                <li><a href="ui-elements-buttons.html"><span class="text">Buttons</span></a></li>
                <li><a href="ui-elements-icons.html"><span class="text">Icons <span class="badge element-bg-color-blue">Updated</span></span></a></li>
                <li><a href="ui-elements-flash-message.html"><span class="text">Flash Message</span></a></li>
            </ul>
        </li>
        <li>
            <a href="widgets.html"><i class="fa fa-puzzle-piece fa-fw"></i><span class="text">Widgets <span class="badge element-bg-color-blue">Updated</span></span></a>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-gears fw"></i><span class="text">Components</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu ">
                <li><a href="components-wizard.html"><span class="text">Wizard (with validation)</span></a></li>
                <li><a href="components-calendar.html"><span class="text">Calendar</span></a></li>
                <li><a href="components-maps.html"><span class="text">Maps</span></a></li>
                <li><a href="components-gallery.html"><span class="text">Gallery</span></a></li>
                <li><a href="components-tree-view.html"><span class="text">Tree View <span class="badge element-bg-color-blue">New</span></span></a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="js-sub-menu-toggle">
                <i class="fa fa-table fw"></i><span class="text">Tables</span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu ">
                <li><a href="tables-static-table.html"><span class="text">Static Table</span></a></li>
                <li><a href="tables-dynamic-table.html"><span class="text">Dynamic Table</span></a></li>
            </ul>
        </li>
        <li><a href="typography.html"><i class="fa fa-font fa-fw"></i><span class="text">Typography</span></a></li>
        <li>
            <a href="#" class="js-sub-menu-toggle"><i class="fa fa-bars"></i>
                <span class="text">Menu Lvl 1 <span class="badge element-bg-color-blue">New</span></span>
                <i class="toggle-icon fa fa-angle-left"></i>
            </a>
            <ul class="sub-menu">
                <li class="">
                    <a href="#" class="js-sub-menu-toggle">
                        <span class="text">Menu Lvl 2</span>
                        <i class="toggle-icon fa fa-angle-left"></i>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#">Menu Lvl 3</a></li>
                        <li><a href="#">Menu Lvl 3</a></li>
                        <li><a href="#">Menu Lvl 3</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <span class="text">Menu Lvl 2</span>
                    </a>
                </li>
            </ul>
        </li>
        -->
    </ul>
</nav>
<!-- /main-nav -->
<div class="sidebar-minified js-toggle-minified">
    <i class="fa fa-angle-left"></i>
</div>
