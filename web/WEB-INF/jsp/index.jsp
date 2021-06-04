<%@ page import="priv.blog.service.ArticleService" %>
<%@ page import="priv.blog.service.impl.ArticleServiceImpl" %><%--
  User: setusb
  Date: 2021/4/16
  Time: 16:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<html>
<head>
    <title>欢迎访问个人博客 - 主页</title>
</head>
<body>
<ul class="ul_point">
    <span></span>
</ul>

<div class="login_register_zz">
    <div class="login_register layui-anim layui-anim-down">
        <form>
            <div class="layui-form-item" id="a1">
                <label class="layui-form-label">用户名 :</label>
                <div class="layui-input-block">
                    <input id="username" type="text" name="username" required lay-verify="required" placeholder="请输入用户名"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" id="a2">
                <label class="layui-form-label">密&nbsp;&nbsp;&nbsp;&nbsp;码 :</label>
                <div class="layui-input-block">
                    <input id="password" type="password" name="password" required lay-verify="required"
                           placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div id="a3">
                <button type="button" onclick="logIn()" class="layui-btn">登录</button>
                <button type="reset" class="layui-btn layui-btn-danger">重置</button>
                <button type="button" id="close" class="layui-btn layui-btn-warm">关闭</button>
            </div>
            <span id="s1">●&nbsp;<a href="/requestRegister">点我前往注册</a></span>
        </form>
        <span id="s2">
            <label for="zddl"
                   style="display: block;float: left;clear: left;width: 90px;text-align: right;line-height: 30px;">
                <a style="text-decoration: none;color: black;line-height: 20px"
                   title="自动登录">自动登录: </a>
            </label>
            <input id="zddl" name="zddl" type="checkbox"
                   style="height: 15px;width: 15px;margin-left: 4px;margin-top: 3px;display: block;float: left;clear: right;line-height: 30px;">
        </span>
    </div>
</div>
<div class="nav_btns2" title="开启轮播图">三</div>
<%@include file="index/nav.jsp" %>
<%@include file="index/carousel.jsp" %>
<%@include file="index/content.jsp" %>
<div class="searchBar layui-anim layui-anim-down">
    <input id="searchContent" class="layui-input" placeholder="请输入搜索的内容">
    <button onclick="searchClick()" class="layui-btn layui-btn-warm">搜索</button>
</div>
<div class="pagination" style="user-select: none">
    <ul class="pagination_ul">
        <a href="/pageArticle/0" title="首部">
            <li><</li>
        </a>
        <c:if test="${pageNum.size() >= 10}">
            <c:forEach items="${pageNum}" var="item">
                <%--<li class="lister"><a href="/pageArticle/${item.page}">${item.page+1}</a></li>--%>
                <a href="/pageArticle/${item.page}">
                    <li class="lister">${item.page+1}</li>
                </a>
            </c:forEach>
            <li><input id="pageRequest" type="text" style="width: 21px;text-indent: 5px"></li>
        </c:if>
        <c:if test="${pageNum.size() <= 9}">
            <c:forEach items="${pageNum}" var="item">
                <%--<li class="lister"><a href="/pageArticle/${item.page}">${item.page+1}</a></li>--%>
                <a href="/pageArticle/${item.page}">
                    <li class="lister">${item.page+1}</li>
                </a>
            </c:forEach>
        </c:if>
        <a href="/pageArticle/${pageNum.size()-1}" title="尾部">
            <li>></li>
        </a>
        <li style="width: auto;margin-left: 1px;line-height: 21px;padding:0 4px;font-size: 11px;color: white ">
            总页数: ${pageNum.size()}</li>
    </ul>
</div>
<%--<div id="demo1"></div>--%>
<%@include file="index/footer.jsp" %>

<div class="gradient-pattern"></div>

</body>
<script src="../../resources/layui/layui.js"></script>
<script>


    function reqpage(page) {
        var s = parseInt(page - 1);
        window.location.href = "/pageArticle/" + s
    }

    function searchClick() {
        var sc = $('#searchContent').val();
        if ($('#searchContent').val() === '') {
            $('.ul_point>span').text("请输入内容");
            $('.ul_point').css({
                display: "block"
            });
            setTimeout(function () {
                $('.ul_point').css({
                    display: "none"
                })
            }, 1000);
        } else {
            window.location.href = "/search/" + sc;
        }
    }
