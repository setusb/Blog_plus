<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: setusb
  Date: 2021/4/21
  Time: 16:57
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="../../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<script src="../../../resources/js/jquery-3.6.0.min.js"></script>
<script src="../../../resources/layui/layui.js"></script>

<!-- jquery ui 的导入 -->
<link href="../../../resources/jqui/jquery-ui.css" rel="stylesheet">
<script src="../../../resources/jqui/external/jquery/jquery.js"></script>
<script src="../../../resources/jqui/jquery-ui.js"></script>

<html>
<head>
    <title>个人博客 - 文章浏览</title>
</head>
<body>
<div class="gradient-pattern"></div>
<div class="div_1" id="d1">
    <h1 style="padding: 10px 0 5px 0">${article.articleTitle}</h1>
    <p style="border-radius: 8px;padding: 3px;background-color: #8b8383;zoom: 1;display: initial;position: absolute;left: 50%;transform: translate(-50%)">
        <a style="color: #ffffff;">作者昵称: <span>${user_s}</span>
            <span style="margin-left: 30px"></span>
            作者: <span>${user_m}</span>
            <span style="margin-left: 30px"></span>
            发布时间: <span>${dateTime}</span>
        </a>
    </p>
    <div class="div_2">
        ${article.articleContent}
    </div>

    <%--    <div class="div_4">
            <p style="padding-top: 10px;position:relative;"><a style="color: black;margin: 0 5px">程志豪</a>[<span>czh</span>] <a id="delete_pl" style="position: absolute;right: 5px;cursor: pointer">删除</a></p>
            <hr />
            <p><a style="margin: 0 5px;color: black">我觉得这个非常不错！这个文章写的太棒了吧！！！</a></p>
        </div>--%>
    <ul id="czhnb">
        <c:forEach items="${critique}" var="items">
            <li class="div_4" id="ast${items.commentId}">
                <p style="padding-top: 10px;position:relative;"><a
                        style="color: black;margin: 0 5px">${items.nickName}</a>[<span>${items.userName}</span>]
                    <c:if test="${items.uuidUser == currentUserId}">
                        <a id="delete_pl" style="position: absolute;right: 5px;cursor: pointer" onclick="pageDelete(${items.commentId})">删除</a>
                    </c:if>
                </p>
                <hr/>
                <p><a style="margin: 0 5px;color: black">${items.critiqueContent}</a></p>
            </li>
        </c:forEach>
    </ul>

</div>

<div class="wbys">
    <textarea id="content" placeholder="文明发言，限制字数30字以内，按下回车提交！"></textarea>
</div>

<div class="div_3">
    <button id="butslike" class="layui-btn layui-btn-warm"
            onclick="like(${article.articleUuid})">点赞数: ${article.articlePoints}</button>
    <button class="layui-btn layui-btn-normal" onclick="back()">返回主页</button>
</div>

<%@include file="../index/footer.jsp" %>
</body>
<script>

    function pageDeletes() {
        location.reload();
    }

    function pageDelete(page) {
        $.ajax({
            async: false,
            type: "POST",
            url: "/pageDelete",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "page": page,
            },
            dataType: "json",
            success: function (response) {
                if (response['as']) {
                    let title = "ast" + page;
/*                    console.log($('#'+title+'').html());*/
                    $('#' + title + '').css({display: 'none'})
                }
            }
        })
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

        $("#czhnb").sortable({
            axis: "y",
            containment: "#d1",
            scroll: false
        });
        $("#czhnb").disableSelection();

        $(document).keyup(function (event) {
            if (event.keyCode === 13) {
                if ($('#content').val() !== '') {
                    commentCli();
                }
            }
        });

    });

    function commentCli() {
        if ($('#content').val().length <= 30) {
            $.ajax({
                async: false,
                type: "POST",
                url: "/submitComments",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    "content": $('#content').val(),
                    "uuidArticle": ${article.articleUuid},
                    "uuidUser": ${currentUserId}
                },
                dataType: "json",
                success: function (response) {
                    /*console.log(response['a']);*/
                    if (response['a']) {
                        $('#czhnb').append("<li class='div_4'>" +
                            "<p style='padding-top: 10px;position:relative;'><a style='color: black;margin: 0 5px'>" +
                            "${userinfos.nickname}" +
                            " [<span>${userinfos.username}</span>]" +
                            "<a id='delete_pl' style='position: absolute;right: 5px;cursor: pointer' onclick='pageDeletes()'>删除</a>" +
                            "</a></p>" +
                            "<hr />" +
                            "<p><a style='margin: 0 5px;color: black'>" + $('#content').val() + "</a></p>" +
                            "</li>")
                        $('#content').val("");
                    }
                }
            });
        }
    }

    function back() {
        window.location.href = "/index";
    }

    function like(uuid) {
        $.ajax({
            type: "POST",
            url: "/likePlusOne",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "uuid": uuid
            },
            dataType: "json",
            success: function (response) {
                $('#butslike').text("点赞数: " + response['flag']);
            },
            error: function () {
                alert("数据获取失败")
            }
        })
    }

</script>
<style>

    #delete_pl:hover {
        color: red;
    }

    #content {
        margin: 10px 0;
        width: 960px;
        height: 100px;
        resize: none;
        border: 1px solid #c2c2c2;
        font-weight: bold;
        border-radius: 6px;
        font-size: 20px;
    }

    .wbys {
        text-align: center;
        width: 1080px;
        height: 120px;
        box-shadow: 0 0 10px #c2c2c2;
        border-bottom-left-radius: 24px;
        border-bottom-right-radius: 24px;
        background-color: white;
        margin: 0 auto 20px;
    }

    .div_4 {
        width: 975px;
        height: 80px;
        background-color: #5FB878;
        border-radius: 8px;
        margin: 8px auto;
    }

    img {
        border-radius: 8px;
        border: 2px solid goldenrod;
    }

    .div_1 {
        width: 1080px;
        min-height: 600px;
        margin: 15px auto;
        padding-bottom: 40px;
        box-shadow: 0 0 10px gray;
        position: relative;
        background-color: white;
    }

    .div_1 h1 {
        text-align: center;
    }

    .div_2 {
        padding: 15px;
        width: 960px;
        margin: 15px auto 30px auto;
        border-radius: 8px;
        /*min-height: 200px;*/
        zoom: 1;
        background-color: #eeeeee;
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

    .div_3 {
        position: absolute;
        margin-bottom: 10px;
        left: 50%;
        transform: translate(-50%);
    }
</style>
</html>
