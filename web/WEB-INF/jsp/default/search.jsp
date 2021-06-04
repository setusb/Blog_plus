<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: setusb
  Date: 2021/4/23
  Time: 19:46
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="../../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<script src="../../../resources/js/jquery-3.6.0.min.js"></script>
<script src="../../../resources/layui/layui.js"></script>
<html>
<head>
    <title>个人博客 - 文章搜索</title>
</head>
<body>
<ul class="ul_point">
    <span></span>
</ul>
<ul class="layui-nav"
    style="user-select: none;background: #dc673d;border-radius: 0;width: 1080px;margin: 0 auto;box-shadow: 0 0 10px gray;">
    <li class="layui-nav-item"><a href="/index">首页</a></li>
    <%--    <li class="layui-nav-item"><a href="">疑难解答</a></li>--%>
    <%--    <li class="layui-nav-item">
            <a href="#">排行榜</a>
            <dl class="layui-nav-child">
                <dd><a href="">名人榜</a></dd>
                <dd><a href="">积分排行榜</a></dd>
                <dd><a href="">贡献排行榜</a></dd>
            </dl>--%>
    </li>
    <li class="layui-nav-item">
        <a id="search" style="cursor: pointer">搜索</a>
    </li>

    <li class="li_login" style="float: right;line-height: 60px"><a>登录 / 注册</a></li>

    <li class="sign_Out layui-nav-item" style="float: right">
        <a style="cursor: pointer"><img style="border: 3px solid white;padding: 2px"
                                        src="<%=request.getContextPath()%>/./resources/images/ava/ava.png"
                                        class="layui-nav-img"><span id="unames">null</span></a>
        <dl class="layui-nav-child">
            <%--<dd><a href="/default/userinfo">个人信息</a></dd>--%>
            <dd><a href="/pageArticles/0">个人信息</a></dd>
            <dd><a href="#">安全管理</a></dd>
            <c:if test="${abc == 2}">
                <dd><a href="/backstagelogin" style="color: blueviolet">博客后台</a></dd>
            </c:if>
            <%--            <dd><a href="#">积分管理</a></dd>--%>
            <dd><a href="/signOut" style="color: red">退出登录</a></dd>
        </dl>
    </li>
</ul>

<ul class="content_ul">
    <c:forEach items="${article}" var="item">
        <c:if test="${article.size() > 0}">
            <li>
                <a href="/article/${item.articleUuid}">${item.articleTitle}</a>
                <p>${item.articleTarget}</p>
            </li>
        </c:if>
    </c:forEach>
</ul>

<c:if test="${flag == 1}">
    <ul class="content_ul">
        <li>
            <a style="cursor: pointer">未找到</a>
            <p style="cursor: pointer">请重新搜索</p>
        </li>
    </ul>
</c:if>

<%@include file="../index/footer.jsp" %>
<div class="searchBar layui-anim layui-anim-down">
    <input id="searchContent" class="layui-input" placeholder="请输入搜索的内容">
    <button onclick="searchClick()" class="layui-btn layui-btn-warm">搜索</button>
</div>
<div class="gradient-pattern"></div>
</body>
<script>

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

    $('#search').click(function () {
        $('.searchBar').toggle();
    });

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

        var loginSuccessful = '<%= session.getAttribute("loginSuccessful")%>';

        $('.li_login').click(function () {
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
</script>
<style>
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
    .footer {
        width: 1080px;
        height: 30px;
        margin: 0 auto;
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

    .gradient-pattern {
        -webkit-box-sizing: content-box;
        -moz-box-sizing: content-box;
        box-sizing: content-box;
        width: 100%;
        height: 100%;
        z-index: -999999;
        border: none;
        position: absolute;
        top: 0;
        font: normal 100%/normal Arial, Helvetica, sans-serif;
        color: rgba(255,255,255,1);
        -o-text-overflow: clip;
        text-overflow: clip;
        background: -webkit-linear-gradient(45deg, rgba(0,0,0,0.0980392) 25%, rgba(0,0,0,0) 25%, rgba(0,0,0,0) 75%, rgba(0,0,0,0.0980392) 75%, rgba(0,0,0,0.0980392) 0), -webkit-linear-gradient(45deg, rgba(0,0,0,0.0980392) 25%, rgba(0,0,0,0) 25%, rgba(0,0,0,0) 75%, rgba(0,0,0,0.0980392) 75%, rgba(0,0,0,0.0980392) 0), rgb(255, 255, 255);
        background: -moz-linear-gradient(45deg, rgba(0,0,0,0.0980392) 25%, rgba(0,0,0,0) 25%, rgba(0,0,0,0) 75%, rgba(0,0,0,0.0980392) 75%, rgba(0,0,0,0.0980392) 0), -moz-linear-gradient(45deg, rgba(0,0,0,0.0980392) 25%, rgba(0,0,0,0) 25%, rgba(0,0,0,0) 75%, rgba(0,0,0,0.0980392) 75%, rgba(0,0,0,0.0980392) 0), rgb(255, 255, 255);
        background: linear-gradient(45deg, rgba(0,0,0,0.0980392) 25%, rgba(0,0,0,0) 25%, rgba(0,0,0,0) 75%, rgba(0,0,0,0.0980392) 75%, rgba(0,0,0,0.0980392) 0), linear-gradient(45deg, rgba(0,0,0,0.0980392) 25%, rgba(0,0,0,0) 25%, rgba(0,0,0,0) 75%, rgba(0,0,0,0.0980392) 75%, rgba(0,0,0,0.0980392) 0), rgb(255, 255, 255);
        background-position: 0 0, 40px 40px;
        -webkit-background-origin: padding-box;
        background-origin: padding-box;
        -webkit-background-clip: border-box;
        background-clip: border-box;
        -webkit-background-size: 80px 80px;
        background-size: 80px 80px;
    }

    .searchBar button {
        border-radius: 5px;
        float: right;
        box-shadow: 0 0 10px gray;
    }

    .layui-btn-warm {
        background-color: #dc673d;
    }

    .layui-nav .layui-this:after, .layui-nav-bar, .layui-nav-tree .layui-nav-itemed:after {
        background-color: transparent;
    }

    .content_ul {
        width: 1080px;
        margin: 10px auto;
    }

    .content_ul li {
        width: auto;
        height: 100px;
        line-height: 50px;
        margin: 10px auto;
        background-image: linear-gradient(#eceaea, #a0a0a0);
        border-radius: 10px;
        box-shadow: 0 0 10px gray;
    }

    .content_ul li a {
        font-size: 20px;
        margin-left: 20px;
        letter-spacing: 2px;
    }

    .content_ul li p {
        margin-left: 20px;
    }

    .content_ul li a:hover {
        color: red;
        transition: .5s;
    }
</style>
</html>
