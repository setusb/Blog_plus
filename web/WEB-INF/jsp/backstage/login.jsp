<%--
  User: setusb
  Date: 2021/6/1
  Time: 18:14
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="../../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<link href="../../../resources/layui/css/paper.css" rel="stylesheet" type="text/css">
<script src="../../../resources/js/jquery-3.6.0.min.js"></script>
<script src="../../../resources/layui/layui.js"></script>

<html>
<head>
    <title>个人博客 - 后台登录</title>
</head>
<body>
<div class="row flex-spaces" style="width: 300px;margin: 10px auto" id="msg_div">
    <%--    <input class="alert-state" id="alert-5" type="checkbox">--%>
    <div class="alert alert-danger dismissible">
        <span id="msg"></span>
        <%--        <label class="btn-close"  for="alert-5">X</label>--%>
    </div>
</div>
<form class="login_from">
    <h2 style="margin-bottom: 5px;font-family: 黑体,serif;letter-spacing: 10px;text-align: center">后台登录</h2>
    <div class="form-group">
        <input type="text" style="width: 500px;background-color: white" placeholder="请输入你的用户名" id="paperInputs1">
        <input type="password" style="width: 500px;background-color: white" placeholder="请输入你的密码" id="paperInputs2">
        <div class="yzm">
            <input type="text" style="width: 290px;background-color: white;margin-right: 10px" placeholder="请输入验证码" id="verify">
            <canvas style="width: 100px;height: 44px" id="verifyCanvas"></canvas>
            <img style="width: 200px;height: 44px" id="code_img">
        </div>
        <button style="letter-spacing: 10px" id="submit" type="button" class="btn-block">登录</button>
    </div>
</form>
<%--<img class="imgs" src="../../../resources/images/img/dlam1.png" draggable="false">--%>
</body>


<script>

    //验证码代码借鉴: https://blog.csdn.net/chenjingshen1214/article/details/82627845

    var nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
        'L', 'M', 'N', 'O', 'P', 'Q', 'R',
        'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
        'y', 'z'
    ];
    var colors = []
    drawCode();

    // 绘制验证码
    function drawCode() {
        var canvas = document.getElementById("verifyCanvas"); //获取HTML端画布
        var context = canvas.getContext("2d"); //获取画布2D上下文
        context.fillStyle = "cornflowerblue"; //画布填充色
        context.fillRect(0, 0, canvas.width, canvas.height);
        // 创建渐变
        var gradient = context.createLinearGradient(0, 0, canvas.width, 0);
        gradient.addColorStop("0", "magenta");
        gradient.addColorStop("0.5", "blue");
        gradient.addColorStop("1.0", "red");
        //清空画布
        context.fillStyle = gradient; //设置字体颜色
        context.font = "25px Arial"; //设置字体
        var rand = [];
        var x = [];
        var y = [];
        for (var i = 0; i < 4; i++) {
            rand[i] = nums[Math.floor(Math.random() * nums.length)]
            x[i] = i * 16 + 10;
            y[i] = Math.random() * 20 + 20;
            context.fillText(rand[i], x[i], y[i]);
        }
        // console.log(rand);
        //画3条随机线
        for (var i = 0; i < 3; i++) {
            drawline(canvas, context);
        }

        // 画30个随机点
        for (var i = 0; i < 30; i++) {
            drawDot(canvas, context);
        }
        convertCanvasToImage(canvas)


        // 点击提交进行验证
        $("#submit").click((e) => {
            var newRand = rand.join('').toUpperCase();
            //下面就是判断是否== 的代码，无需解释
            var oValue = $('#verify').val().toUpperCase();
            if (oValue === 0) {
            } else if (oValue !== newRand) {
                oValue = ' ';
            } else {
                //验证码验证成功后！
                if ($('#paperInputs1').val() === "") {
                    $("#msg").text("请输入你的账号");
                    $('#msg_div').css({display: "block"});
                    setTimeout(function () {
                        $('#msg_div').css({display: "none"});
                    }, 1000);
                }

                if ($('#paperInputs2').val() === "") {
                    $("#msg").text("请输入你的密码");
                    $('#msg_div').css({display: "block"});
                    setTimeout(function () {
                        $('#msg_div').css({display: "none"});
                    }, 1000);
                }

                $.ajax({
                    async: false,
                    type: "POST",
                    url: "/backstagepostlogin",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data: {
                        "username": $('#paperInputs1').val(),
                        "pwd": $('#paperInputs2').val()
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response['a']) {
                            window.location.replace("<%=request.getContextPath()%>/backstageindex");
                        } else {
                            alert("登录失败，密码或账号错误、或权限等级不足！")
                            location.reload();
                        }
                    }
                });

            }

        })
    }

    // 随机线
    function drawline(canvas, context) {
        context.moveTo(Math.floor(Math.random() * canvas.width), Math.floor(Math.random() * canvas.height)); //随机线的起点x坐标是画布x坐标0位置，y坐标是画布高度的随机数
        context.lineTo(Math.floor(Math.random() * canvas.width), Math.floor(Math.random() * canvas.height)); //随机线的终点x坐标是画布宽度，y坐标是画布高度的随机数
        context.lineWidth = 0.5; //随机线宽
        context.strokeStyle = 'rgba(50,50,50,0.3)'; //随机线描边属性
        context.stroke(); //描边，即起点描到终点
    }

    // 随机点(所谓画点其实就是画1px像素的线，方法不再赘述)
    function drawDot(canvas, context) {
        var px = Math.floor(Math.random() * canvas.width);
        var py = Math.floor(Math.random() * canvas.height);
        context.moveTo(px, py);
        context.lineTo(px + 1, py + 1);
        context.lineWidth = 0.2;
        context.stroke();

    }

    // 绘制图片
    function convertCanvasToImage(canvas) {
        document.getElementById("verifyCanvas").style.display = "none";
        var image = document.getElementById("code_img");
        image.src = canvas.toDataURL("image/png");
        return image;
    }

    // 点击图片刷新
    document.getElementById('code_img').onclick = function () {
        $('#verifyCanvas').remove();
        $('#verify').after('<canvas width="100" height="40" id="verifyCanvas"></canvas>')
        drawCode();
    }

    $(function () {
        $('#verifyCanvas').remove();
        $('#verify').after('<canvas width="100" height="40" id="verifyCanvas"></canvas>')
        drawCode();
    });
</script>

<style>

    #msg_div {
        display: none;
    }

    .yzm {

    }

    #verify {
        float: left;
    }

    #verifyCanvas {
        float: right;
        width: 320px;
    }

    * {
        user-select: none;
        background-color: #F2F2F2;
    }

    .login_from {
        width: 500px;
        position: absolute;
        top: 30%;
        left: 50%;
        transform: translate(-50%, -30%);
    }

    .login_from input {
        margin: 0 0 10px 0;
    }

    .imgs {
        /*        border-style: none;*/
        width: 340px;
        height: 400px;
        position: absolute;
        top: 30%;
        left: 25%;
        transform: translate(-25%, -30%);
        /*        box-shadow: 0 0 10px goldenrod;*/
    }
</style>
</html>
