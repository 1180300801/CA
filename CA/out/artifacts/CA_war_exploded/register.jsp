<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/11/27
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <!--声明文档兼容模式，表示使用IE浏览器的最新模式-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--设置视口的宽度(值为设备的理想宽度)，页面初始缩放值<理想宽度/可见宽度>-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录页面</title>
    <style>

        /*html {*/
        /*    min-width: 1000px;*/
        /*    background:   #f9f9f9 ;*/
        /*    overflow: scroll;*/
        /*    overflow-x: hidden;*/
        /*}*/

        body {
            background: url(./images/背景1.jpg)  no-repeat fixed center;
            background-size: cover;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
        }

        .loginForm {
            width: 450px;
            height: 350px;
            padding: 13px;

            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -200px;
            margin-top: -200px;

            background-color: rgba(240, 255, 255, 0.5);

            border-radius: 10px;
            text-align: center;
        }

        #register{
            color: white;
            text-decoration: none;
        }

        #register:hover {
            color: blue;
            text-decoration: underline;
        }

        form p > * {
            display: inline-block;
            vertical-align: middle;
        }

        .label_input {
            font-size: 14px;
            font-family: 宋体;

            width: 90px;
            height: 28px;
            line-height: 28px;
            text-align: center;

            color: white;
            background-color: #3CD8FF;
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
        }

        .text_field {
            width: 190px;
            height: 28px;
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
            border: 0;
        }

        #submit_form, #reset {
            font-size: 14px;
            font-family: 宋体;

            width: 120px;
            height: 28px;
            line-height: 28px;
            text-align: center;

            color: white;
            background-color: #3BD9FF;
            border-radius: 6px;
            border: 0;

        }

        #register_control {
            padding: 0 28px;
        }

        #copyright{
            position: fixed; bottom: 0; left: 400px;
        }
    </style>
</head>

<body>
<div class="loginForm" id="login_frame">

    <div><h1>欢迎注册CA系统</h1></div>
    <a id="register" href="index.jsp">已有账号？去登录！</a>

    <form method="post" action="RegisterServlet">
        <p>
            <label class="label_input">请输入账号：</label>
            <label for="username"></label>
            <input type="text" id="username" name="username" placeholder="只能用邮箱注册" onblur="validate_username(this.value)" />
            <em id="test_user"></em>
        </p>
        <p>
            <label class="label_input">请输入密码：</label>
            <label for="password"></label>
            <input type="password" id="password" name="password" placeholder="6位密码由数字和字母组成" onblur="validate_password(this.value)" />
            <em id="test_pw"></em>
        </p>
        <p>
            <label class="label_input">确认密码：</label>
            <label for="password"></label>
            <input type="password" id="password2" name="password2" onblur="validate_password2(this.value)" />
            <em id="is_test_pw"></em>
        </p>
        <p>
            <img src="CheckNumServlet" onclick="changeValiImage(this)" class="label_input" /><!-- 验证码图片 -->
            <input type="text" placeholder="输入验证码" name="ValiImage" class="text_field" /><!-- 输入验证码文本 -->
        </p>

        <div id="register_control">
            <input type="submit" id="submit_form" value="注册" onclick="return validate_form()"/>
            <input type="reset" id="reset" value="重置"/>
        </div>
    </form>
</div>

<p id="copyright">
    Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
</p>

</body>

<script type="text/javascript">

    function changeValiImage(img){
        img.src = "CheckNumServlet?time="+ new Date().getTime();
    }

    //onblur失去焦点事件，用户离开输入框时执行 JavaScript 代码：
    //验证邮箱格式
    function validate_username(username){
        //定义正则表达式的变量:邮箱正则
        var emailReg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(username !="" && username.search(emailReg) != -1)
        {
            document.getElementById("test_user").innerHTML = "<font color='green' size='3px'>✔</font>";
        }else{
            document.getElementById("test_user").innerHTML = "<font color='red' size='3px'>✘</font>";
        }
    }

    //验证密码是否符合要求：匹配6位密码，由数字和字母组成：
    function validate_password(password){
        var passwordReg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6}$/;
        if(password != "" && password.search(passwordReg) != -1)
        {
            document.getElementById("test_pw").innerHTML = "<font color='green' size='3px'>✔</font>";
        }else{
            document.getElementById("test_pw").innerHTML = "<font color='red' size='3px'>✘</font>";
        }
    }

    //验证两次输入的密码是否一样
    function validate_password2(password2){
        var password = document.getElementById("password").value;
        if (password == ""){
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>✘</font>";
        }else if(password==password2){
            document.getElementById("is_test_pw").innerHTML = "<font color='green' size='3px'>✔</font>";
        }else{
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>✘</font>";
        }
    }

    //验证表单是否已经填好
    function validate_form(){
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        var password2 = document.getElementById("password2").value;
        //console.log("表单填写正确，可以正常提交！");

        //这三个，如果任何一个有问题，都返回false
        //18128@qq.com		12345y
        var emailReg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var passwordReg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6}$/;

        if(username != "" && emailReg.test(username)){
            if(password !="" && passwordReg.test(password)){
                if(password2==password){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
</script>

</html>

