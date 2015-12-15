$(document).ready(function () {

    $('input[name=setting]').change(function () {

        if ($(this).prop("checked")) {

            $.ajax({
                url: CALCULATE_FEE_PATH + '/' + $(this).val(),
                type: "get",
                dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                    if (data.error == '0') {
                        $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY)
                        $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL)
                    }
                    else {
                        // TODO 
                    }
                },
                error: function (jqXHR, textStatus, errorThrown)
                {
                    //alert(errorThrown);
                    //alert('Đã có lỗi, vui lòng thử lại !'); 
                }
            });

        }
    });


});

