<%@ page import="comDao.certificate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>数字证书认证中心</title>

    <meta charset="UTF-8">
    <!--声明文档兼容模式，表示使用IE浏览器的最新模式-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--设置视口的宽度(值为设备的理想宽度)，页面初始缩放值<理想宽度/可见宽度>-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
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
    </style>

    <link rel="stylesheet" href="css/x0popup.min.css">
    <script src="js/x0popup.min.js"></script>

</head>
<body onload="verify()" style="overflow-y:hidden;overflow-x: hidden">
<canvas id="canvas"></canvas>
<div>
    <button type="submit" style="font-size: 18px" class="btn btn-link" onclick="back()">返回主页</button>
</div>
<div>
    <form action="VerifyServlet" method="post" enctype="multipart/form-data">
        <div  class="row" style="margin-bottom: 20px; margin-top: 30px">
            <div class="col-md-2"></div>
            <div class="col-md-6">
                <div class="input-group">
                    <span class="input-group-btn">
                        <button id="upload_btn" name="upload_btn" value="选择上传文件" class="btn btn-default" type="button">选择文件</button>
                    </span>
                    <input type="text" id="upload_file_name" autocomplete="off" name="upload_file_name" class="form-control" placeholder="选择上传要验证的证书，点击右侧按钮即可验证">
                    <input type="file" required id="upload_file" name="upload_file" style="display: none">
                </div>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-info">点击验证证书</button>
            </div>
            <div class="col-md-2"></div>
        </div>
    </form>
    <form action="QueryServlet" method="post">
        <div  class="row" style="margin-bottom: 20px; margin-top: 30px">
            <div class="col-md-2"></div>
            <div class="col-md-6">
                <input class="form-control" required name="organization" type="text" style="float: left" placeholder="输入要查询的证书的拥有者，点击右侧按钮即可查询">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-info">点击查询证书</button>
            </div>
            <div class="col-md-2"></div>
        </div>
    </form>
    <form  action="QueryServlet" method="post">
        <div  class="row" style="margin-bottom: 40px;">
            <div class="col-md-2"></div>
            <div class="col-md-6">
                <input class="form-control" required name="serial_NUmber" type="text" style="float: left" placeholder="输入要查询的证书的序列号，点击右侧按钮即可查询">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-info">点击查询证书</button>
            </div>
            <div class="col-md-2"></div>
        </div>
    </form>
</div>
<div style="overflow-x: scroll;overflow-y: scroll;height: 60%">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <table class="table table-hover">
            <tr>
                <td>序号</td>
                <td>证书拥有者</td>
                <td>证书序列号</td>
            </tr>
            <%int row = 0;%>
            <c:forEach items="${requestScope.certificate_list}" var="certificate" >
                <tr>
                    <th><%=++row%></th>
                    <%String id = String.valueOf(row);%>
                    <th>${certificate.organization}</th>
                    <th>
                        <form id=<%=id%> method="post" action="QueryServlet">
                            <input style="display: none" name="serial_NUmber" value=${certificate.serial_Number} />
                            <a onclick="document.getElementById(<%=id%>).submit();">
                                    ${certificate.serial_Number}
                            </a>
                        </form>
                    </th>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="col-md-2"></div>
</div>
</body>

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

<script>
    function verify() {
        var m = '<%=request.getAttribute("verify_msg")%>';
        if(m !== 'null'){
            if(m==='true'){
                x0p('系统提示',
                    '该证书有效!',
                    'ok', false);
            }
            if(m==='false'){
                x0p('系统提示',
                    '该证书无效',
                    'error', false);
            }
        }
    }
</script>

<script>
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