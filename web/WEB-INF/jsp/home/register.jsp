<%--
  User: setusb
  Date: 2021/4/18
  Time: 12:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="resources/layui/css/layui.css" rel="stylesheet" type="text/css">

<!-- jquery ui 的导入 -->
<link href="../../../resources/jqui/jquery-ui.css" rel="stylesheet">
<script src="../../../resources/jqui/external/jquery/jquery.js"></script>
<script src="../../../resources/jqui/jquery-ui.js"></script>
<%--<script src="resources/js/jquery-3.6.0.min.js"></script>--%>
<script src="resources/layui/layui.js"></script>

<html>
<head>
    <title>个人博客 - 注册</title>
</head>
<body>
<ul class="ul_point">
    <span></span>
</ul>
<form class="reigster_form">
    <div class="rd layui-anim layui-anim-scale">
        <p>
            <span>用&nbsp;&nbsp;户&nbsp;&nbsp;名: </span><input id="username" type="text" placeholder="请输入用户名"
                                                             title="Please Enter User Name"
                                                             class="layui-input">
        </p>
        <p>
            <span>昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称: </span><input id="nickname" type="text"
                                                                              title="Please Enter A Nickname"
                                                                              placeholder="请输入昵称" class="layui-input">
        </p>
        <p>
            <span>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码: </span><input id="password" type="password"
                                                                              title="Please Enter The Password"
                                                                              placeholder="请输入密码" class="layui-input">
        </p>
        <p>
            <span>确认密码: </span><input id="confirmpassowrd" type="password" title="Please Confirm Your Password"
                                      placeholder="请确认密码" class="layui-input">
        </p>
        <p>
            <span>选择性别: </span>
            <select id="sex" name="sex">
                <option value="男" title="男">男</option>
                <option value="女" title="女">女</option>
            </select>
        </p>
        <p style="display: inline">
            <span>个人简介: </span><textarea id="userinfo" placeholder="请输入你的个人信息"
                                         title="Please Enter Your Personal Information"
                                         class="layui-textarea"></textarea>
        </p>
        <div class="btn">
            <button id="login_btn" onclick="loginUser()" class="layui-btn layui-btn-normal" type="button">登录</button>
            <button id="register_btn" onclick="registerUser()" class="layui-btn" type="button">注册</button>
            <button id="reset_btn" class="layui-btn layui-btn-danger" type="reset">重置</button>
            <%--            <button id="back_btn" onclick="back()" class="layui-btn layui-btn-normal" type="reset">返回</button>--%>
        </div>
    </div>
</form>

<div class="login_register_zz">
    <div class="login_register layui-anim layui-anim-scale">
        <form style="text-align: center">
            <%--    <div class="layui-form-item" id="a1" style="background-color: red">
                    <label class="layui-form-label">用户名 :</label>
                    <div class="layui-input-block">
                        <input id="usernames" type="text" name="username" required lay-verify="required" placeholder="请输入用户名"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item" id="a2">
                    <label class="layui-form-label">密&nbsp;&nbsp;&nbsp;&nbsp;码 :</label>
                    <div class="layui-input-block">
                        <input id="passwords" type="password" name="password" required lay-verify="required"
                               placeholder="请输入密码" autocomplete="off" class="layui-input">
                    </div>
                </div>--%>
            <%--            <div id="a3">
                            <button type="button" id="close" class="layui-btn layui-btn-warm">注册</button>
                            <button type="button" onclick="logIn()" class="layui-btn">登录</button>
                            <button type="reset" class="layui-btn layui-btn-danger">重置</button>
                        </div>--%>

            <p style="padding: 40px 0 10px 0;">
                <span>用&nbsp;&nbsp;户&nbsp;&nbsp;名: </span><input id="usernames" type="text"
                                                                 title="Please Enter Your Username" placeholder="请输入用户名"
                                                                 class="layui-input">
            </p>
            <p style="margin: 10px 0;">
                <span>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码: </span><input id="pwds" type="password"
                                                                                  title="Please Enter Your Password"
                                                                                  placeholder="请输入密码"
                                                                                  class="layui-input">
            </p>

            <div style="text-align: center;position:relative;padding: 30px 0">
                <a style="box-shadow: 10px 0 20px gray;zoom: 1;background-color: gray;font-weight: bold;color: white;padding: 8px 30px 5px 30px;border-radius: 5px">小提示</a>
                <p style="font-size: 11px;box-shadow: 10px 0 20px gray;line-height: 100px;border-radius: 8px;position: absolute;left:50%;transform: translate(-50%);width: 200px;height: 120px;background-color: gray;color: white">
                    按下<span style="color: red">Enter</span>登录，按下<span style="color: red">Esc</span>返回主页
                </p>
            </div>

            <div class="btn" style="padding: 140px 0;">
                <button id="close" class="layui-btn layui-btn-normal" type="button">注册</button>
                <button type="button" onclick="logIn()" class="layui-btn">登录</button>
                <button type="reset" class="layui-btn layui-btn-danger">重置</button>
                <%--            <button id="back_btn" onclick="back()" class="layui-btn layui-btn-normal" type="reset">返回</button>--%>
            </div>

        </form>
    </div>
