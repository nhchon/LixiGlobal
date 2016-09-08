jQuery.validator.addMethod("lixiPasswordFormat", function(value, element){
    if (isValidPassword(value)) {
        return true;
    } else {
        return false;
    };
}, PASS_MESSAGE); 

jQuery.validator.addMethod("lixiSenderPhoneFormat", function(value, element){
    if (isValidPhone13(value)) {
        return true;
    } else {
        return false;
    };
}, PHONE_REQUIRED); 

LixiGlobal.RegisterPage = {
    init: function () {
        if ($('#btnShowRegister').length > 0) {
            $('#btnShowRegister').click(function () {
                $('#divRegister').toggle();

                // remove this button
                $('#btnShowRegister').remove();
            });
        }
        $('#resetPasswordBtn').click(function(){
            if($('#email4ResetPassword').isValidEmailAddress()){
                $.ajax({
                    url: PASSWORD_ASSISTANCE_PATH,
                    type: "post",
                    data: {email: $('#email4ResetPassword').val(), "_csrf":$('#csrfSpring').val()},
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        if(data.error === '0'){
                            $('#resetPasswordBody').html('<p>We just sent an email with a link to easily reset your password to '+$('#email4ResetPassword').val()+'. Please make sure to check your spam folder, too.</p>')
                            $('#headerForgotPassword').html('Check your email');
                            $('#descForgotPassword').remove();
                        }
                        else{
                            alert('Please check again your email address.')
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        alert(errorThrown);
                    }
                });
                
            }
        });
        /**/
        $("#userSignInForm").validate({
            rules: {
                password: {
                    required: true,
                    minlength: 8,
                    lixiPasswordFormat:true
                },
                email: {
                    required: true,
                    email: true
                },
                secCode: { 
                    required:{
                        depends: function(element) {
                            return $('#secCode').length !== 0;
                        }
                    },
                    minlength:4
                }
            },
            messages: {
                password: {
                    required: REQUIRE_MESSAGE,
                    minlength: PASS_MIN_LENGTH,
                    lixiPasswordFormat: PASS_CONTAIN
                },
                secCode:{
                    required: REQUIRE_MESSAGE,
                    minlength: SEC_CODE_MIN_MESSAGE
                },
                email: "Please enter a valid email address"
            }
        });
        /**/
        $("#userSignUpForm").validate({
            rules: {
                firstName: "required",
                lastName: "required",
                password: {
                    required: true,
                    minlength: 8,
                    lixiPasswordFormat:true
                },
                confPassword: {
                    required: true,
                    minlength: 8,
                    lixiPasswordFormat:true,
                    equalTo: "#passwordSignUp"
                },
                phone:{
                    required: true,
                    lixiSenderPhoneFormat:true,
                    minlength: 13
                },
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                firstName: FIRST_NAME_MESSAGE,
                lastName: LAST_NAME_MESSAGE,
                phone:PHONE_REQUIRED,
                password: {
                    required: PASS_MESSAGE,
                    minlength: PASS_MIN_LENGTH,
                    lixiPasswordFormat:PASS_CONTAIN
                },
                confPassword: {
                    required: "Please provide a password",
                    minlength: "Your password must be at least 8 characters long",
                    equalTo: "Please enter the same password as above"
                },
                email: "Please enter a valid email address"
            }
        });
    }
};
