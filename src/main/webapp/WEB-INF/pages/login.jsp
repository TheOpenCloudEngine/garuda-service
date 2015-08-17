<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String redirect = request.getParameter("redirect");
    if(redirect == null){
        redirect = "";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Garuda Service Portal</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="/resources/favicon.ico">
    <link rel="stylesheet" media="screen" href="/resources/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" media="screen" href="/resources/css/login.css" />
    <script src="/resources/jquery/jquery-1.11.3.min.js"></script>
    <script src="/resources/js/jquery.validate.min.js"></script>
    <meta content='width=device-width' name='viewport'>
    <script>
        $(document).ready(function() {
            $("#login-form").validate({
                onkeyup: function(element) {
                    var element_id = $(element).attr('id');
                    if (this.settings.rules[element_id] && this.settings.rules[element_id].onkeyup != false) {
                        $.validator.defaults.onkeyup.apply(this, arguments);
                    }
                },
                rules: {
                    orgId: {
                        orgExists: true,
                        onkeyup: false
                    }
                }
            });
            $.validator.addMethod("orgExists", function(value, element) {
                var ret = true;
                $.ajax({
                    url : "/api/organization/" + value,
                    async: false,
                    type : "GET",
                    success : function(response) {
                        ret = true;
                    },
                    error : function() {
                        ret = false;
                    }
                });
                return ret;
            }, "This organization does not exist.");
        });
    </script>
</head>
<body class='login'>
    <img class="logo" src="/resources/css/oce.png" alt="Garuda logo" />
    <form class="vertical-form" id="login-form" action="/login" accept-charset="UTF-8" method="post">
        <legend>Log In</legend>
        <input type="hidden" name="redirect" value="<%=redirect %>" />
        <input placeholder="Organization ID" type="text" class="required" name="orgId" id="orgId" value="fastcat"/>
        <input placeholder="Email Address" type="text" class="required email" name="userId" id="userId" />
        <input placeholder="Password" autocomplete="off" type="password" class="required" minlength="4" name="password" id="password" />
        <input type="submit" class="btn btn-success" name="commit" value="Log In" />
        <%--<p><a href="/forgot_password/new">Forgot password?</a></p>--%>
    </form>
    <div class='footer'>
        <p>
            Don't have an account?
            <a href="/signUp">Create Account</a>
        </p>
    </div>

</body>
</html>
