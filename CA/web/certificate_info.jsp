<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ page import="comDao.certificate" %>

<html>
<!-- Head -->
<head>

    <title>数字证书认证中心</title>

    <!-- Meta-Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- //Meta-Tags -->

    <!-- Style -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

</head>
<!-- //Head -->

<!-- Body -->
<body>
<span style="text-align: right; font-family: 楷体; font-weight: bold; font-size: 20px; margin-top:
20px; margin-right: 20px; color: #FFFFFF"><%=request.getSession().getAttribute("username")%>，欢迎您</span>
<br>
<form action="LogoutServlet" method="post">
    <button type="submit" class="btn btn-success">退出登录</button>
</form>

<div class="container" style="width: 75%;">
    <%certificate cer= (certificate)request.getAttribute("certificate");%>
    <h3>证 书</h3>
    <table class="table table-striped">
        <tr>
            <td>证书版本</td>
            <td><%=cer.getVersion()%></td>
        </tr>
        <tr>
            <td>发行机构</td>
            <td><%=cer.getIssuer()%></td>
        </tr>
        <tr>
            <td>序列号</td>
            <td><%=cer.getSerial_Number()%></td>
        </tr>
        <tr>
            <td>签名算法</td>
            <td><%=cer.getSign_Algorithm()%></td>
        </tr>
        <tr>
            <td>摘要算法</td>
            <td><%=cer.getDigest_Algorithm()%></td>
        </tr>
        <tr>
            <td>组织机构</td>
            <td><%=cer.getOrganization()%></td>
        </tr>
        <tr>
            <td>生效日期</td>
            <td><%=cer.getStart_time()%></td>
        </tr>
        <tr>
            <td>失效日期</td>
            <td><%=cer.getEnd_time()%></td>
        </tr>
    </table>
    <form action="DownloadServlet" method="post">
        <button type="submit" class="btn btn-success">下载证书</button>
    </form>
    <a href="test.html">test</a>
</div>
</body>
<!-- //Body -->
<script>
    addEventListener("load", function () {
        setTimeout(hideURLbar, 0);
    }, false);

    function hideURLbar() {
        window.scrollTo(0, 1);
    }
    function quit() {
        window.location.href = "LogoutServlet";
    }
</script>

</html>
