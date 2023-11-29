<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import= "com.model.Admin" %>
<%@ page import="com.model.DormManager" %>
<%@ page import="com.model.Student" %>
<%
    if(request.getAttribute("user")==null){
        String userName=null;
        String password=null;
        String userType=null;
        String remember=null;

        Cookie[] cookies=request.getCookies();
        for(int i=0;cookies!=null && i<cookies.length;i++){
            if(cookies[i].getName().equals("dormuser")){
                userName=cookies[i].getValue().split("-")[0];
                password=cookies[i].getValue().split("-")[1];
                userType=cookies[i].getValue().split("-")[2];
                remember=cookies[i].getValue().split("-")[3];
            }
        }

        if(userName==null){
            userName="";
        }

        if(password==null){
            password="";
        }

        if(userType==null){
            userType="";
        } else if("admin".equals(userType)){
            pageContext.setAttribute("user", new Admin(userName,password));
            pageContext.setAttribute("userType", 1);
        } else if("dormManager".equals(userType)) {
            pageContext.setAttribute("user", new DormManager(userName,password));
            pageContext.setAttribute("userType", 2);
        } else if("student".equals(userType)) {
            pageContext.setAttribute("user", new Student(userName,password));
            pageContext.setAttribute("userType", 3);
        }

        if("yes".equals(remember)) {
            pageContext.setAttribute("remember", 1);
        }

    }
%>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生宿舍管理系统登录</title>
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
    <script type="text/javascript">
        /*函数功能：表单提交错误时摇晃动画*/
        function shakeform(){
            $(".form-signin").removeClass('shake_effect');
            setTimeout(function()
            {
                $(".form-signin").addClass('shake_effect')
            },1);
        }
        function checkForm() {
            var userName = document.getElementById("userName").value;
            var password = document.getElementById("password").value;
            var userTypes = document.getElementsByName("userType");
            var userType = null;
            for(var i=0;i<userTypes.length;i++) {
                if(userTypes[i].checked) {
                    userType=userTypes[i].value;
                    break;
                }
            }
            if (userName == null || userName == "") {
                document.getElementById("error").innerHTML = "用户名不能为空";
                shakeform();
                return false;
            }
            if (password == null || password == "") {
                document.getElementById("error").innerHTML = "密码不能为空";
                shakeform();
                return false;
            }
            if (userType == null || userType == "") {
                document.getElementById("error").innerHTML = "请选择用户类型";
                shakeform();
                return false;
            }
            return true;
        }
        if ("用户名或密码错误！"=="${error}"){
            shakeform();
        }
    </script>

    <style type="text/css">
        body {
            padding-top: 200px;
            padding-bottom: 40px;
            background-image: url('resources/images/tp.jpg');
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        .radio {
            padding-top: 10px;
            padding-bottom:10px;
        }

        .form-signin-heading{
            text-align: center;
        }

        .form-signin {
            max-width: 300px;
            padding: 19px 29px 0px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            box-shadow: 0 1px 2px rgba(0,0,0,.05);
        }
        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }
        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }
        .btn{
            margin-bottom: 10px;
        }

        .shake_effect{
            -webkit-animation-name: shake;
            animation-name: shake;
            -webkit-animation-duration: 1s;
            animation-duration: 1s;
        }
        @-webkit-keyframes shake {
            from, to {
                -webkit-transform: translate3d(0, 0, 0);
                transform: translate3d(0, 0, 0);
            }

            10%, 30%, 50%, 70%, 90% {
                -webkit-transform: translate3d(-10px, 0, 0);
                transform: translate3d(-10px, 0, 0);
            }

            20%, 40%, 60%, 80% {
                -webkit-transform: translate3d(10px, 0, 0);
                transform: translate3d(10px, 0, 0);
            }
        }
        /*窗口抖动样式*/
        @keyframes shake {
            from, to {
                -webkit-transform: translate3d(0, 0, 0);
                transform: translate3d(0, 0, 0);
            }

            10%, 30%, 50%, 70%, 90% {
                -webkit-transform: translate3d(-10px, 0, 0);
                transform: translate3d(-10px, 0, 0);
            }

            20%, 40%, 60%, 80% {
                -webkit-transform: translate3d(10px, 0, 0);
                transform: translate3d(10px, 0, 0);
            }

        }
    </style>

