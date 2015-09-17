/* 
 * Show and Save Billing Address Modal Form
 * 
 */
function newBillingAddress() {
    $.get(BILLING_ADDRESS_MODAL_URL, function (data) {
        $('#billingAddressListContent').html(data);
        $('#billingAddressListModal').modal({show: true});
    });
}

function saveNewBillingAddress() {

    if ($.trim($('#fullName').val()) === '') {

        $('#fullName').attr("placeholder", NOT_NULL_MESSAGE);
        $('#fullName').focus();
        return false;
    }
    // add1
    if ($.trim($('#add1').val()) === '') {

        $('#add1').attr("placeholder", NOT_NULL_MESSAGE);
        $('#add1').focus();
        return false;
    }
    // city
    if ($.trim($('#city').val()) === '') {

        $('#city').attr("placeholder", NOT_NULL_MESSAGE);
        $('#city').focus();
        return false;
    }
    // state
    if ($.trim($('#state').val()) === '') {

        $('#state').attr("placeholder", NOT_NULL_MESSAGE);
        $('#state').focus();
        return false;
    }
    // zipCode
    if ($.trim($('#zipCode').val()) === '') {

        $('#zipCode').attr("placeholder", NOT_NULL_MESSAGE);
        $('#zipCode').focus();
        return false;
    }
    // phone
    if ($.trim($('#phone').val()) === '') {

        $('#phone').attr("placeholder", NOT_NULL_MESSAGE);
        $('#phone').focus();
        return false;
    }
    //
    return true;;
}


