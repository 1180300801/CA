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
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        #canvas{
            position: fixed;
            background: #ccc;
            overflow: auto;
            z-index: -1;
        }
    </style>
    <link rel="stylesheet" href="css/x0popup.min.css">
    <script src="js/x0popup.min.js"></script>
    <script src="./js/jsencrypt.js"></script>
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/sha256-min.js"></script>

</head>
<!-- //Head -->

<!-- Body -->
<body onload="msg()">
<canvas id="canvas"></canvas>
<div>
    <button type="submit" style="font-size: 18px" class="btn btn-link" onclick="back()">返回主页</button>
</div>

<div class="container" style="width: 75%;">
    <%certificate cer= (certificate)request.getSession().getAttribute("certificate");%>
    <%String delete_msg =(String)request.getAttribute("delete_msg");%>
    <h3>证 书</h3>
    <table class="table table-hover">
        <tr>
            <td>证书版本</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getVersion()+"</td>");
            }
            %>
        </tr>
        <tr>
            <td>发行机构</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getIssuer()+"</td>");
            }
            %>
        </tr>
        <tr>
            <td>序列号</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getSerial_Number()+"</td>");
            }
            %>
        </tr>
        <tr>
            <td>签名算法</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getSign_Algorithm()+"</td>");
            }
            %>
        </tr>
        <tr>
            <td>摘要算法</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getDigest_Algorithm()+"</td>");
            }
            %>
        </tr>
        <tr>
            <td>组织机构</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getOrganization()+"</td>");
            }
            %>
        </tr>
        <tr>
            <td>生效日期</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getStart_time()+"</td>");
            }
            %>
        </tr>

        <tr>
            <td>失效日期</td>
            <%if(cer==null){
                out.print("<td><a href='apply.jsp'>还没有证书，去注册</a></td>");
            }
            else {
                out.print("<td>"+cer.getEnd_time()+"</td>");
            }
            %>
        </tr>
    </table>
    <div>
        <form action="DownloadServlet" method="post" style="display:inline-block;">
            <input type="text" required name="download" value="common" style="display: none">
            <button type="submit" class="btn btn-success">下载证书</button>
        </form>
        <%if(request.getSession().getAttribute("cer_Owner").equals(true)){%>
            <form action="DeleteServlet" method="post" id="delete_form" style="display:inline-block; float: right">
                <input type="text" required id="delete_password" name="delete_password" style="display: none">
                <button type="button" class="btn btn-danger" onclick="exec(3)">撤销证书</button>
                <div class="block-code-full" style="display: none">
                    <pre><code data-language="javascript" id="code-3">x0p({
                title: '验证密码',
                type: 'warning',
                inputType: 'password',
                inputPlaceholder: '输入您的登录密码进行验证',
                inputColor: '#F29F3F',
                inputPromise: function(button, value) {
                    var p = new Promise(function(resolve, reject) {
                        if(value == '')
                            resolve('密码不能为空!');
                        resolve(null);
                    });
                    return p;
                }
            }, function(button, text) {
                if(button == 'warning') {
                    var delete_password = document.getElementById("delete_password");
                    var encrypt = new JSEncrypt();
                    var publicKey = '-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvUwaPaek8peagiBpjdtPlnvMKGT6SEPdSQfLnj06IBeTOWlBSE5gyqZmjmiPfk9jKuezpcaIfs1Z0bpkHMv2DDstvN7vf7gweGRQngp5DOHbM+g4E4nd6iII6of8tQwNi+QeK0HtwMTpCZo44ruwDVK52z0wY3m/nLCwZCuWo7QIDAQAB-----END PUBLIC KEY-----';
                    encrypt.setPublicKey(publicKey);
                    delete_password.value = encrypt.encrypt(text);
                    document.getElementById("delete_form").submit();
                }
});</code></pre>
                </div>
<%--				<pre><code data-language="javascript" id="code-3">x0p('Enter Your Password', null, 'input',--%>
<%--function(button, text) {--%>
<%--	if(button == 'info') {--%>
<%--                    var delete_password = document.getElementById("delete_password");--%>
<%--                    var encrypt = new JSEncrypt();--%>
<%--                    var publicKey = '-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvUwaPaek8peagiBpjdtPlnvMKGT6SEPdSQfLnj06IBeTOWlBSE5gyqZmjmiPfk9jKuezpcaIfs1Z0bpkHMv2DDstvN7vf7gweGRQngp5DOHbM+g4E4nd6iII6of8tQwNi+QeK0HtwMTpCZo44ruwDVK52z0wY3m/nLCwZCuWo7QIDAQAB-----END PUBLIC KEY-----';--%>
<%--                    encrypt.setPublicKey(publicKey);--%>
<%--                    delete_password.value = encrypt.encrypt(text);--%>
<%--                    document.getElementById("delete_form").submit();--%>
<%--	}--%>
<%--});</code></pre>--%>
<%--                </div>--%>
            </form>
        <%}%>
        <%if(!request.getSession().getAttribute("cer_Owner").equals(true)){%>
        <div style="display:inline-block; float: right">
            <div class="block-code" hidden>
                <pre><code data-language="javascript" id="code-2">x0p('系统提示', '假期愉快！');</code></pre>
            </div>
            <button type="submit" class="btn btn-primary" onclick="exec(2)">点我有惊喜</button>
        </div>
        <%}%>
    </div>
