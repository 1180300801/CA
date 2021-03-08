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
<%--    <link rel="stylesheet" href="css/style.css" type="text/css" media="all">--%>
    <style>

        *:not(p) {
            margin: 0;
            padding: 0;
        }
        #canvas{
            position: fixed;
            background: #ccc;
            overflow: auto;
            z-index: -1;
        }

        /*body {*/
        /*    background: url(./images/背景1.jpg)  no-repeat fixed center;*/
        /*    background-size: cover;*/
        /*    -webkit-background-size: cover;*/
        /*    -moz-background-size: cover;*/
        /*    -o-background-size: cover;*/
        /*}*/

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
        .item-button input[type="submit"],.item-button input[type="button"] {
            width: 100%;
            padding: 10px 0;
            font-size: 20px;
            font-weight: 100;
            background-color: transparent;
            color: #03090b;
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
            background-color: rgba(53, 191, 226, 0.1);
            border: 1px solid #e1ddd7;
            color: #03090b;
            transition: 0.1s all;
            -webkit-transition: 0.1s all;
            -moz-transition: 0.1s all;
            -o-transition: 0.1s all;
            -ms-transition: 0.1s all;
            text-decoration: none;
        }

        .item-button input[type="button"]:hover {
            background-color: rgba(53, 191, 226, 0.1);
            border: 1px solid #e1ddd7;
            color: #03090b;
            transition: 0.1s all;
            -webkit-transition: 0.1s all;
            -moz-transition: 0.1s all;
            -o-transition: 0.1s all;
            -ms-transition: 0.1s all;
            text-decoration: none;
        }
    </style>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/x0popup.min.css">

</head>
<!-- //Head -->

<!-- Body -->
<body onload="download_msg()">
<canvas id="canvas"></canvas>
<div>
    <span style="display:inline-block; font-family: 楷体; font-weight: bold; font-size: 20px; margin-top:
10px; margin-left: 10px;"><%=request.getSession().getAttribute("username")%>，欢迎您</span>
    <form action="LogoutServlet" method="post" style="display:inline-block; float: right;margin-top: 10px; margin-right: 10px">
        <button type="submit" class="btn btn-primary">退出登录</button>
    </form>
</div>

<div style="text-align: center;height: 15%"><h1>CTF数字证书认证中心</h1></div>

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
                <form action="SelectServlet" method="post">
                    <input type="text" required name="select" value="1" style="display: none">
                    <input type="submit" value="证 书 库">
                </form>
            </li>
            <li>
                <form action="SelectServlet" method="post">
                    <input type="text" required name="select" value="2" style="display: none">
                    <input type="submit" value="吊 销 证 书 列 表">
                </form>
            </li>
        </ul>
    </div>
    <div class="item-button">
        <ul>
            <li>
                <form action="DownloadServlet" method="post" id="download_root">
                    <input type="text" required name="download" value="root" style="display: none">
                    <input type="button" value="CA 的 公 钥" onclick="thanks()">
                </form>
            </li>
            <li>
                <form action="DownloadServlet" method="post" id="download_genRSAkey">
                    <input type="text" required name="download" value="genRSAkey" style="display: none">
                    <input type="button" value="秘 钥 生 成 器" onclick="download_genKey()">
                </form>
            </li>
        </ul>
    </div>
</div>
<div style="position: fixed; bottom: 0px;left: 0px; text-align: center">
    Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
</div>
</body>
<!-- //Body -->
<script src="js/x0popup.min.js"></script>
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

    function thanks() {
        x0p('感谢您的信任',
            '感谢您的信任。此文件包含本机构公钥与及对公钥的签名，通过下载此文件您可以获取公钥。点击确定，下载文件！',
            'ok', function (button) {
                if(button==='ok'){
                    document.getElementById("download_root").submit();
                }
            });
    }

    function download_genKey() {
        x0p('下载RSA公钥生成器',
            '点击OK即可下载一个名为genRSAkey.exe的RSA秘钥生成器，下载成功后点击即可在其相同目录下生产公私钥文件 ！',
            'ok', function (button) {
                if(button==='ok'){
                    document.getElementById("download_genRSAkey").submit();
                }
            });
    }

    function download_msg() {
        var msg = '<%=request.getAttribute("download_msg")%>';
        if(msg !== 'null'&& msg !== null){
            x0p('系统提示',
                msg,
                'error', false);
        }
    }

    function exec(number) {
        var code = document.getElementById('code-' + number).innerText;
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
