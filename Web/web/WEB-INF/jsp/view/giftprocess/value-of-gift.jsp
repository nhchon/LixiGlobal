<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/value-of-gift.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/plugins/jquery.number.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var INT_MESSAGE = '<spring:message code="validate.int_required"/>';
            var NUM_MESSAGE = '<spring:message code="typeMismatch.java.lang.Integer"/>';
            var AMOUNT_RANGE_USD = '<spring:message code="validate.amount_range_usd"/>';
            var AMOUNT_RANGE_VND = '<spring:message code="validate.amount_range_vnd"/>';
            var MIN_USD = 10;
            var MAX_USD = 100;
            var MIN_VND = 200000;
            var MAX_VND = 2000000;
            var STEP_VND = 50000;
            var RECIPIENT_NAME = "${SELECTED_RECIPIENT_NAME}";
            /* */
            $(document).ready(function () {
                
                // plugin number format
                $('#amount').number( true, 2);
                $('#giftInValue').number( true, 2 );
                $('#exchangeRate').number( true, 2 );
                
                // default VND
                $('#giftInCurrency').val('VND');
                $('#giftInCurrencyValue').val('VND');
                // set default value
                $('#amountCurrency').val('USD') ;
                $('#amount').val(50);
                $('#giftInValue').val($('#amount').val()*$('#exchangeRate').val());
                
                // enterkey on amount input
                $('#amount').bind('keypress',function (event){
                    if (event.keyCode === 13){
                        
                        setGiftInValue();
                        // focus on btnSubmit cause blur on amount input
                        event.preventDefault();
                        $('#btnSubmit').focus();
                    }
                });
                // amount in foreign currency
                $('#amountCurrency').change(function(){
                   
                    if($(this).val() !== 'VND'){
                        
                        $('#giftInCurrency').val('VND');
                        $('#giftInCurrencyValue').val('VND');
                        // default value for USD
                        $('#amount').val(50);
                    }
                    else{
                        
                        $('#giftInCurrency').val('USD');
                        $('#giftInCurrencyValue').val('USD');
                        // default value for VND
                        $('#amount').val(1000000);
                    }
                    //
                    setGiftInValue();
                });
                //
                $('#amount').blur(function(){
                    //
                    checkAmountNumber();
                    // convert to USD or VND
                    setGiftInValue();
                });
                // submit validation
                $('#btnSubmit').click(function(){
                   
                    if(checkAmountNumber()){
                        if(confirm("Are your sure the amount you want to give " + RECIPIENT_NAME + " is " + amountFormat() + " ?")){
                            return true;
                        }
                        else{
                            return false;
                        }
                    }
                    else{
                        return false;
                    }
                });
            });
            
            /**
             * 
             * @returns {undefined}
             */
            function checkAmountNumber(){
                
                if($('#amountCurrency').val() === 'USD'){
                    
                    // allow decimal number in USD
                    if($.isNumeric($('#amount').val()) === false){
                        
                        alert(NUM_MESSAGE);
                        $('#amount').focus();
                        return false;
                    }
                    else{
                        
                        // check range
                        if($('#amount').val() < MIN_USD || $('#amount').val() > MAX_USD){
                            
                            alert(AMOUNT_RANGE_USD);
                            $('#amount').focus();
                            return false;
                        }
                        else{
                            
                            return true;
                        }
                        
                    }
                }
                else{
                    
                    // VND
                    if($('#amountCurrency').val() === 'VND'){
                        
                        // not allow decimal number in VND
                        if($('#amount').isInteger() === false){
                        
                            if($('#amount').val() === ''){
                                
                                $('#giftInValue').val('0');
                                
                            }
                            else{

                                alert(INT_MESSAGE);
                                //
                                $('#amount').focus();
                            }
                            return false;
                        }
                        else{
                            
                            // check range
                            if($('#amount').val() < MIN_VND || $('#amount').val() > MAX_VND || ($('#amount').val()%STEP_VND) > 0){
                                
                                alert(AMOUNT_RANGE_VND);
                                $('#amount').focus();
                                return false;
                            }
                        }
                    }                        
                }
                //
                return true;
            }
            /**
             * 
             * @returns {undefined}
             */
            function setGiftInValue(){
                
                if($('#amountCurrency').val() === 'USD'){
                    
                    $('#giftInValue').val($('#amount').val()*$('#exchangeRate').val());
                    
                }
                else{
                    
                    if($('#amountCurrency').val() === 'VND'){
                        
                        $('#giftInValue').val($('#amount').val()/$('#exchangeRate').val());
                        
                    }
                }
            }
            
            /**
             * 
             * @returns {String}
             */
            function amountFormat(){
                if($('#amountCurrency').val() === 'USD'){
                    
                    return '$' +$('#amount').val();
                    
                }
                else{
                    
                    if($('#amountCurrency').val() === 'VND'){
                        
                        return $('#amount').val()+'đ';
                        
                    }
                }
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="value-of-gift">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/gifts/value">
                            <fieldset>
                                <legend><spring:message code="gift.choose_value"/></legend>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="value" class="control-label">
                                            <spring:message code="gift.what_is_the_amount"/>
                                            <br />
                                            <span style="font-weight: normal"><spring:message code="gift.maximum"/></span>
                                        </label>
                                    </div>
                                    <div class="col-lg-7 col-md-7 row">
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <select class="form-control" name="amountCurrency" id="amountCurrency">
                                                <c:forEach items="${CURRENCIES}" var="c">
                                                    <option value="${c.code}">${c.code}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" id="amount" name="amount"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="rate-from" class="control-label"><spring:message code="gift.conversion_rate"/></label>
                                    </div>
                                    <div class="col-lg-7 col-md-7 row">
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" id="rate-from" value="1 ${LIXI_EXCHANGE_RATE.currency.code}" readonly=""/>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                            <img alt="" src="<c:url value="/resource/theme/assets/lixiglobal/img/currency.exchange.jpg"/>" />
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" name="exchangeRate" id="exchangeRate" value="${LIXI_EXCHANGE_RATE.buy}" readonly=""/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="value" class="control-label"><spring:message code="gift.gift_in"/></label>
                                    </div>
                                    <div class="col-lg-7 col-md-7 row">
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <select class="form-control"  name="giftInCurrency" id="giftInCurrency" disabled="">
                                                <c:forEach items="${CURRENCIES}" var="c">
                                                    <option value="${c.code}">${c.code}</option>
                                                </c:forEach>
                                            </select>
                                            <input type="hidden" name="giftInCurrencyValue" id="giftInCurrencyValue"/>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                                            <img alt="" src="<c:url value="/resource/theme/assets/lixiglobal/img/currency.exchange.jpg"/>" />
                                        </div>
                                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                            <input type="text" class="form-control" id="giftInValue" name="giftInValue" readonly="" value="0"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a  href="<c:url value="/gifts/chooseRecipient/${SELECTED_RECIPIENT_ID}"/>" class="btn btn-primary"><spring:message code="message.back"/></a>
                                        <button type="submit" id="btnSubmit" class="btn btn-primary"><spring:message code="message.next"/></button>
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