/* 
 * For Recipient Form.
 * 
 */
function deleteRecipient(){
    if(confirm(CONFIRM_DELETE_MESSAGE)){
    $.ajax(
    {
        url: CONTEXT_PATH + '/recipient/deactivated/'+$('#recId').val(),
        type: 'GET',
        dataType: 'json',
        success: function (data, textStatus, jqXHR)
        {
            //data: return data from server
            if (data.error === '0') {
                $("#recId option[value='"+data.recId+"']").remove();
            }
            else {
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

function checkSubmitRecipientFormOnModal(){
    if(checkRecipientFormOnModal() === true){
        $("#chooseRecipientForm").submit();
    }
}

function checkRecipientFormOnModal(){

    // first name
    if($('#firstName').val() === ''){
        alert(FIRST_NAME_ERROR);
        $('#firstName').focus();
        //
        return false;
    }
    // last
    if($('#lastName').val() === ''){
        alert(LAST_NAME_ERROR);
        $('#lastName').focus();
        //
        return false;
    }
    // email
    if($('#email').val() === ''){
        alert(EMAIL_ERROR);
        $('#email').focus();
        //
        return false;
    }
    
    if($('#email').isValidEmailAddress() == false){
        alert(EMAIL_ERROR);
        $('#email').focus();
        //
        return false;
    }
    
    if($('#email').val() !== $('#confEmail').val()){
        alert(CONF_EMAIL_ERROR);
        $('#confEmail').focus();
        //
        return false;
    }
    
    // phone
    if($.trim($('#phone').val()) === '' || $('#phone').val().match('^0')){
        
        alert(PHONE_ERROR);
        $('#phone').focus();
        //
        return false;
    }
    // note
    if($.trim($('#note').val()) === ''){
        
        alert(NOTE_ERROR);
        $('#note').focus();
        //
        return false;
    }
    //
    return true;
}

