<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/pay-by-bank-account.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="pay-by-bank-account">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <form id="SignInForm" class="form-horizontal">
                            <fieldset>
                                <legend>Add Bank Account</legend>
                                <img alt="guide" src="<c:url value="/resource/theme/assets/lixiglobal/img/us.bank.guide.jpg"/>" />
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="account" class="control-label">Name on account</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <input type="text" class="form-control" id="account" placeholder="Type to enter text" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="bank-number" class="control-label">Bank rounting number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <input type="text" class="form-control" id="bank-number" placeholder="9 digits" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="checking-number" class="control-label">Checking account number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <input type="text" class="form-control" id="checking-number" placeholder="17 digits" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="checking-number-confirm" class="control-label">Re-enter checking account number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <input type="text" class="form-control" id="checking-number-confirm" placeholder="Type to enter text" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="driver-license" class="control-label">Driver's license number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <input type="text" class="form-control" id="driver-license" placeholder="Type to enter text" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="state" class="control-label">State</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <input type="text" class="form-control" id="state" placeholder="Type to enter text" />
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a href="review-cart.html" class="btn btn-primary">Back</a>
                                        <a href="<c:url value="/checkout/place-order"/>" class="btn btn-primary">Continue</a>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>