</script>
<style>

    .nav_btns2 {
        display: none;
        width: 36px;
        height: 36px;
        position: fixed;
        top: 75%;
        left: 50px;
        color: black;
        background: #dc673d;
        padding: 0;
        font-size: 20px;
        text-align: center;
        line-height: 36px;
        cursor: pointer;
        box-shadow: 0 0 10px gray;
        border-radius: 19px;
    }

    .nav_btns2:hover {
        color: white;
        transition: .5s;
    }

    .layui-btn-warm {
        background-color: #dc673d;
    }

    .turnOffTheCarousel {
        position: absolute;
        bottom: 10px;
        right: 20px;
        width: 40px;
        height: 20px;
        text-align: center;
        background-color: rgba(62, 60, 60, 0.25);
    }

    .turnOffTheCarousel a {
        font-weight: bold;
        cursor: pointer;
    }

    .searchBar {
        display: none;
        position: absolute;
        width: 400px;
        height: 38px;
        z-index: 10000;
        left: 35%;
        top: 5%;
        background-color: white;
        padding: 10px;
        box-shadow: 0 0 20px gray;
        border-radius: 10px;
        transform: translate(-50%);
    }

    .searchBar input {
        width: 320px;
        display: inline-block;
        box-shadow: 0 0 10px gray;
        border-radius: 5px;
    }

    .searchBar button {
        border-radius: 5px;
        float: right;
        box-shadow: 0 0 10px gray;
    }
