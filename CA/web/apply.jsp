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

        body {
            background: url(./images/背景1.jpg)  no-repeat fixed center;
            background-size: cover;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
        }

        .loginForm {
            width: 400px;
            height: 400px;
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

        .input-group{
            margin-bottom: 10px;
        }

        form p > * {
            display: inline-block;
            vertical-align: middle;
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
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/x0popup.min.css">
</head>

<body onload="msg()">
<canvas id="canvas"></canvas>

<div>
    <button type="submit" style="font-size: 18px" class="btn btn-link" onclick="back()">返回</button>
</div>

<div class="loginForm" id="login_frame">

    <div><h2>欢迎注册CA证书</h2></div>

    <form id="register_form" method="post" action="ApplyServlet" enctype="multipart/form-data">
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <input type="text" class="form-control" id="organization" name="organization" required placeholder="您的组织的名称" aria-describedby="basic-addon1">
        </div>
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <input type="text" class="form-control" id="registration_number" name="registration_number" required placeholder="您的组织的工商注册号" aria-describedby="basic-addon1">
        </div>
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <input type="text" class="form-control" id="legal_person" name="legal_person" required placeholder="您的组织的法人代表" aria-describedby="basic-addon1">
        </div>
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <input type="text" class="form-control" id="phone_number" name="phone_number" required placeholder="您的组织的联系电话" aria-describedby="basic-addon1">
        </div>
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <select type="text" class="form-control" id = "valid_time"  name="valid_time" required aria-describedby="basic-addon1">
                <option value="1">一年（有效期）</option>
                <option value="2">两年（有效期）</option>
                <option value="3">三年（有效期）</option>
            </select>
        </div>
<%--        <div class="input-group">--%>
<%--            <span class="input-group-addon">@</span>--%>
<%--            <input type="text" class="form-control" name="public_key" placeholder="您的公钥" aria-describedby="basic-addon1">--%>
<%--        </div>--%>
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <input type="text" id="upload_file_name" autocomplete="off" name="upload_file_name" class="form-control" placeholder="输入公钥文件">
            <span class="input-group-btn">
            <button type="button" id="upload_btn" name="upload_btn" value="选择上传文件" class="btn btn-default">选择文件</button>
            </span>
            <input type="file" required id="upload_file" name="upload_file" style="display: none">
        </div>
        <button type="submit" style="width: 50%" class="btn btn-success">注    册</button>
    </form>
</div>

<p id="copyright">
    Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
</p>

<div class="block-code" hidden>
    <pre><code data-language="javascript" id="code-1">x0p('系统提示', '<%=request.getAttribute("msg")%>');</code></pre>
</div>
</body>

<script src="js/x0popup.min.js"></script>

<script>
    var upload_btn = document.getElementById("upload_btn");
    var upload_file = document.getElementById("upload_file");
    var upload_file_name = document.getElementById("upload_file_name");
    upload_btn.addEventListener("click", function () {
        upload_file.click();
    });
    upload_file.addEventListener("change", function () {
        upload_file_name.value = upload_file.value;
    });
</script>

<%--<script>--%>
<%--    function enc() {--%>

<%--        var organization = document.getElementById("organization");--%>
<%--        var registration_number = document.getElementById("registration_number");--%>
<%--        var legal_person = document.getElementById("legal_person");--%>
<%--        var phone_number = document.getElementById("phone_number");--%>
<%--        var valid_time = document.getElementById("valid_time");--%>

<%--        var encrypt = new JSEncrypt();--%>
<%--        var publicKey = '-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvUwaPaek8peagiBpjdtPlnvMKGT6SEPdSQfLnj06IBeTOWlBSE5gyqZmjmiPfk9jKuezpcaIfs1Z0bpkHMv2DDstvN7vf7gweGRQngp5DOHbM+g4E4nd6iII6of8tQwNi+QeK0HtwMTpCZo44ruwDVK52z0wY3m/nLCwZCuWo7QIDAQAB-----END PUBLIC KEY-----';--%>
<%--        encrypt.setPublicKey(publicKey);--%>

<%--        var enc_organization = encrypt.encrypt(organization.value);--%>
<%--        var enc_registration_number = encrypt.encrypt(registration_number.value);--%>
<%--        var enc_legal_person = encrypt.encrypt(legal_person.value);--%>
<%--        var enc_phone_number = encrypt.encrypt(phone_number.value);--%>
<%--        var enc_valid_time = encrypt.encrypt(valid_time.value);--%>

<%--        organization.value = enc_organization;--%>
<%--        registration_number.value = enc_registration_number;--%>
<%--        legal_person.value = enc_legal_person;--%>
<%--        phone_number.value = enc_phone_number;--%>
<%--        valid_time.value = enc_valid_time;--%>
<%--    }--%>
<%--</script>--%>

<script>
    function msg() {
        var m = '<%=request.getAttribute("msg")%>';
        if(m !== 'null'&& m !== null){
            if(m==="申请证书成功"){
                x0p('系统提示',
                    m,
                    'ok', false);
            }
            else{
                x0p('系统提示',
                    m,
                    'error', false);
            }
        }
    }

    function exec() {
        var code = document.getElementById('code-1').innerText;
        eval(code);
    }

    function back() {
        window.location.href = "home.jsp";
    }

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