</div>

<div class="gradient-pattern"></div>
</body>

<script>
    function back() {
        window.location.replace("index");
    }

    $(function () {

        if (getCookie("bgcolor").length > 0) {
            $('.gradient-pattern').css({
                display: 'none'
            });
        } else {
            $('.gradient-pattern').css({
                display: 'display'
            });
        }

        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i].trim();
                if (c.indexOf(name) === 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }

        $(document).tooltip();

        $(document).keyup(function (event) {
            if (event.keyCode === 13) {
                /*                console.log($('.login_register_zz').display)
                                if ($('.login_register_zz').display === 'none') {
                                    alert(1)
                                }*/
                if ($('.login_register_zz').is(':hidden')) {
                    registerUser();
                } else {
                    logIn();
                }
            }

            if (event.keyCode === 27) {
                window.location = "/index"
            }
        });

        $('#close').click(function () {
            $('.reigster_form').toggle();
            $('.login_register_zz').toggle();
        });
    });

    function loginUser() {
        $('.reigster_form').toggle();
        $('.login_register_zz').toggle();
    }

    function logIn() {
        if ($('#usernames').val() !== '' && $("#pwds").val() !== '') {
            $.ajax({
                async: false,
                type: "POST",
                url: "/userjson",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    "name": $('#usernames').val(),
                    "password": $("#pwds").val()
                },
                dataType: "json",
                success: function (response) {
                    var user = response['user'];

                    /*
                                    $.each(user, function (index, obj) {
                                        console.log(obj['nickname'])
                                    });
                    */

                    if (response['flag']) {
                        $('.ul_point>span').text("登录成功，正在跳转");
                        $('.ul_point').css({
                            display: "block"
                        })
                        setTimeout(function () {
                            $('.ul_point').css({
                                display: "none"
                            })
                        }, 1000);
                        setTimeout(function () {
                            window.location.replace("<%=request.getContextPath()%>/index");
                        }, 2000);
                    } else {
                        $('.ul_point>span').text("登录失败");
                        $('.ul_point').css({
                            display: "block"
                        })
                        setTimeout(function () {
                            $('.ul_point').css({
                                display: "none"
                            })
                        }, 1000);
                    }
                },
                error: function () {
                    alert("数据获取失败")
                }
            });
        } else {
            $('.ul_point>span').text("请输入用户名和密码");
            $('.ul_point').css({
                display: "block"
            })
            setTimeout(function () {
                $('.ul_point').css({
                    display: "none"
                })
            }, 1000);
        }
    }

    function registerUser() {

        var password = $('#password').val().trim();
        var confirmpassowrd = $('#confirmpassowrd').val()
        var username = $('#username').val().trim();
        var nickname = $('#nickname').val().trim();

        console.log(nickname.length)

/*        if (nickname.length > 12 && username.length > 12) {
            $('.ul_point>span').text("用户名昵称长度过长");
            $('.ul_point').css({
                display: "block"
            });
            setTimeout(function () {
                $('.ul_point').css({
                    display: "none"
                })
            }, 1000);
        }*/

        if (nickname === '' && username === '') {
            $('.ul_point>span').text("请输入用户名或昵称");
            $('.ul_point').css({
                display: "block"
            });
            setTimeout(function () {
                $('.ul_point').css({
                    display: "none"
                })
            }, 1000);
        }/*else if (nickname.length <=12 && username.length <=20) {
        }*/ else if (password === confirmpassowrd && password !== '' && password.length >= 6) {

            $.ajax({
                async: false,
                type: "POST",
                url: "/registerUser",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    "username": $('#username').val(),
                    "nickname": $('#nickname').val(),
                    "password": $('#password').val(),
                    "sex": $('#sex').val(),
                    "userinfo": $('#userinfo').val()
                },
                dataType: "json",
                success: function (res) {
                    if (res['flag']) {
                        $('.ul_point>span').text("注册成功，正在跳转");
                        $('.ul_point').css({
                            display: "block"
                        });
                        setTimeout(function () {
                            $('.ul_point').css({
                                display: "none"
                            })
                        }, 1000);
                        setTimeout(function () {
                            window.location.href = "/index"
                        }, 2000);
                    } else {
                        $('.ul_point>span').text("用户名冲突，请更换");
                        $('.ul_point').css({
                            display: "block"
                        });
                        setTimeout(function () {
                            $('.ul_point').css({
                                display: "none"
                            })
                        }, 1000);
                    }
                }
            });
        } else {
            $('.ul_point>span').text("密码长度大于或等于6");
            $('.ul_point').css({
                display: "block"
            });
            setTimeout(function () {
                $('.ul_point').css({
                    display: "none"
                })
            }, 1000);
        }
    }
