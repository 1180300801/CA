<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>

<!-- Head -->
<head>

    <title>哥谭市数字证书认证中心</title>

    <!-- Meta-Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- //Meta-Tags -->

    <!-- Style -->
    <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
    <script src="js/jquery-2.1.0.min.js"></script>
    <script src="js/bootstrap.js"></script>

</head>
<!-- //Head -->

<!-- Body -->
<body>
<span style="text-align: right; font-family: 楷体; font-weight: bold; font-size: 20px; margin-top:
20px; margin-right: 20px; color: #FFFFFF"><%=request.getSession().getAttribute("username")%>，欢迎您</span>
<br>
<a href="/tw/logoutServlet"
   style="text-align: right; font-family: 楷体; font-weight: normal; font-size:
   20px; margin-top:
   20px; margin-right: 20px; color: #FFFFFF">退出登录</a>
<h1>哥谭市数字证书认证中心</h1>

<div class="container" style="width: 75%;">
    <h3>证 书 列 表</h3>
    <table>
        <tr class="tr-header">
            <th>序列号</th>
            <th>组织机构</th>
            <th>工商注册号</th>
            <th>证书有效期起</th>
            <th>证书有效期止</th>
            <th>下载链接</th>
        </tr>
        <c:forEach items="${requestScope.certItems}" var="certItem" varStatus="s">
            <tr class="tr-body">
                <th>${certItem.serial_number}</th>
                <th>${certItem.organization}</th>
                <th>${certItem.registration_number}</th>
                <th>${certItem.start_time}</th>
                <th>${certItem.end_time}</th>
                <th><a
                        href="/tw/downloadCerServlet?serial_number=${certItem.serial_number}&no_check_code=123">下 载</a>
                </th>
            </tr>
        </c:forEach>
        <tr class="tr-footer">
            <td colspan="3"
                style="text-align: right; padding-right: 20px; padding-top: 5px; padding-bottom:
                5px;">当前为第
                ${page.currentPage}
                页，共
                ${page.totalPage} 页
            </td>
            <td colspan="3" style="text-align: left; padding-left: 20px; padding-top: 5px; padding-bottom:
                5px;">
                <c:choose>
                    <c:when test="${page.hasPrePage}">
                        <a href="/tw/certificateInfoServlet?currentPage=1">首页</a> |
                        <a href="/tw/certificateInfoServlet?currentPage=${page.currentPage-1}">
                            上一页</a>
                    </c:when>
                    <c:otherwise>
                        首页 | 上一页
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${page.hasNextPage}">
                        <a href="/tw/certificateInfoServlet?currentPage=${page.currentPage+1}">下一页
                        </a> |
                    </c:when>
                    <c:otherwise>
                        下一页 | 尾页
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
    <div class="clear"></div>

</div>
</body>
<!-- //Body -->
<%--<script>--%>
<%--    addEventListener("load", function () {--%>
<%--        setTimeout(hideURLbar, 0);--%>
<%--    }, false);--%>

<%--    function hideURLbar() {--%>
<%--        window.scrollTo(0, 1);--%>
<%--    }--%>

<%--</script>--%>

</html>
