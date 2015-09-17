/* 
 * For Recipient Form.
 * 
 */

function checkSubmitRecipientFormOnModal(){
    if(checkRecipientFormOnModal() === true){
        $("#chooseRecipientForm").submit();
    }
}

function enableEditRecipientHtmlContent(data){
    
    $('#editRecipientContent').html(data);
    $('#editRecipientModal').modal({show:true});
    
    // focus on phone field
    $('#editRecipientModal').on('shown.bs.modal', function () {
        $('#phone').focus()
    })
    // change dial code
    $('#iso2Code').change(function(){
       if($(this).val() === 'VN'){

           $('#dialCode').val('+84');

       }
       else if($(this).val() === 'US'){
           $('#dialCode').val('+1');
       }
    });
    // handler submit form
    //callback handler for form submit
    $("#chooseRecipientForm").submit(function(e)
    {
        var postData = $(this).serializeArray();
        var formURL = $(this).attr("action");
        $.ajax(
        {
            url : formURL,
            type: "POST",
            data : postData,
            contentType: "application/x-www-form-urlencoded;charset=ISO-8859-1",
            dataType: 'json',
            success:function(data, textStatus, jqXHR) 
            {
                //data: return data from server
                if(data.success === '1'){
                    // save successfully
                    // hide popup
                    $('#editRecipientModal').modal('hide');
                    // get new phone number
                    $('#recPhone').val($("#chooseRecipientForm #phone").val());
                }
                else{
                    alert(SOMETHING_WRONG_ERROR);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) 
            {
                //if fails      
            }
        });
        if(typeof e  !== 'undefined'){
            e.preventDefault(); //STOP default action
            //e.unbind(); //unbind. to stop multiple form submit.
        }
    });
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
    if($.trim($('#phone').val()) === ''){
        
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

