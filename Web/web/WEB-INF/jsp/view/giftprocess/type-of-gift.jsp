<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/type-of-gift.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            $(document).ready(function () {
                
                $('#btnSubmit').click(function(){
                    
                    var value = $('input[name=type-of-gift]:checked', '#typeOfGiftForm').val();
                    
                    if(value === 'MOBILE_MINUTES'){
                        
                        alert('Sorry ! This function is in developement');
                        return false;
                    }
                    else{
                        
                        if($.trim(value) === ''){
                            
                            alert('Please choose type of gift');
                            
                            return false;
                        }
                    }
                    //
                    document.location.href = "<c:url value="/gifts/choose/"/>" + value;
                    return true;
                });
            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="type-of-gift">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <c:if test="${param.wrong eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="gift.wrong_with_type"/>
                            </div>
                        </c:if>
                        <form id="typeOfGiftForm" class="form-horizontal">
                            <fieldset>
                                <legend>Choose Type of Gift</legend>
                                <div class="form-group">
                                    <ul id="types" class="list-unstyled">
                                        <li>
                                            <div class="radio">
                                                <img src="<c:url value="/resource/theme/assets/lixiglobal/img/mobile.minutes.jpg"/>" />
                                                <label>
                                                    <span class="txt">Top up mobile minutes</span>
                                                    <br />
                                                    <input class="lixi-radio" type="radio" name="type-of-gift" checked value="MOBILE_MINUTES"/>
                                                    <span class="lixi-radio"><span></span></span>
                                                </label>
                                            </div>
                                        </li>
                                        <c:forEach items="${LIXI_CATEGORIES}" var="lxc">
                                        <li>
                                            <div class="radio">
                                                <img  width="125" height="161"  src="<c:url value="/showImages/"/>${lxc.icon}" />
                                                <label>
                                                    <span class="txt">${lxc.name}</span>
                                                    <br />
                                                    <input <c:if test="${SELECTED_LIXI_CATEGORY == lxc.id}">checked</c:if> class="lixi-radio" type="radio" name="type-of-gift" value="${lxc.id}">
                                                    <span class="lixi-radio"><span></span></span>
                                                </label>
                                            </div>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a href="<c:url value="/gifts/value"/>" class="btn btn-primary"><spring:message code="message.back"/></a>
                                        <button type="button" id="btnSubmit" class="btn btn-primary"><spring:message code="message.next"/></button>
                                    </div>
                                </div>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />        
                        </form>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>