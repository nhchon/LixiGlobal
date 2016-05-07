<template:Client htmlTitle="Lixi Global - Search Result">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <c:import url="/categories"/>
        <section class="section-gift bg-default main-section">
            <div class="container">
                <div class="section-gift-top">
                    <h2 class="title"><spring:message code="search-result-title"/></h2>
                <div class="row">
                    <div class="col-md-12">
                        <p>&nbsp;</p>
                        <h4><spring:message code="curr-no-result"/></h4>
                        <p>&nbsp;</p>
                    </div>
                </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>