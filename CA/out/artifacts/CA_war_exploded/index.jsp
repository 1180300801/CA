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
    /*  !*min-width: 1000px;*!*/
    /*  background:   #f9f9f9 ;*/
    /*  overflow-x: hidden;*/
    /*}*/

    body {
      background: url(./images/背景1.jpg)  no-repeat fixed center;
      background-size: cover;
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
    }

    .loginForm {
      width: 400px;
      height: 300px;
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

      width: 65px;
      height: 28px;
      line-height: 28px;
      text-align: center;

      color: white;
      background-color: #3CD8FF;
      border-top-left-radius: 5px;
      border-bottom-left-radius: 5px;
    }

    .text_field {
      width: 278px;
      height: 28px;
      border-top-right-radius: 5px;
      border-bottom-right-radius: 5px;
      border: 0;
    }

    #login {
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

      float: left;
    }


    #forget_pwd {
      font-size: 12px;
      color: white;
      text-decoration: none;
      position: relative;
      float: right;
      top: 5px;

    }

    #forget_pwd:hover {
      color: blue;
      text-decoration: underline;
    }

    #login_control {
      padding: 0 28px;
    }

    #copyright{
      position: fixed; bottom: 0; left: 400px;
    }

  </style>
</head>

<body>
<div class="loginForm" id="login_frame">

  <div><h1>欢迎登陆CA系统</h1></div>
  <a id="register" href="register.jsp">没有账号？注册一个！</a>

  <form method="post" action="LoginServlet">
    <p>
      <label class="label_input">用户名</label>
      <label for="username"></label>
      <input type="text" id="username" name="username" class="text_field" placeholder="请输入账户名" />
    </p>
    <p>
      <label class="label_input">密码</label>
      <label for="password"></label>
      <input type="password" id="password" name="password" class="text_field" placeholder="请输入密码" />
    </p>
    <p>
    <img src="CheckNumServlet" onclick="changeValiImage(this)" class="label_input" /><!-- 验证码图片 -->
    <input type="text" placeholder="输入验证码" name="ValiImage" class="text_field" autocomplete="off" /><!-- 输入验证码文本 -->
    </p>

    <div id="login_control">
      <input type="submit" id="login" value="登录" />
      <a id="forget_pwd" href="#">忘记密码？</a>
    </div>
  </form>
</div>

<p id="copyright">
  Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
</p>

</body>

<!-- 验证码图片点击切换 -->
<!-- 通过Date来改变每次访问的url不同 -->
<script type="text/javascript">
  function changeValiImage(img){
    img.src = "CheckNumServlet?time="+ new Date().getTime();
  }
</script>

</html>

