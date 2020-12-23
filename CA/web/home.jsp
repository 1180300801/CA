<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<!-- Head -->
<head>

    <title>数字证书认证中心</title>

    <!-- Meta-Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <script type="application/x-javascript">
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }

        function applyJump() {
            window.location.href = "apply.jsp";
        }

        function checkJump() {
            window.location.href = "download_cer.jsp";
        }

        function changeJump() {
            window.location.href = "revoke_cer.jsp";
        }

        function downloadCRLJump() {
            window.location.href = "download_crl.jsp";
        }
    </script>

    <!-- //Meta-Tags -->

    <!-- Style -->
<%--    <link rel="stylesheet" href="css/style.css" type="text/css" media="all">--%>
    <style>

        body {
            background: url(./images/背景1.jpg)  no-repeat fixed center;
            background-size: cover;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
        }

        .item-container {
            width: 50%;
            margin: 0 auto;
            padding: 60px;
            background-color: rgba(225, 221, 215, 0.02);
            border: 2px ridge rgba(238, 238, 238, 0.13);
            border-radius: 5px;
            /*-moz-box-shadow: 0 -5px 10px 1px rgba(16, 16, 16, 0.57);*/
            /*-webkit-box-shadow: 0 -5px 10px 1px rgba(16, 16, 16, 0.57);*/
            /*box-shadow: 0 -5px 10px 1px rgba(16, 16, 16, 0.57);*/
            border-bottom: none;
            border-bottom-left-radius: initial;
            border-bottom-right-radius: initial;
            overflow: hidden;
        }

        .item-container ul {
            overflow: hidden;
            margin-left: -10px;
        }

        .item-container ul li {
            width: 50%;
            float: left;
            padding-left: 10px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }

        .item-button {
            margin-bottom: 20px;
        }

        li{ list-style: none;}

        .item-button input[type="submit"] {
            width: 100%;
            padding: 10px 0;
            font-size: 16px;
            font-weight: 100;
            background-color: transparent;
            color: #CCC;
            cursor: pointer;
            outline: none;
            transition: 0.5s all;
            -webkit-transition: 0.5s all;
            -moz-transition: 0.5s all;
            -o-transition: 0.5s all;
            -ms-transition: 0.5s all;
            text-decoration: none;
        }

        .item-button input[type="submit"]:hover {
            background-color: #3cd8ff;
            border: 1px solid #FFF;
            color: #FFF;
            transition: 0.5s all;
            -webkit-transition: 0.5s all;
            -moz-transition: 0.5s all;
            -o-transition: 0.5s all;
            -ms-transition: 0.5s all;
            text-decoration: none;
        }
    </style>

</head>
<!-- //Head -->

<!-- Body -->
<body>
<span style="text-align: right; font-family: 楷体; font-weight: bold; font-size: 20px; margin-top:
20px; margin-right: 20px; color: #3BD9FF"><%=request.getSession().getAttribute("username")%>，欢迎您</span>
<h1>数字证书认证中心</h1>

<div class="item-container">
    <div class="item-button">
        <ul>
            <li>
                <form action="ShowServlet" method="post">
                    <input type="submit" value="我 的 证 书">
                </form>
            </li>
            <li>
                <input type="submit" value="申 请 证 书" onclick="applyJump()">
            </li>
        </ul>
    </div>
    <div class="item-button">
        <ul>
            <li>
                <input type="submit" value="查 询 证 书" onclick="checkJump()">
            </li>
            <li>
                <input type="submit" value="更 换 密 钥" onclick="changeJump()">
            </li>
        </ul>
    </div>
</div>
</body>
<!-- //Body -->

</html>
