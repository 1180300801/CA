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
            width: 400px;
            height: 280px;
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

        #register {
            font-size: 14px;
            font-family: 宋体;

            width: 300px;
            height: 28px;
            line-height: 28px;
            text-align: center;

            color: white;
            background-color: #3BD9FF;
            border-radius: 6px;
            border: 0;

        }

        #login_control {
            padding: 0 28px;
        }

        #copyright{
            /*position: fixed; bottom: 0; left: 400px;*/
            position: absolute;
            left: 40%;
            bottom: 0;
            margin-left: -200px;
            margin-top: -200px;
        }

    </style>
</head>

<body>
<span style="text-align: right; font-family: 楷体; font-weight: bold; font-size: 20px; margin-top:
20px; margin-right: 20px; color: #3BD9FF"><%=request.getSession().getAttribute("username")%>，欢迎您</span>
<div class="loginForm" id="login_frame">

    <div><h2>欢迎注册CA证书</h2></div>

    <form method="post" action="ApplyServlet">
        <p>
            <label class="label_input">组织</label>
            <label for="organization"></label>
            <input type="text" id="organization" name="organization" class="text_field" placeholder="" />
        </p>
        <p>
            <label class="label_input">时限</label>
            <label for="valid_time"></label>
            <select type="text" id="valid_time" name="valid_time" class="text_field">
                <option value="1">一年</option>
                <option value="2">两年</option>
                <option value="3">三年</option>
            </select>
        </p>
        <p>
            <label class="label_input">公钥</label>
            <label for="public_key"></label>
            <input type="text" id="public_key" name="public_key" class="text_field" placeholder="" />
        </p>

        <div id="login_control">
            <input type="submit" id="register" value="注册" />
        </div>
    </form>
</div>

<p id="copyright">
    Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
</p>

</body>

</html>

