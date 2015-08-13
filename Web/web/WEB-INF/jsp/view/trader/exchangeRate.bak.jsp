<%--@elvariable id="validationErrors" type="java.util.Set<javax.validation.ConstraintViolation>"--%>
<%--@elvariable id="VCB" type="vn.chonsoft.lixi.model.pojo.BankExchangeRate"--%>
<%--@elvariable id="CURRENCIES" type="java.util.List<CurrencyType>"--%>
<%--@elvariable id="EXCHANGE_RATES" type="java.util.List<ExchangeRate>"--%><!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Arsha Bootstrap Template</title>

        <!-- Bootstrap -->
        <link href="<c:url value="/resource/theme/assets/arsha/css/bootstrap.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/resource/theme/assets/arsha/css/responsive-slider.css"/>" rel="stylesheet">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/arsha/css/animate.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/arsha/css/font-awesome.min.css"/>">
        <link href="<c:url value="/resource/theme/assets/arsha/css/style.css"/>" rel="stylesheet">	
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/arsha/css/magnific-popup.css"/>"> 
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style type="text/css">
            .errors {
                color:#CC0000;
            }
        </style>
        <script type="text/javascript">
            var BUY = [];
            var SELL = [];
        </script>
    </head>
    <body>
        <header>
            <div class="container">
                <div class="row">
                    <nav class="navbar navbar-default" role="navigation">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <div class="navbar-brand">
                                    <a href="<c:url value="/"/>"><h1>Lixi Global</h1></a>
                                </div>
                            </div>
                            <div class="menu">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li role="presentation"><a href="<c:url value="/"/>">Home</a></li>
                                    <li role="presentation"><a href="javascript:alert('blog.html');">blog</a></li>
                                    <li role="presentation"><a href="javascript:alert('portfolio.html');">Portfolio</a></li>
                                    <li role="presentation"><a href="javascript:alert('contacts.html');">Contact</a></li>						
                                        <c:if test="${not empty USER_LOGIN_EMAIL}">
                                        <li role="presentation"><a href="javascript:void(0)">Hello ${USER_LOGIN_EMAIL}</a></li>
                                        <li role="presentation"><a href="<c:url value="/user/signOut"/>">Sign Out</a></li>
                                        </c:if>
                                        <c:if test="${empty USER_LOGIN_EMAIL}">
                                        <li role="presentation"><a href="<c:url value="/user/signUp"/>">Sign Up</a></li>						
                                        <li role="presentation"><a href="<c:url value="/user/signIn"/>">Sign In</a></li>						
                                        </c:if>
                                    <li role="presentation"><a href="<c:url value="/trader/create"/>">Trader Create</a></li>    
                                    <li role="presentation" class="active"><a href="<c:url value="/trader/login"/>">Trader LogIn</a></li>    
                                    <li role="presentation"><a href="<c:url value="/Administration/"/>">Admin Login</a></li>    
                                </ul>
                            </div>
                        </div>			
                    </nav>
                </div>
            </div>
        </header>

        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h4><spring:message code="message.vcb_official"/> at ${VCB.time}</h4>
                    <a href="http://www.vietcombank.com.vn/ExchangeRates/" target="_blank">http://www.vietcombank.com.vn/ExchangeRates/</a>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th><spring:message code="message.currency"/></th>
                                <th><spring:message code="message.buy"/></th>
                                <th><spring:message code="message.sell"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${VCB.exrates}" var="ex">
                                <c:if test="${ex.code == 'USD'}">
                                <script type="text/javascript">
                                    BUY['${ex.code}'] = '${ex.buy}';
                                    SELL['${ex.code}'] = '${ex.sell}';
                                </script>
                                <tr>
                                    <th scope="row">${ex.code}</th>
                                    <td>${ex.buy}</td>
                                    <td>${ex.sell}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <h4>Your Exchange Rate</h4>
            <div class="row">
                <c:if test="${validationErrors != null}"><div class="errors">
                        <ul>
                            <c:forEach items="${validationErrors}" var="error">
                                <li><c:out value="${error.message}" /></li>
                                </c:forEach>
                        </ul>
                    </div></c:if>
                <form:form method="post" role="form" modelAttribute="traderExchangeRateForm">
                    <div class="col-lg-2">
                        <label for="dateInput"><spring:message code="message.date"/></label>
                        <input name="dateInput" id="dateInput" type="text" class="form-control" readonly=""/>
                    </div>
                    <div class="col-lg-2">
                        <label for="timeInput"><spring:message code="message.time"/></label>
                        <input name="timeInput" id="timeInput" class="form-control" readonly=""/>
                    </div>
                    <div class="col-lg-2">
                        <label for="currency"><spring:message code="message.currency"/></label>
                        <select name="currency" id="currency" class="form-control">
                            <c:forEach items="${CURRENCIES}" var="cur">
                                <c:if test="${cur.code != 'VND'}">
                                    <option value="${cur.id}">${cur.code}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <label for="buy"><spring:message code="message.buy"/></label>
                        <form:input path="buy" class="form-control"/>
                        <span class="help-block with-errors errors"><form:errors path="buy" /></span>
                    </div>
                    <div class="col-lg-2">
                        <label for="sell"><spring:message code="message.sell"/></label>
                        <form:input path="sell" class="form-control"/>
                        <span class="help-block with-errors errors"><form:errors path="sell" /></span>
                    </div>
                    <div class="col-lg-2">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-default form-control" style="margin-top: 0px;">Save</button>
                    </div>
                    <input type="hidden" name="vcbBuy" id="vcbBuy"/>
                    <input type="hidden" name="vcbSell" id="vcbSell"/>
                </form:form>
            </div>

            <h4>Your History</h4>
            <div class="row">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><spring:message code="message.date"/></th>
                            <th><spring:message code="message.time"/></th>
                            <th><spring:message code="message.currency"/></th>
                            <th><spring:message code="message.buy"/></th>
                            <th>%</th>
                            <th><spring:message code="message.sell"/></th>
                            <th>%</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${EXCHANGE_RATES}" var="exr" varStatus="status">
                            <tr <c:if test="${status.count==1}">class="warning"</c:if>>
                                <th scope="row"><fmt:formatDate value="${exr.dateInput}" pattern="dd/MM/yyyy"/></th>
                                <td><fmt:formatDate value="${exr.timeInput}" pattern="HH:mm:ss"/></td>
                                <td>${exr.currencyId.code}</td>
                                <td>${exr.buy}</td>
                                <td>${exr.buyPercentage}</td>
                                <td>${exr.sell}</td>
                                <td>${exr.sellPercentage}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <hr>
            </div>
        </div>

        <footer>
            <div id="sub-footer">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="copyright">
                                <p>
                                    <span>&copy; Arsha 2014 All right reserved. By </span><a href="http://bootstraptaste.com" target="_blank">Bootstraptaste</a>
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <ul class="social-network">
                                <li><a href="#" data-placement="top" title="Facebook"><i class="fa fa-facebook fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Twitter"><i class="fa fa-twitter fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Linkedin"><i class="fa fa-linkedin fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Pinterest"><i class="fa fa-pinterest fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Google plus"><i class="fa fa-google-plus fa-1x"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </footer>



        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="<c:url value="/resource/theme/assets/arsha/js/jquery.js"/>"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="<c:url value="/resource/theme/assets/arsha/js/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/arsha/js/responsive-slider.js"/>"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="<c:url value="/resource/theme/assets/arsha/js/jquery.magnific-popup.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/arsha/js/functions.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                setInterval(function () {

                    var curDate = new Date();
                    var dayStr = curDate.getDate() + "/" + (curDate.getMonth() + 1) + "/" + curDate.getFullYear();
                    var timeStr = (curDate.getHours() < 10 ? '0' + curDate.getHours() : curDate.getHours()) + ":"
                            + (curDate.getMinutes() < 10 ? '0' + curDate.getMinutes() : curDate.getMinutes()) + ":"
                            + (curDate.getSeconds() < 10 ? '0' + curDate.getSeconds() : curDate.getSeconds());
                    //
                    $('#dateInput').val(dayStr);
                    $('#timeInput').val(timeStr);
                }, 1000);

                // default
                $('#vcbBuy').val(BUY[$("#currency option:selected").text()]);
                $('#vcbSell').val(SELL[$("#currency option:selected").text()]);
                // onchange
                $('#currency').change(function () {
                    $('#vcbBuy').val(BUY[$("#currency option:selected").text()]);
                    $('#vcbSell').val(SELL[$("#currency option:selected").text()]);
                });
            });
        </script>
    </body>
</html>