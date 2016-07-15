/* 
 * For Recipient Form.
 * 
 */
function deleteRecipient() {
    if (confirm(CONFIRM_DELETE_MESSAGE)) {
        $.ajax(
                {
                    url: CONTEXT_PATH + '/recipient/deactivated/' + $('#recId').val(),
                    type: 'GET',
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        if (data.error === '0') {
                            $("#recId option[value='" + data.recId + "']").remove();
                            $('.selectpicker').selectpicker('refresh');
                            $('button.edit-receiver').hide();
                        } else {
                            alert(SOMETHING_WRONG_ERROR);
                        }
                        $('#editRecipientModal').modal('hide');
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        //if fails      
                    }
                });
    }
}

function checkSubmitRecipientFormOnModal() {
    if (checkRecipientFormOnModal() === true) {
        $("#chooseRecipientForm").submit();
    }
}

function checkRecipientFormOnModal() {

    // first name
    if ($('#firstName').val() === '') {
        alert(FIRST_NAME_ERROR);
        $('#firstName').focus();
        //
        return false;
    }
    // last
    if ($('#lastName').val() === '') {
        alert(LAST_NAME_ERROR);
        $('#lastName').focus();
        //
        return false;
    }
    // email
    if ($('#email').val() === '') {
        alert(EMAIL_ERROR);
        $('#email').focus();
        //
        return false;
    }

    if ($('#email').isValidEmailAddress() == false) {
        alert(EMAIL_ERROR);
        $('#email').focus();
        //
        return false;
    }

    if ($('#email').val() !== $('#confEmail').val()) {
        alert(CONF_EMAIL_ERROR);
        $('#confEmail').focus();
        //
        return false;
    }

    // phone
    if ($.trim($('#phone').val()) === '' || $('#phone').val().match('^0')) {

        alert(PHONE_ERROR);
        $('#phone').focus();
        //
        return false;
    }
    // note
    if ($.trim($('#note').val()) === '') {

        alert(NOTE_ERROR);
        $('#note').focus();
        //
        return false;
    }
    //
    return true;
}

var recOnPlaceOrder = function handleRecipientHtmlOnPlaceOrder(data){
    //data: return data from server
    if (data.error === '0') {
        // save successfully
        // hide popup
        $('#editRecipientModal').modal('hide');
        // get new phone number
        var recId = $("#chooseRecipientForm #recId").val();
        var name = $("#chooseRecipientForm #firstName").val() + " " + $("#chooseRecipientForm #middleName").val() + " " + $("#chooseRecipientForm #lastName").val();
        $('#recName' + recId).html(name);
        $('#recPhone' + recId).html($("#chooseRecipientForm #phone").val());
        $('#recEmail' + recId).html($("#chooseRecipientForm #email").val());
    } else {
        alert(SOMETHING_WRONG_ERROR);
    }
}

var recOnDetailGift = function handleRecipientHtmlOnDetailGift(data){
    //data: return data from server
    if (data.error === '0') {
        // hide popup
        $('#editRecipientModal').modal('hide');
        var name = strip($("#chooseRecipientForm #firstName").val() + " " + $("#chooseRecipientForm #middleName").val() + " " + $("#chooseRecipientForm #lastName").val());
        var phone = $("#chooseRecipientForm #email").val();
        var email = $("#chooseRecipientForm #phone").val();
        var firstName = $("#chooseRecipientForm #firstName").val();
        /* new recipient */
        if (parseInt(data.recId) > 0) {
            if (data.action === 'create') {
                $('#recId')
                        .append($("<option></option>")
                                .attr("value", data.recId)
                                .attr("firstname", firstName)
                                .attr("data-icon", "glyphicon-user")
                                .text(name + " - " + phone + " - " + email));

                $('#recId').val(data.recId);
                $('button.edit-receiver').each(function(){$(this).attr('data-receiver-id', data.recId);});
                
            } else {
                // save successfully
                $("#recId option:selected").attr("firstname", $("#chooseRecipientForm #firstName").val());
                $("#recId option:selected").html(name + " - " + phone + " - " + email);
            }
            $('.selectpicker').selectpicker('refresh')
        }
    } else {
        alert(SOMETHING_WRONG_ERROR);
    }
}
function enableEditRecipientHtmlContent(data, handleFunction) {

    $('#editRecipientContent').html(data);
    $('#editRecipientModal').modal({show: true});

    $("#chooseRecipientForm #phone").mask("(999) 999-999?9");
    // handler submit form
    //callback handler for form submit
    $("#chooseRecipientForm").submit(function (e)
    {
        var postData = $(this).serializeArray();
        var formURL = $(this).attr("action");
        $.ajax(
                {
                    url: formURL,
                    type: "POST",
                    data: postData,
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        handleFunction(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        //if fails      
                    }
                });
        if (typeof e !== 'undefined') {
            e.preventDefault(); //STOP default action
            //e.unbind(); //unbind. to stop multiple form submit.
        }
    });
}


