<%--
  User: setusb
  Date: 2021/6/7
  Time: 16:05
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<link href="../../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<script src="../../../resources/layui/layui.js"></script>
<script src="../../../resources/js/jquery-3.6.0.min.js"></script>
<link href="../../../resources/jqui/jquery-ui.css" rel="stylesheet">
<script src="../../../resources/jqui/external/jquery/jquery.js"></script>
<script src="../../../resources/jqui/jquery-ui.js"></script>

<html>
<head>
    <title>个人博客 - 安全管理</title>
</head>
<body>
<div class="background"></div>

<div class="box_one" style="position: relative">
    <div class="layui-form-label"
         style="width: 300px;position: absolute;left: 50%;transform: translate(-50%,-40%);top: 40%">
        <label for="pwd"></label><input class="layui-input" style="width: 300px;text-align: center" type="text" id="pwd"
                                        placeholder="请输入你的新密码">
    </div>

    <div style="position: absolute;left: 50%;bottom: 5%;transform: translate(-50%,-5%)">
        <button id="ok" class="layui-btn">确认修改</button>
        <button class="layui-btn" onclick="window.location.href = '/index'">返回主页</button>
    </div>
</div>
</body>
<script>

    $(function () {
        if (getCookie("bgcolor").length > 0) {
            $('.background').css({
                display: 'none'
            });
        } else {
            $('.background').css({
                display: 'display'
            });
        }

        $('#ok').click(function () {
            let pwd = $('#pwd').val();
            if (pwd.length >= 6 && pwd.length <= 16) {
                $.ajax({
                    type: "POST",
                    url: "/default/xgmm",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data: {
                        "pwd": pwd
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response['a']) {
                            layer.alert("修改完毕！");
                            $('#pwd').val("")
                        } else {
                            layer.alert("修改失败！");
                        }
                    }
                });
            } else {
                layer.alert("密码不能低于6位、高于16位！");
            }
        });
    });

    function getCookie(cname) {
        const name = cname + "=";
        const ca = document.cookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            const c = ca[i].trim();
            if (c.indexOf(name) === 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
</script>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    .background {
        -webkit-box-sizing: content-box;
        -moz-box-sizing: content-box;
        box-sizing: content-box;
        width: 100%;
        height: 100%;
        z-index: -999999;
        border: none;
        position: fixed;
        top: 0;
        font: normal 100%/normal Arial, Helvetica, sans-serif;
        color: rgba(255, 255, 255, 1);
        -o-text-overflow: clip;
        text-overflow: clip;
        background: -webkit-linear-gradient(45deg, rgba(0, 0, 0, 0.0980392) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0.0980392) 75%, rgba(0, 0, 0, 0.0980392) 0), -webkit-linear-gradient(45deg, rgba(0, 0, 0, 0.0980392) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0.0980392) 75%, rgba(0, 0, 0, 0.0980392) 0), rgb(255, 255, 255);
        background-position: 0 0, 40px 40px;
        -webkit-background-origin: padding-box;
        background-origin: padding-box;
        -webkit-background-clip: border-box;
        background-clip: border-box;
        -webkit-background-size: 80px 80px;
        background-size: 80px 80px;
    }

    .box_one {
        width: 80%;
        height: 500px;
        margin: 5% auto;
        background-color: white;
        border: 1px solid #eeeeee;
        border-radius: 8px;
    }
</style>
</html>
