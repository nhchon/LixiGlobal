<div class="row">
    <div class="row-height">
        <div class="col-md-6 col-height border-right">
            <div class="login-wrapper">
                <h3 class="title">Login</h3>
                <form class="login-form" method="post">
                    <p>If you have already registered with LIXI GLOBAL, please sign in here</p>
                    <div class="form-group">
                        <input class="form-control" required="true" name="username" placeholder="User Name"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" required="true" name="password" placeholder="Password"/>
                    </div>
                    <p>
                        <a href="#">Forgotten your password?</a>
                    </p>
                    <div class="button-control">
                        <button type="submit"class="btn btn-primary">LOGIN</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-md-6 col-height">
            <div class="register-wrapper">
                <h3 class="title">Register</h3>
                <h4>CREATE AN ACCOUNT WITH LIXI GLOBAL</h4>
                <p><sup>*</sup>All form fields are mandatory</p>
                <form class="register-form" method="post">
                    <div class="form-group">
                        <input class="form-control" required="true" name="firstName" placeholder="First Name"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" required="true" name="lastName" placeholder="Last Name"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" required="true" name="email" placeholder="E-mail Address"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" required="true" id="password" name="password" placeholder="Password"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" required="true" name="rePassword" placeholder="Retype your password"/>
                    </div>
                    <div class="form-group">
                        <input class="form-control" required="true" name="mobilePhone" placeholder="Mobile Phone"/>
                    </div>
                    <div class="button-control">
                        <button type="submit" class="btn btn-primary">CREATE ACCOUNT</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        LixiGlobal.User.loginFormInit();
        LixiGlobal.User.registerFormInit();
    });
</script>
