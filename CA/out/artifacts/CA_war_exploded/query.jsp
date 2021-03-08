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
        /*body{*/
        /*    background: url(./images/背景1.jpg) no-repeat fixed center;*/
        /*    background-size: cover;*/
        /*    -webkit-background-size: cover;*/
        /*    -moz-background-size: cover;*/
        /*    -o-background-size: cover;*/
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
            width: 100%;
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
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<!-- //Head -->

<!-- Body -->
<body>
<canvas id="canvas"></canvas>
<div>
    <button type="submit" style="font-size: 18px" class="btn btn-link" onclick="back()">返回</button>
</div>
<div class="loginForm">
    <h1>查询证书</h1>
    <form method="post" action="QueryServlet">
        <!--        这几个组件都紧挨着不太好看,通过样式调整一下即可-->
        <input autocomplete＝“on” id="uName" name="serial_NUmber" type="text" autofocus="autofocus" required="required"  />
        <label for="uName" id="label1">请输入证书序列号</label>
        <input type="submit" value="查询" />
    </form>
</div>
</body>

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