</style>
<script src="../../resources/js/jquery-3.6.0.min.js"></script>
<script src="../../resources/layui/layui.js"></script>
<script>

    layui.use('layer', function () {
        var layer = layui.layer;
        $('#sout').click(function () {
            layer.open({
                title: '退出登录',
                offset: '150px',
                btnAlign: 'c',
                btn: ['退出登录', '关闭自动登录后退出'],
                content: "自动登录开启会包保持7天，您无需输入密码，即可享受自动登录服务器" +
                    "<br>" +
                    "这对安全方面是个问题，如果您想关闭，点击关闭 <span style='color: red'>自动登录后退出</span> 即可"
                , yes: function (index, layero) {
                    layer.close(index);
                    window.location.href = "/signOut"
                }
                , btn2: function (index, layero) {
                    if (getCookie("username") === '' && getCookie("userpassword") === '') {
                        layer.open({
                            title: '退出登录',
                            offset: '150px',
                            btnAlign: 'c',
                            content: "您并没有开启自动登录，您确定直接退出登录吗？",
                            btn: ['直接退出', '关闭']
                            , yes: function (index, layero) {
                                layer.close(index);
                                window.location.href = "/signOut"
                            }
                            , btn2: function (index, layero) {
                                layer.close(index);
                            }
                        })
                    } else {
                        clearCookie("username");
                        clearCookie("userpassword");
                        window.location.href = "/signOut"
                    }
                }
            })
        });
    });

    layui.use('carousel', function () {

        let carousel = layui.carousel;

        carousel.render({
            elem: '#test1'
            , width: '1080px'
            , height: '300px'
            , arrow: 'always'
        });
    });

    function jumpClick(pages) {
        window.location.replace("<%=request.getContextPath()%>/article/" + pages);
    }


    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toGMTString();
        //修复cookit在多个不同路径下不共享的的问题
        document.cookie = cname + "=" + cvalue + "; " + expires + ";path=/";
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

    function clearCookie(name) {
        setCookie(name, "", -1);
    }

    $(function () {

        var sb = ${article.size()};
        if (sb === 0) {
            window.location.href = "/pageNotFound"
        }


        $(document).keyup(function (event) {
            if (event.keyCode === 13) {
                if ($('#pageRequest').val() !== '') {
                    reqpage($('#pageRequest').val());
                }
            }
        });

        if (getCookie("username").length > 0 && getCookie("userpassword")) {
            automaticLogIn(getCookie("username"), getCookie("userpassword"));
        }

        if (getCookie("bgcolor").length > 0) {
            $('.gradient-pattern').css({
                display: 'none'
            });
        } else {
            $('.gradient-pattern').css({
                display: 'display'
            });
        }

        if (getCookie("lbt_cookit") === "true") {
            $('#lbts').css({display: 'none'})
            $('.nav_btns2').css({display: 'block'})
        }

        $('.nav_btns2').click(function () {
            if (getCookie("lbt_cookit") !== "") {
                clearCookie("lbt_cookit");
                $('#lbts').css({display: 'block'})
                $('.nav_btns2').css({display: 'none'})
            }
        });

        $('#turnOffTheCarouselButton').click(function () {
            if (getCookie("lbt_cookit") === "") {
                /*console.log(getCookie("lbt_cookit"))*/
                setCookie("lbt_cookit", "true", 1)
                $('#lbts').toggle();
                $('.nav_btns2').css({display: 'block'})
            } else {
                alert("出现错误，请联系管理员！");
            }
        });

        $('#search').click(function () {
            $('.searchBar').toggle();
        });

        var loginSuccessful = '<%= session.getAttribute("loginSuccessful")%>';

        $('.nav_btn').click(function () {
            $('.nav_btn_s').toggle();
        });

        $('.li_login').click(function () {
            $('.login_register_zz').toggle();
            $('.searchBar').css({display: 'none'})
        });

        $('#close').click(function () {
            $('.login_register_zz').toggle();
        });

        if (loginSuccessful.length === 4) {
            $('.li_login').css({
                display: "block"
            });
            $('.sign_Out').css({
                display: "none"
            });
        } else {
            $('.li_login').css({
                display: "none"
            });
            $('.sign_Out').css({
                display: "block"
            });
            $.ajax({
                type: "POST",
                url: "/userInfoJson",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    "uuid": loginSuccessful
                },
                dataType: "json",
                success: function (response) {
                    var user = response['user'];
                    $.each(user, function (index, obj) {
                        $('#unames').text(obj['nickname'])
                    });
                }
            })
        }
    });

    function logIn() {
        if ($('#username').val() !== '' && $("#password").val() !== '') {
            $.ajax({
                async: false,
                type: "POST",
                url: "/userjson",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    "name": $('#username').val(),
                    "password": $("#password").val()
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

                        if ($("#zddl[type='checkbox']").is(':checked')) {
                            setCookie("username", $('#username').val(), 7);
                            setCookie("userpassword", $("#password").val(), 7);
                        }


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
                        }, 1000);
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

    $(function () {
        $('.login_register_zz').click(function () {
        });
    });

    function automaticLogIn(name, pwd) {
        $.ajax({
            async: false,
            type: "POST",
            url: "/userjson",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "name": name,
                "password": pwd
            },
            dataType: "json",
            success: function (response) {

            }
        });
    }
</script>
<style>
    .nav_btn {
        width: 36px;
        height: 36px;
        position: fixed;
        top: 80%;
        left: 10px;
        color: black;
        background: #dc673d;
        padding: 0;
        font-size: 20px;
    }

    .nav_btn_s {
        display: none;
    }

    .title_Nav {
        height: 60px;
        position: relative;
        background: #dc673d;
    }

    .title_Nav a {
        color: white;
        align-content: center;
        font-size: 30px;
        position: absolute;
        left: 50%;
        line-height: 60px;
        transform: translate(-50%);
        font-weight: bold;
    }

    .layui-nav-tree .layui-nav-bar {
        background-color: #000000;
        border-radius: 20%;
    }

    .layui-nav-itemed > .layui-nav-child {
        border-bottom-right-radius: 20px;
        border-bottom-left-radius: 20px;
    }

    .layui-nav-tree .layui-nav-item a:hover {
        background-color: transparent;
    }

    .login_register_zz {
        width: 100%;
        height: 100%;
        background: rgba(212, 212, 212, 0.6);
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=rgba(212, 212, 212, 0.6), endColorstr=rgba(212, 212, 212, 0.6));
        position: fixed;
        z-index: 1000;
        display: none;
    }

    .login_register {
        width: 400px;
        height: 300px;
        position: relative;
        background-color: white;
        /*        top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);*/
        margin: 120px auto;
        border-radius: 20px;
        box-shadow: 0 0 10px #4b482e;
        border: 10px solid #e87f0e;
    }

    .login_register form {
        margin: 20px auto;
        position: relative;
        width: 360px;
        height: 220px;
    }

    #username {
        margin: 0 auto;
    }

    #a1 {
        position: absolute;
        top: 50px;
    }

    #a2 {
        position: absolute;
        top: 100px;
    }

    #a3 {
        position: absolute;
        width: 300px;
        top: 180px;
        left: 75px;
    }

    #s1 a:hover {
        color: red;
    }

    .layui-anim {
        animation-duration: .5s;
    }

    .ul_point {
        z-index: 99999;
        position: fixed;
        width: 260px;
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

    .layui-nav .layui-this:after, .layui-nav-bar, .layui-nav-tree .layui-nav-itemed:after {
        background-color: transparent;
    }

    #s2 {
        position: absolute;
        left: 30px;
    }

    .li_login a {
        color: #eeeeee;
        cursor: pointer;
    }

    .li_login a:hover {
        color: white;
    }

    .content_ul {
        width: 1080px;
        margin: 10px auto;
    }

    .content_ul li {
        width: auto;
        /*        zoom: 1;
                display: initial;*/
        height: 100px;
        line-height: 50px;
        margin: 10px auto;
        background-image: linear-gradient(#eeeeee, #cccccc);
        box-shadow: 2px 0 5px gray;
        cursor: alias;
        text-align: center;
    }

    .content_ul_a {
        font-size: 20px;
        margin-left: 20px;
        letter-spacing: 2px;
    }

    .content_ul li p {
        margin-left: 20px;
    }

    .content_ul_a:hover {
        color: red;
        transition: .5s;
    }

    .footer {
        width: 1080px;
        height: 30px;
        margin: 0 auto;
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

</style>
</html>