</script>
<style>
    .login_register_zz {
        background-color: white;
        width: 450px;
        height: 430px;
        box-shadow: 0 0 10px gray;
        margin: 120px auto;
        position: relative;
        border-radius: 12px;
        display: none;
    }

    .gradient-pattern {
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
        background: -moz-linear-gradient(45deg, rgba(0, 0, 0, 0.0980392) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0.0980392) 75%, rgba(0, 0, 0, 0.0980392) 0), -moz-linear-gradient(45deg, rgba(0, 0, 0, 0.0980392) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0.0980392) 75%, rgba(0, 0, 0, 0.0980392) 0), rgb(255, 255, 255);
        background: linear-gradient(45deg, rgba(0, 0, 0, 0.0980392) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0.0980392) 75%, rgba(0, 0, 0, 0.0980392) 0), linear-gradient(45deg, rgba(0, 0, 0, 0.0980392) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0.0980392) 75%, rgba(0, 0, 0, 0.0980392) 0), rgb(255, 255, 255);
        background-position: 0 0, 40px 40px;
        -webkit-background-origin: padding-box;
        background-origin: padding-box;
        -webkit-background-clip: border-box;
        background-clip: border-box;
        -webkit-background-size: 80px 80px;
        background-size: 80px 80px;
    }

    .reigster_form {
        background-color: white;
        width: 450px;
        height: 430px;
        box-shadow: 0 0 10px gray;
        margin: 120px auto;
        position: relative;
        border-radius: 12px;
    }

    .rd {
        width: 250px;
        margin: 0 auto;
        padding: 30px 0;
    }

    .reigster_form p {
        margin: 10px 0;
    }

    .layui-anim {
        animation-duration: .6s;
    }

    .layui-input {
        width: 175px;
        height: 30px;
        display: inline;
    }

    #sex {
        width: 100px;
        line-height: 1.3;
        background-color: #fff;
        border-radius: 2px;
        color: gray;
        border: 1px solid gainsboro;
    }

    .btn {
        margin: 20px 0 0 10px;
    }

    .ul_point {
        z-index: 9999;
        position: fixed;
        width: 300px;
        height: 50px;
        left: 50%;
        top: 30px;
        border-radius: 5px;
        box-shadow: 0 0 10px gray;
        transform: translate(-50%);
        background-color: white;
        display: none;
    }

    .ul_point span {
        line-height: 50px;
        position: absolute;
        left: 50%;
        transform: translate(-50%);
    }
</style>
</html>