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
    <title>注册页面</title>
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

        .loginForm {
            width: 350px;
            height: 370px;
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
            font-family: 宋体, serif;

            width: 90px;
            height: 28px;
            line-height: 28px;
            text-align: center;

            color: #feff90;
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

        input[type="submit"],input[type="reset"]:hover{
            /*鼠标悬停的状态,使用伪类选择器*/
            opacity: 0.8;/*调整透明度,也可以调整颜色*/
        }

        #copyright{
            position: fixed; bottom: 0; left: 400px;
        }
    </style>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/x0popup.min.css">

</head>

<body onload="register_msg()">
<div class="loginForm" id="login_frame">

    <p><h1>欢迎注册CA系统</h1></p>
    <a id="register" href="index.jsp">已有账号？去登录！</a>

    <form method="post" action="RegisterServlet" id="register_form">
        <p style="margin-top: 20px">
        <div class="input-group">
            <input type="text" class="text_field" id="sign_username" name="sign_username" style="display: none" />
            <input type="text" class="form-control" id="username" name="username" placeholder="输入您的邮箱(邮箱将成为您的用户名)" onblur="validate_username(this.value)" aria-describedby="basic-addon2">
            <span class="input-group-addon"><em id="test_user"></em></span>
        </div>
<%--            <label class="label_input">输入邮箱</label>--%>
<%--            <label for="username"></label>--%>
<%--            <input type="text" class="text_field" id="sign_username" required="" name="sign_username" style="display: none" />--%>
<%--            <input type="text" class="text_field" id="username" name="username" placeholder="邮箱将成为您的用户名" onblur="validate_username(this.value)" />--%>
<%--            <em id="test_user"></em>--%>

        <p>
        <div class="input-group">
            <input type="text" class="text_field" id="sign_idCard" name="sign_idCard" style="display: none" />
            <input type="text" class="form-control" id="idCard" name="idCard" placeholder="输入您的身份证号(18位)" onblur="validate_idCard(this.value)" aria-describedby="basic-addon2">
            <span class="input-group-addon"><em id="test_idCard"></em></span>
        </div>

        </p>
        <p>
        <div class="input-group">
            <input type="text" class="text_field" id="sign_password" name="sign_password" style="display: none" />
            <input type="password" class="form-control" id="password" name="password" placeholder="6位以上密码由数字和字母组成" onblur="validate_password(this.value)" aria-describedby="basic-addon2">
            <span class="input-group-addon"><em id="test_pw"></em></span>
        </div>
<%--            <label class="label_input">输入密码</label>--%>
<%--            <label for="password"></label>--%>
<%--            <input type="text" class="text_field" id="sign_password" required="" name="sign_password" style="display: none" />--%>
<%--            <input type="password" class="text_field" id="password" name="password" placeholder="6位以上密码由数字和字母组成" onblur="validate_password(this.value)" />--%>
<%--            <em id="test_pw"></em>--%>
        </p>
        <p>
        <div class="input-group">
            <input type="password" class="form-control" id="password2" name="password2" placeholder="确认密码" onblur="validate_password2(this.value)" aria-describedby="basic-addon2">
            <span class="input-group-addon"><em id="is_test_pw"></em></span>
        </div>
<%--            <label class="label_input">确认密码</label>--%>
<%--            <label for="password"></label>--%>
<%--            <input type="password" class="text_field" id="password2" name="password2" onblur="validate_password2(this.value)" />--%>
<%--            <em id="is_test_pw"></em>--%>
        </p>

        <div id="register_control">
            <button type="button" class="btn btn-info" id="register_btn" style="width: 100%;margin-top: 10px" value="注册">注    册</button>
        </div>
    </form>
</div>

<p id="copyright">
    Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
</p>
<canvas id="canvas"></canvas>
</body>
<script src="./js/jsencrypt.js"></script>
<script src="js/jquery-3.5.1.min.js"></script>
<script src="js/sha256-min.js"></script>
<script src="js/x0popup.min.js"></script>

<script>
    function register_msg(){
        var m = '<%=request.getAttribute("register_msg")%>';
        if(m !== 'null'&& m !== null){
            if(m==="注册成功！"){
                x0p('系统提示',
                    '注册成功!点击确定返回登录页面',
                    'ok', function (button) {
                    if(button==='ok'){
                        window.location.href = "index.jsp";
                    }
                    });
            }
            else{
                x0p('系统提示',
                    m,
                    'error', false);
            }
        }
    }

    function exec(number) {
        var code = document.getElementById('code-' + number).innerText;
        eval(code);
    }
