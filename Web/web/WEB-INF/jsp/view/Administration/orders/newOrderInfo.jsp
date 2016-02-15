<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            
            jQuery(document).ready(function () {
                $('#btnSubmit').click(function () {

                    if ($('#oStatus').val() === '') {

                        alert("Please select the order's status");
                        $('#oStatus').focus();

                        //return false;
                    }
                    else{
                        getContent($('#oStatus').val());
                    }
                });
                
                /* */
                <c:if test="${not empty oStatus}">getContent(${oStatus});</c:if>
            });
            
            function sent(id){
                
                overlayOn($('#rowO'+id));
                $("#orderSubmitForm input[name=id]").val(id);
                
                $.ajax(
                {
                    url: '<c:url value="/Administration/Orders/submit2BK/"/>' + id,
                    type: "GET",
                    dataType: 'html',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        $('#status'+id).html(data);
                        
                        if(data.indexOf('Passed') > -1){
                            /* remove sent action */
                            $('#tdAction'+id).html('');
                        }
                        /* */
                        overlayOff();
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        //if fails  
                        overlayOff();
                    }
                });
            }
            
            function cancel(id){
                
                if(confirm('Are you sure want to CANCEL this order id '+ id + ' ???')){
                    
                    document.location.href = '<c:url value="/Administration/Orders/cancel/"/>' + id + '/info';
                }
            }
            
            function viewRecipient(id) {
                $.get('<c:url value="/Administration/SystemRecipient/view/"/>' + id, function (data) {
                    $('#editRecipientContent').html(data);
                    $('#editRecipientModal').modal({show: true});

                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })
                });
            }

            function viewSender(id) {
                $.get('<c:url value="/Administration/SystemSender/view/"/>' + id, function (data) {
                    $('#editRecipientContent').html(data);
                    $('#editRecipientModal').modal({show: true});

                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })
                });
            }
            
            function getContent(oStatus){
                $.get('<c:url value="/Administration/Orders/newOrders/ajax/"/>' + oStatus, function (data) {
                    $('#divContent').html(data);
                });
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%-- EnumLixiOrderStatus.java --%>
        <c:set var="UNFINISHED" value="-9"/>
        <c:set var="NOT_YET_SUBMITTED" value="-8"/>
        <c:set var="SENT_INFO" value="-7"/>
        <c:set var="SENT_MONEY" value="-6"/>
        <c:set var="PROCESSING" value="0"/>
        <c:set var="COMPLETED" value="1"/>
        <c:set var="CANCELED" value="2"/>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/newOrders/-1"/>">New Orders</a></li>
        </ul>
        <h2 class="sub-header">New Orders</h2>
        <div class="row">
            <div class="col-md-12">
                <form role="form" id="reportForm" action="<c:url value="/Administration/Orders/newOrders"/>" method="post">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="email">New Order's Status:</label>
                                <select class="form-control" id="oStatus" name="oStatus">
                                    <option value="">Please select status</option>
                                    <option value="${NOT_YET_SUBMITTED}" <c:if test="${oStatus eq NOT_YET_SUBMITTED}">selected=""</c:if>>Failed Sent</option>
                                    <option value="${SENT_INFO}" <c:if test="${oStatus eq SENT_INFO}">selected=""</c:if>>Success Sent</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <button type="button" id="btnSubmit" class="btn btn-primary">Run Report</button>
                </form>                
            </div>
        </div>
        <div id="divContent"></div>
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
