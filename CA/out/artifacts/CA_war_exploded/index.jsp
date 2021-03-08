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
      width: 400px;
      height: 350px;
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

    #login:hover{
      /*鼠标悬停的状态,使用伪类选择器*/
      opacity: 0.7;/*调整透明度,也可以调整颜色*/
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
      margin-top: 20px;
      padding: 0 28px;
    }

    #copyright{
      position: fixed; bottom: 0; left: 400px;
    }
  </style>
  <link rel="stylesheet" href="css/x0popup.min.css">
  <link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body onload="msg()">
<div class="loginForm" id="login_frame">

  <p><h1>欢迎登陆CA系统</h1></p>
  <a id="register" href="register.jsp">没有账号？注册一个！</a>

  <form method="post" action="LoginServlet" id="login_form">
    <p>
        <input type="text" class="text_field" id="sign_username" required="" name="sign_username" style="display: none" />
        <input type="text" id="username" required name="username" style="margin-top: 10px" class="form-control" placeholder="请输入用户名(邮箱)">
<%--      <label class="label_input">用户名</label>--%>
<%--      <label for="username"></label>--%>
<%--      <input type="text" class="text_field" id="sign_username" required="" name="sign_username" style="display: none" />--%>
<%--      <input type="text" id="username" name="username" class="text_field" placeholder="请输入账户名" />--%>
    </p>
    <p>
        <input type="text" class="text_field" id="sign_password" required="" name="sign_password" style="display: none" />
        <input type="password" id="password" required name="password" class="form-control" placeholder="请输入密码">
<%--      <label class="label_input">密码</label>--%>
<%--      <label for="password"></label>--%>
<%--      <input type="text" class="text_field" id="sign_password" required="" name="sign_password" style="display: none" />--%>
<%--      <input type="password" id="password" name="password" class="text_field" placeholder="请输入密码" />--%>
    </p>
    <p>
    <div class="input-group">
      <input style="height: 45px" type="text" required class="form-control" placeholder="输入验证码(点击可更换)" name="ValiImage" autocomplete="off">
      <span class="input-group-btn">
        <img style="height: 45px" src="CheckNumServlet" onclick="changeValiImage(this)" type="button" class="btn btn-default" />
<%--        <button class="btn btn-default" type="button">Go!</button>--%>
      </span>
    </div>
<%--    <img src="CheckNumServlet" onclick="changeValiImage(this)" class="label_input" /><!-- 验证码图片 -->--%>
<%--    <input type="text" placeholder="输入验证码" name="ValiImage" class="text_field" autocomplete="off" /><!-- 输入验证码文本 -->--%>
    </p>

    <div id="login_control">
      <input type="button" id="login" value="登录">
      <div class="block-code" hidden>
        <pre><code data-language="javascript" id="code-1">x0p('Message', '该功能还没有实现哦!');</code></pre>
      </div>
      <div class="block-detail">
        <a id="forget_pwd" href="javascript:exec(1);">忘记密码？</a>
      </div>
    </div>
  </form>
</div>

<p id="copyright">
  Copyright © 2020-2021 1180300801 版权所有。如有问题，请联系：QQ：1928511940
</p>
<canvas id="canvas"></canvas>
</body>
<script src="js/x0popup.min.js"></script>
<script src="./js/jsencrypt.js"></script>
<script src="js/jquery-3.5.1.min.js"></script>
<script src="js/sha256-min.js"></script>

<script>

  var login_btn = document.getElementById("login");

  <!-- 验证码图片点击切换 -->
  <!-- 通过Date来改变每次访问的url不同 -->
  function changeValiImage(img){
    img.src = "CheckNumServlet?time="+ new Date().getTime();
  }
  
  function msg() {
    var m = '<%=request.getAttribute("login_msg")%>';
    if(m !== 'null'){
      x0p('系统提示',
              m,
              'error', false);
    }
  }
  
  function exec(number) {
    var code = document.getElementById('code-' + number).innerText;
    eval(code);
  }

  login_btn.addEventListener("click", function(){
    var username = document.getElementById("username");
    var password = document.getElementById("password");
    var sign_username = document.getElementById("sign_username");
    var sign_password = document.getElementById("sign_password");
    var encrypt = new JSEncrypt();
    var publicKey = '-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvUwaPaek8peagiBpjdtPlnvMKGT6SEPdSQfLnj06IBeTOWlBSE5gyqZmjmiPfk9jKuezpcaIfs1Z0bpkHMv2DDstvN7vf7gweGRQngp5DOHbM+g4E4nd6iII6of8tQwNi+QeK0HtwMTpCZo44ruwDVK52z0wY3m/nLCwZCuWo7QIDAQAB-----END PUBLIC KEY-----';
    encrypt.setPublicKey(publicKey);
    var enc_username = encrypt.encrypt(username.value);
    var enc_password = encrypt.encrypt(password.value);
    sign_username.value = hex_sha256(username.value);
    sign_password.value = hex_sha256(password.value);
    username.value = enc_username;
    password.value = enc_password;
    document.getElementById("login_form").submit();
    username.value="";
    password.value="";
  });

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