</script>

<script>
    var register_btn = document.getElementById("register_btn");

    //onblur失去焦点事件，用户离开输入框时执行 JavaScript 代码：
    //验证邮箱格式
    function validate_username(username){
        //定义正则表达式的变量:邮箱正则
        var emailReg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(username !=="" && username.search(emailReg) !== -1)
        {
            document.getElementById("test_user").innerHTML = "<font color='green' size='3px'>✔</font>";
        }else{
            document.getElementById("test_user").innerHTML = "<font color='red' size='3px'>✘</font>";
        }
    }

    function validate_idCard(idCard){
        //定义正则表达式的变量:邮箱正则
        var idCardReg=/^[1-9][0-9]{14}$|^[1-9][0-9]{16}([0-9]|[xX])$/;
        if(idCard !=="" && idCard.search(idCardReg) !== -1)
        {
            document.getElementById("test_idCard").innerHTML = "<font color='green' size='3px'>✔</font>";
        }else{
            document.getElementById("test_idCard").innerHTML = "<font color='red' size='3px'>✘</font>";
        }
    }

    //验证密码是否符合要求：匹配6位密码，由数字和字母组成：
    function validate_password(password){
        var passwordReg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$/;
        if(password !== "" && password.search(passwordReg) !== -1)
        {
            document.getElementById("test_pw").innerHTML = "<font color='green' size='3px'>✔</font>";
        }else{
            document.getElementById("test_pw").innerHTML = "<font color='red' size='3px'>✘</font>";
        }
    }

    //验证两次输入的密码是否一样
    function validate_password2(password2){
        var password = document.getElementById("password").value;
        if (password === ""){
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>✘</font>";
        }else if(password===password2){
            document.getElementById("is_test_pw").innerHTML = "<font color='green' size='3px'>✔</font>";
        }else{
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>✘</font>";
        }
    }

    //验证表单是否已经填好
    register_btn.addEventListener("click", function(){
        var username = document.getElementById("username");
        var idCard = document.getElementById("idCard");
        var password = document.getElementById("password");
        var password2 = document.getElementById("password2");
        //console.log("表单填写正确，可以正常提交！");

        //这三个，如果任何一个有问题，都返回false
        //18128@qq.com		12345y
        var emailReg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var idCardReg=/^[1-9][0-9]{14}$|^[1-9][0-9]{16}([0-9]|[xX])$/;
        var passwordReg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$/;

        if(username.value !== "" && emailReg.test(username.value)){
            if(idCard.value !== "" && idCardReg.test(idCard.value)){
                if(password.value !=="" && passwordReg.test(password.value)){
                    if(password2.value===password.value){
                        reg_encrypt();
                        document.getElementById("register_form").submit();
                        username.value = "";
                        idCard.value = "";
                        password.value = "";
                    }
                }
            }
        }
    });

    function reg_encrypt() {
        var username = document.getElementById("username");
        var idCard = document.getElementById("idCard");
        var password = document.getElementById("password");
        var sign_username = document.getElementById("sign_username");
        var sign_idCard = document.getElementById("sign_idCard");
        var sign_password = document.getElementById("sign_password");
        var encrypt = new JSEncrypt();
        var publicKey = '-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvUwaPaek8peagiBpjdtPlnvMKGT6SEPdSQfLnj06IBeTOWlBSE5gyqZmjmiPfk9jKuezpcaIfs1Z0bpkHMv2DDstvN7vf7gweGRQngp5DOHbM+g4E4nd6iII6of8tQwNi+QeK0HtwMTpCZo44ruwDVK52z0wY3m/nLCwZCuWo7QIDAQAB-----END PUBLIC KEY-----';
        encrypt.setPublicKey(publicKey);
        var enc_username = encrypt.encrypt(username.value);
        var enc_idCard = encrypt.encrypt(idCard.value);
        var enc_password = encrypt.encrypt(password.value);
        sign_username.value = hex_sha256(username.value);
        sign_idCard.value = hex_sha256(idCard.value);
        sign_password.value = hex_sha256(password.value);
        username.value = enc_username;
        idCard.value = enc_idCard;
        password.value = enc_password;
    }

<%--</script>--%>

<%--<script>--%>
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