</div>
<div style="position: fixed; bottom: 0px;left: 0px; text-align: center">
    Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
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
    function back() {
        window.location.href = "home.jsp";
    }

    function msg() {
        var m = '<%=request.getAttribute("delete_msg")%>';
        if(m === "撤销证书成功"){
            x0p('系统提示',
                '撤销证书成功!',
                'ok', false);
        }
        if(m === "撤销证书失败(证书可能不存在)"){
            x0p('系统提示',
                '撤销证书失败(证书可能不存在)',
                'error', false);
        }
        if(m === "密码错误"){
            x0p('系统提示',
                '密码错误',
                'error', false);
        }
    }

    function exec(num) {
        var code = document.getElementById('code-'+num).innerText;
        eval(code);
    }
</script>

<script>
    window.requestAnimationFrame = (function(){
        return window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            function( callback ){
                window.setTimeout( callback, 1000/2 );
            };
    })();
    var myCanvas = document.getElementById("canvas");
    var ctx = myCanvas.getContext("2d");//getContext 设置画笔
    var num;
    var w,h;
    var duixiang = [];
    var move = {};
    function widthheight(){
        w = myCanvas.width = window.innerWidth;
        h = myCanvas.height = window.innerHeight;
        num= Math.floor(w*h*0.00028);//点的数量。根据屏幕大小确定
        for(var i = 0;i < num;i++){
            duixiang[i] = {
                x:Math.random()*w,
                y:Math.random()*h,
                cX:Math.random()*0.6-0.3,
                cY:Math.random()*0.6-0.3,
                R:Math.floor(Math.random()*5)+2,
                //CC:Math.floor(Math.random()*3)+2,
                r: Math.floor(Math.random() * 254),
                g: Math.floor(Math.random() * 254),
                b:Math.floor(Math.random() * 254)
            }
            // console.log(duixiang[i])
            Cricle(duixiang[i].x,duixiang[i].y,duixiang[i].R,duixiang[i].r,duixiang[i].g,duixiang[i].b);
            //Cricle(duixiang[i].x,duixiang[i].y,duixiang[i].R,duixiang[i].CC);
        }
    };widthheight();//获取浏览器的等宽度等高

    function Cricle(x,y,R,r,g,b){
        ctx.save();//保存路径
        if(Math.random()>0.991) {ctx.globalAlpha= 0.9;}//ctx.fillStyle = "#CCC";}//填充的背景颜色
        else { ctx.globalAlpha=0.47;}

        ctx.fillStyle = "rgb("+ r +","+ g +","+ b +")";
        ctx.beginPath();//开始绘画
        ctx.arc(x,y,R,Math.PI*2,0);//绘画圆 x y 半径（大小） 角度  一个PI 是180 * 2 = 360    真假 0/1 true/false
        ctx.closePath();//结束绘画
        ctx.fill();//填充背景颜色
        ctx.restore();//回复路径
    };Cricle();


    !function draw(){
        ctx.clearRect(0,0,w,h)//先清除画布上的点
        for(var i = 0;i < num;i++){
            duixiang[i].x += duixiang[i].cX;
            duixiang[i].y += duixiang[i].cY;
            if(duixiang[i].x>w || duixiang[i].x<0){
                duixiang[i].cX = -duixiang[i].cX;
            }
            if(duixiang[i].y>h || duixiang[i].y<0){
                duixiang[i].cY = -duixiang[i].cY;
            }
            Cricle(duixiang[i].x,duixiang[i].y,duixiang[i].R,duixiang[i].r,duixiang[i].g,duixiang[i].b);
            //勾股定理判断两点是否连线
            for(var j = i + 1;j < num;j++){
                if( (duixiang[i].x-duixiang[j].x)*(duixiang[i].x-duixiang[j].x)+(duixiang[i].y-duixiang[j].y)*(duixiang[i].y-duixiang[j].y) <= 55*55 ){
                    line(duixiang[i].x,duixiang[i].y,duixiang[j].x,duixiang[j].y,0,i,j)
                }
                if(move.x){
                    if( (duixiang[i].x-move.x)*(duixiang[i].x-move.x)+(duixiang[i].y-move.y)*(duixiang[i].y-move.y) <= 100*100 ){
                        line(duixiang[i].x,duixiang[i].y,move.x,move.y,1,i,1)
                    }
                }
            }
        }
        window.requestAnimationFrame(draw)
    }();

    //绘制线条
    function line(x1,y1,x2,y2,flag,i,j){

        if (flag){var color = ctx.createLinearGradient(x1,y1,x2,y2);
            ctx.globalAlpha=0.5;
            color.addColorStop(0,"rgb("+ duixiang[i].r +","+ duixiang[i].g +","+ duixiang[i].b +")");
            color.addColorStop(0.8,"#019ee5");
        }
        else
        {

            var color = ctx.createLinearGradient(x1,y1,x2,y2);
            ctx.globalAlpha=0.9;
            color.addColorStop(0,"rgb("+ duixiang[i].r +","+ duixiang[i].g +","+ duixiang[i].b +")");
            color.addColorStop(1,"rgb("+ duixiang[j].r +","+ duixiang[j].g +","+ duixiang[j].b +")");
        }
        ctx.save();
        ctx.strokeStyle = color;
        ctx.lineWidth = 0.5;
        ctx.beginPath();
        ctx.moveTo(x1,y1);
        ctx.lineTo(x2,y2);
        ctx.stroke();
        //ctx.restore();
    }


    //document.onmousemove = function(e){
    //   move.x = e.clientX;
    //  move.y = e.clientY;
    //}
    //console.log(move)//去掉注释 ，可以与背景互动

    window.onresize = function(){
        location.reload();
    }
</script>

</html>
