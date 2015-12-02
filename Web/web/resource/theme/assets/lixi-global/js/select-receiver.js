$('#recId').change(function () {

    if ($(this).val() > 0) {

        document.location.href = CHOOSE_RECEIVER_PATH + $(this).val();
    }
    else {

        if ($(this).val() == 0) {
            // clear form
            clearRecipientForm();
        }
    }
});
