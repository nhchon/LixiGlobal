function showPageBillAdd(page){
    $.get( GET_BLS_PATH +'='+page, function( data ) {
        $('#billingAddressListContent').html(data);
        $('#billingAddressListModal').modal({show:true});
    });
}

function useThisAddress(id){
    $('#billingAddressListModal').modal("hide");

    getBillAdd(id);
}

function getBillAdd(id){
    $.getJSON( GET_BL_PATH+id, function( data ) {
        $('#blId').val(data.id);
        $('#firstName').val(data.firstName);
        $('#lastName').val(data.lastName);
        $('#address').val(data.address);
        $('#city').val(data.city);
        $('#state').val(data.state);
        $('#zipCode').val(data.zipCode);
        $('#country').val(data.country);
    });
}
