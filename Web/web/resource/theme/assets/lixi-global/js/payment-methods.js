$(document).ready(function () {
    // unchecked accId
    $('input:radio[name="cardId"]').change(
            function () {
                if ($(this).is(':checked')) {
                    // append goes here
                    $('input:radio[name="accId"]').prop("checked", false);
                }
            }
    );
    // unchecked cardId
    $('input:radio[name="accId"]').change(
            function () {
                if ($(this).is(':checked')) {
                    // append goes here
                    $('input:radio[name="cardId"]').prop("checked", false);
                }
            }
    );
});

function checkSelectedPayment() {

    if ($.trim($('input[name=cardId]:checked', '#changePaymentForm').val()) === '' &&
            $.trim($('input[name=accId]:checked', '#changePaymentForm').val()) === '') {

        alert(SELECT_PAYMENT_METHOD);
        return false;
    }
    //
    return true;
}