</head>
<body>
<div class="container">
    <form name="myForm" class="form-signin" action="loginCheck" method="post" onsubmit="return checkForm()">
        <h2 class="form-signin-heading" style="color:gray;">宿舍管理系统</h2>
        <%--选择不同的角色进行登录--%>
        <c:choose>
            <c:when test="${user!=''&&user!=null}">
                <input id="userName" name="userName" type="text" value="${user.userName}" class="input-block-level" placeholder="用户名...">
                <input id="password" name="password" type="password" value = "${user.password}" class="input-block-level" placeholder="密码..." >
            </c:when>
            <c:otherwise>
                <input id="userName" name="userName" type="text" class="input-block-level" placeholder="用户名...">
                <input id="password" name="password" type="password" class="input-block-level" placeholder="密码..." >
            </c:otherwise>
        </c:choose>
        <label class="radio inline">
            <c:choose>
                <c:when test="${currentUserType==''||currentUserType=='admin'||currentUserType==null}">
                    <input id="admin" type="radio" name="userType" value="admin"  checked/> 系统管理员
                </c:when>
                <c:otherwise>
                    <input id="admin" type="radio" name="userType" value="admin"/> 系统管理员
                </c:otherwise>
            </c:choose>
        </label>
        <label class="radio inline">
            <c:choose>
                <c:when test="${currentUserType=='dormManager'}">
                    <input id="dormManager" type="radio" value="dormManager" name="userType" checked/> 宿舍管理员
                </c:when>
                <c:otherwise>
                    <input id="dormManager" type="radio" value="dormManager" name="userType"/> 宿舍管理员
                </c:otherwise>
            </c:choose>
        </label>
        <label class="radio inline">
            <c:choose>
                <c:when test="${currentUserType=='student'}">
                    <input id="student" type="radio" value="student" name="userType" checked/> 学生
                </c:when>
                <c:otherwise>
                    <input id="student" type="radio" value="student" name="userType"/> 学生
                </c:otherwise>
            </c:choose>
        </label>
        <%--记住选项设置--%>
        <label class="checkbox">
            <input id="remember" name="remember" type="checkbox" value="remember-me"/>记住我 &nbsp;&nbsp;&nbsp;&nbsp; <span id="error" style="color:red;">${error}</span>
        </label>
        <button class="btn btn-large btn-primary" type="submit">登&emsp;录</button>
        &nbsp;&nbsp;&nbsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <button class="btn btn-large btn-primary" type="reset" >重&emsp;置</button>
    </form>
</div>
<script>
    <%--进行角色切换--%>
    $(document).ready(function(){
        let userType = $("input[name='userType']:checked").val();
        let currentUserType = "${currentUserType}";
        if (currentUserType!=null&&currentUserType!=""&&currentUserType!=undefined){
            userType = currentUserType;
        }
        if (userType=="admin"){
            $("#userName").attr("placeholder","用户名，如：admin");
            $("#password").attr("placeholder","密码，如：111");
        }else if (userType=="dormManager"){
            $("#userName").attr("placeholder","用户名，如：manager1");
            $("#password").attr("placeholder","密码，如：123");
        }else if (userType=="student"){
            $("#userName").attr("placeholder","用户名，如：001");
            $("#password").attr("placeholder","密码，如：123");
        }

        $("input[name='userType']").change(function (){
            let userType = $("input[name='userType']:checked").val();
            let currentUserType = "${currentUserType}";
            if (userType=="admin"){
                $("#userName").attr("placeholder","用户名，如：admin");
                $("#password").attr("placeholder","密码，如：111");
            }else if (userType=="dormManager"){
                $("#userName").attr("placeholder","用户名，如：manager1");
                $("#password").attr("placeholder","密码，如：123");
            }else if (userType=="student"){
                $("#userName").attr("placeholder","用户名，如：001");
                $("#password").attr("placeholder","密码，如：123");
            }
        })
    });
</script>
</body>
</html>