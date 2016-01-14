<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Payment Method">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            jQuery(document).ready(function () {

            });
            var deleteMessage = '<spring:message code="message.want_to_delete"/>';
            
            function deleteCard(id){
                
                if(confirm(deleteMessage)){
                    location.href = '<c:url value="/user/delete/card/"/>' + id;
                }
            }
            
            function toogleDetail(id){
                if($('#panelBody'+id).is(":visible")){
                    
                    $('#iconDetail'+id).removeClass();
                    $('#iconDetail'+id).addClass("fa fa-caret-down");
                    //
                    $('#panelBody'+id).hide();
                }
                else{
                    $('#iconDetail'+id).removeClass();
                    $('#iconDetail'+id).addClass("fa fa-caret-up");
                    //
                    $('#panelBody'+id).show();
                }
            }
            
        </script>
    </jsp:attribute>
    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title">Your Payment Methods</h2>
                    <c:if test="${param.add eq 1}">
                        <div class="alert alert-success" role="alert"> <strong>Well done!</strong> You successfully add a new card. </div>
                    </c:if>
                    <c:if test="${param.error eq 1}">
                        <div class="alert alert-warning" role="alert"> <strong>Error!</strong> Something wrong with your card information. </div>
                    </c:if>
                        
                    <div class="row" style="margin-bottom: 5px;">
                        <div class="col-md-4"><c:if test="${not empty cards}"><b>Credit & Debit Cards</b></c:if></div>
                        <div class="col-md-4"><c:if test="${not empty cards}"><b>Expires</b></c:if></div>
                        <div class="col-md-4" style="text-align: right;"><a href="<c:url value="/user/addCard"/>"><i class="fa fa-plus-circle"></i> Add Credit/Debit Card</a></div>
                    </div>
                    <c:forEach items="${cards}" var="c">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-md-4">
                                        <c:set var="lengthCard" value="${fn:length(c.cardNumber)}"/>
                                        <c:choose>
                                            <c:when test="${c.cardType eq 1}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-visa.png"/>"/> Visa
                                            </c:when>
                                            <c:when test="${c.cardType eq 2}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-master.png"/>"/> Master
                                            </c:when>
                                            <c:when test="${c.cardType eq 3}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-discover.png"/>"/> Discover
                                            </c:when>
                                            <c:when test="${c.cardType eq 4}">
                                                <img width="47" height="29" src="<c:url value="/resource/theme/assets/lixi-global/images/card-amex.jpg"/>"/> Amex
                                            </c:when>
                                        </c:choose>                                                    
                                        <span> ending in ${fn:substring(c.cardNumber, lengthCard-4, lengthCard)}</span>

                                    </div>
                                    <div class="col-md-4">
                                        <c:if test="${c.expMonth < 10}">0${c.expMonth}</c:if><c:if test="${c.expMonth > 9}">${c.expMonth}</c:if>/${c.expYear}
                                    </div>
                                    <div class="col-md-4" style="text-align: right;">
                                            <a href="javascript:toogleDetail(${c.id})"><i id="iconDetail${c.id}" class="fa fa-caret-down"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body" style="display:none;" id="panelBody${c.id}">
                                <div class="row">
                                    <div class="col-md-4">
                                        <b>Name on card</b><br/>
                                        ${c.cardName}
                                    </div>
                                    <div class="col-md-4">
                                        <b>Billing address</b><br/>
                                        <b>${c.billingAddress.firstName}&nbsp;${c.billingAddress.lastName}</b><br/>
                                        ${c.billingAddress.address}<br/>
                                        ${c.billingAddress.city}, ${c.billingAddress.state}, ${c.billingAddress.zipCode}, ${c.billingAddress.country}<br/>
                                    </div>
                                    <div class="col-md-4"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4" style="text-align: right;">
                                        <button class="btn btn-default btn-sm" onclick="deleteCard(${c.id})">Delete</button>
                                        <!--<button class="btn btn-default btn-sm btn-has-link-event">Edit</button>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <p style="color:black;font-weight: bold;">* In order to change credit card information, you need to delete the old card and reenter your new card under "Add Card"</p>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>