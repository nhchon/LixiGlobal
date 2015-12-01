LixiGlobal.RegisterPage = {
    init: function () {
        if ($('#btnShowRegister').length > 0) {
            $('#btnShowRegister').click(function () {
                $('#divRegister').toggle();

                // remove this button
                $('#btnShowRegister').remove();
            });
        }
        /**/
        $("#userSignInForm").validate({
            rules: {
                password: {
                    required: true,
                    minlength: 8
                },
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                password: {
                    required: PASS_MESSAGE,
                    minlength: PASS_MESSAGE
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
                    minlength: 8
                },
                confPassword: {
                    required: true,
                    minlength: 8,
                    equalTo: "#password"
                },
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                firstName: FIRST_NAME_MESSAGE,
                lastName: LAST_NAME_MESSAGE,
                password: {
                    required: PASS_MESSAGE,
                    minlength: PASS_MESSAGE
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
