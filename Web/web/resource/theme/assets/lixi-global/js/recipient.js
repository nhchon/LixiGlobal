/* 
 * For Recipient Form.
 * 
 */

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

