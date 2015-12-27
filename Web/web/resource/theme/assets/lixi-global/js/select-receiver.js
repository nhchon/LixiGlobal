$('#recId').change(function () {

    if ($(this).val() > 0) {

        loadRecipient($(this).val());
    }
    else {

        if ($(this).val() == 0) {
            // clear form
            clearRecipientForm();
        }
    }
});

function clearRecipientForm(){
    
    $('#firstName').val('');
    $('#middleName').val('');
    $('#lastName').val('');
    $('#email').val('');
    $('#phone').val('');
    $('#note').val('');
}

function loadRecipient(recId) {

    overlayOn($("#chooseRecipientForm"));

    $.ajax({
        url: LOAD_RECEIVER_PATH + '/' + recId,
        type: "get",
        dataType: 'json',
        success: function (data, textStatus, jqXHR)
        {
            overlayOff();
            $('#firstName').val(data.firstName);
            $('#middleName').val(data.middleName);
            $('#lastName').val(data.lastName);
            $('#email').val(data.email);
            $('#phone').val(data.phone);
            $('#note').val(data.note);
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            overlayOff();
            alert(errorThrown);
        }
    });
}
