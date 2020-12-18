<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>8_常用注册页面的表单实例（含验证）.html</title>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

    <style type="text/css">
        body{
            background-image: url("/images/背景1.jpg");
            background-size: 100%;
            background-repeat: no-repeat;
            /* 当内容高度大于图片高度时，背景图像的位置相对于viewport固定 */
            background-attachment: fixed;  /*此条属性必须设置否则可能无效*/
            /* 让背景图基于容器大小伸缩 */
            background-size: cover;
            /* 设置背景颜色，背景图加载过程中会显示背景色 */
            background-color: #CCCCCC;
        }
        #user_reg{
            font-family: 微软雅黑;
            font-size: 40px;
            text-align: center;
            margin-top: 200px;
        }
        form{
            width: 500px;					/*设置宽度，方便使其居中*/
            margin: 40px auto auto auto;	/*上右下左*/
            font-size: 25px;
        }
        input{
            height: 30px;
            width: 12em;
            margin-top: 5px;
            margin-bottom: 5px;
        }
        /*input标签下的属性选择器*/
        input[type="submit"],input[type="reset"]{
            height: 25px;
            width: 5em;
            margin-top: 5px;
            margin-left: 6px;
        }
    </style>
</head>

<script type="text/javascript">

    function changeValiImage(img){
        img.src = "CheckNumServlet?time="+ new Date().getTime();
    }

    //onblur失去焦点事件，用户离开输入框时执行 JavaScript 代码：
    //验证邮箱格式
    function validate_username(username){
        //定义正则表达式的变量:邮箱正则
        var emailReg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(username !="" && username.search(emailReg) != -1)
        {
            document.getElementById("test_user").innerHTML = "<font color='green' size='3px'>√邮箱格式正确</font>";
        }else{
            document.getElementById("test_user").innerHTML = "<font color='red' size='3px'>邮箱格式错误</font>";
        }
    }

    //验证密码是否符合要求：匹配6位密码，由数字和字母组成：
    function validate_password(password){
        var passwordReg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6}$/;
        if(password != "" && password.search(passwordReg) != -1)
        {
            document.getElementById("test_pw").innerHTML = "<font color='green' size='3px'>√密码格式正确</font>";
        }else{
            document.getElementById("test_pw").innerHTML = "<font color='red' size='3px'>密码格式错误</font>";
        }
    }

    //验证两次输入的密码是否一样
    function validate_password2(password2){
        var password = document.getElementById("password").value;
        if (password == ""){
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>密码不为空</font>";
        }else if(password==password2){
            document.getElementById("is_test_pw").innerHTML = "<font color='green' size='3px'>√两次输入的密码相同</font>";
        }else{
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>两次输入的密码不相同</font>";
        }
    }

    //验证表单是否已经填好
    function validate_form(){
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        var password2 = document.getElementById("password2").value;
        //console.log("表单填写正确，可以正常提交！");

        //这三个，如果任何一个有问题，都返回false
        //18128@qq.com		12345y
        var emailReg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var passwordReg=/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6}$/;

        if(username != "" && emailReg.test(username)){
            if(password !="" && passwordReg.test(password)){
                if(password2==password){
                    return true;
                }else{
                    return false;
                }
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
</script>

<body>
<div id="user_reg">用户注册:</div>
<form method="post" action="RegisterServlet" name="form" >
    <table>
        <tr>
            <td>请输入账号：</td>
            <td><input type="text" id="username" name="username" placeholder="只能用邮箱注册" onblur="validate_username(this.value)"/></td>
            <td id="test_user"></td>
        </tr>
        <tr>
            <td>请输入密码：</td>
            <td><input type="password" id="password" name="password" placeholder="6位密码由数字和字母组成" onblur="validate_password(this.value)"/></td>
            <td id="test_pw"></td>
        </tr>
        <tr>
            <td>请确认密码：</td>
            <td><input type="password" id="password2" name="password2" onblur="validate_password2(this.value)" /></td>
            <td id="is_test_pw"></td>
        </tr>
        <tr>
            <td><img src="CheckNumServlet" onclick="changeValiImage(this)" /><!-- 验证码图片 --></td>
            <td><input type="text" placeholder="输入验证码" name="ValiImage" /><!-- 输入验证码文本 --></td>
        </tr>
        <tr>
            <td></td>
            <td ><input type="submit" id="submit_form" value="注册" onclick="return validate_form()"/>
                <input type="reset" value="重置"/>
            </td>
        </tr>
    </table>
</form>
</body>
</html>