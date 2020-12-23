<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<!-- Head -->
<head>

    <title>数字证书认证中心</title>

    <!-- Meta-Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- //Meta-Tags -->

    <!-- Style -->
    <style>
        /*通用的初始化*/
        /**{*/
        /*  font-size: 11pt;*/
        /*  font-family: "黑体";!*此处使用字体列表可以使网站兼容性更好一些*!*/
        /*  margin:0;!*默认所有元素都没有外边距*!*/
        /*  padding: 0;!*默认所有的元素都没有填充距离(补丁距离/内边距)*!*/
        /*}*/
        body{
            background: url(./images/背景1.jpg) no-repeat fixed center;
            background-size: cover;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
        }
        /*背景色统一为白色的,所以可以在外部单独定义*/
        .loginForm{
            margin: 150px auto;/*如果给定两个方位的值,是指上下为0 ,左右为自动(居中)*/
            padding: 20px 0;/*内部元素离这个块的边距离,对于该块来说就是填充距离*/
            /*垂直对齐的基本思路是获取视窗大小,然后使用视窗的宽高定位  (win-this.width)/2 需要js支持,暂时不考虑 */
            background-color: rgba(255,255,255,1);
            box-shadow: 18px 18px 30px -15px rgba(255,0,0,1);/*盒子投影*/
            text-align: center;
        }
        /*此处要考虑到在不同的界面下,登录框的占比不同,所以应该使用媒体响应的方式*/
        @media all and (max-width: 600px) {
            .loginForm {
                width: 80%;
                height: 40%;
            }
        }
        @media all and (min-width: 600px) {
            .loginForm {
                width: 60%;/*限定宽度为百分比(<=240)*/
                max-width: 500px;/*如果百分比宽度超过了指标值,则限定极限值*/
                min-width: 200px;
            }
        }
        input{
            width: 90%;
            display: block;/*块元素,默认独立成行,默认表单组件可能超过了外框的大小*/
            margin: 10px 20px;
            padding: 5px;
        }
        [type="text"]{
            /*使用了并集选择器*/
            border: none;/*边框*/
            outline: none;/*对于默认带有外边线的元素,要使用outline定义*/
            border-bottom: 1px solid rgba(0,0,0,0.2);/*单独定义下边框,这点疏忽了*/
            transition: all 300ms ease-in 10ms;/*过渡效果一般建议添加在双向上*/
        }
        [type="text"]:focus{
            /*使用了并集选择器,焦点聚焦到表单元件时*/
            /*此处改写了代码,无需重复定义*/
            border-bottom: 3px solid rgba(0,255,0,0.2);/*单独定义下边框*/
            transition: all 300ms ease-in 10ms;/*过渡效果一般建议添加在双向上*/
        }
        input[type="submit"]{
            color: rgba(255,255,255,1);/*文字颜色*/
            background-color: rgba(50,225,156,0.8);
        }
        input[type="submit"]:hover{
            /*鼠标悬停的状态,使用伪类选择器*/
            opacity: 0.8;/*调整透明度,也可以调整颜色*/
        }
        div h1{
            font-size: 2em;
        }
        label{
            position: relative;
            top: -35px;
        }
        input:focus +label,
        input:valid +label
        {
            position: relative;
            top:-45px;
            left:0;
            color:#03a9f4;
            font-size:0.8em;
            transition: all 300ms ease-in 10ms;
        }
    </style>
</head>
<!-- //Head -->

<!-- Body -->
<body background="images/背景1.jpg">
<!--表单的外部容器,主要是为了定位,css中为了体现通用性的设计,一般的建议是能用class就不要用id-->
<span style="text-align: right; font-family: 楷体; font-weight: bold; font-size: 20px; margin-top:
20px; margin-right: 20px; color: #3BD9FF"><%=request.getSession().getAttribute("username")%>，欢迎您</span>
<div class="loginForm">
    <h1>下载证书</h1>
    <form method="post" action="${appContext}/login.action">
        <!--        这几个组件都紧挨着不太好看,通过样式调整一下即可-->
        <input autocomplete＝“on” id="uName" name="username" type="text" autofocus="autofocus" required="required"  />
        <label for="uName" id="label1">序列号</label>
        <input type="submit" value="下载" />
    </form>
</div>
</body>
</html>

</html>
