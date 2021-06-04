<%--
  User: setusb
  Date: 2021/4/23
  Time: 17:05
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="../../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<script src="../../../resources/js/jquery-3.6.0.min.js"></script>
<script src="../../../resources/layui/layui.js"></script>
<html>
<head>
    <title>个人博客 - 编辑文章</title>
</head>
<body>
<ul class="ul_point">
    <span></span>
</ul>
<div class="update1">
    <p style="margin:20px 0 20px 30px">
        <span style="margin-right: 30px">文章标题: </span><input style="width: 200px;display: inline-block"
                                                             id="article_titles" value="${article.articleTitle}"
                                                             type="text"
                                                             placeholder="请输入标题" class="layui-input">
    </p>

    <p style="margin:20px 0 20px 30px;position:absolute;right: 30px;top: 0;display: inline-block">
        <span style="margin-right: 30px">文章简介: </span><input style="width: 200px;display: inline-block"
                                                             id="article_targets" value="${article.articleTarget}"
                                                             type="text"
                                                             placeholder="请输入简介" class="layui-input">
    </p>

    <textarea class="layui-textarea layui-hide" name="articleContent" lay-verify="content" id="contents">
        ${article.articleContent}
    </textarea>
    <div class="btns1">
        <button style="width: 200px" id="article_posts" <%--onclick="articlepost()"--%> class="layui-btn  layui-btn-warm"
                type="button">修改
        </button>
        <button style="width: 200px" id="article_back" onclick="article_back()" class="layui-btn"
                type="button">返回
        </button>
    </div>
</div>
<div class="gradient-pattern"></div>
</body>
<style>
    .update1 {
        width: 1080px;
        margin: 10px auto;
        box-shadow: 0 0 10px gray;
        padding: 10px;
        position: relative;
        background-color: white;
        height: 600px;
    }

    .btns1 {
        position: absolute;
        bottom: 10px;
        left: 50%;
        transform: translate(-50%);
    }

    .ul_point {
        z-index: 9999;
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

    .ul_point span {
        line-height: 50px;
        position: absolute;
        left: 50%;
        transform: translate(-50%);
    }
</style>
<script>

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
    });

    function article_back() {
        window.location.href = "/default/userinfo";
    }
    layui.use('layedit', function () {
        var layedit = layui.layedit;
        layedit.build('contents');

        var indexs = layedit.build('contents', {
            tool: [
                'strong' //加粗
                , 'italic' //斜体
                , 'underline' //下划线
                , 'del' //删除线
                , '|' //分割线
                , 'left' //左对齐
                , 'center' //居中对齐
                , 'right' //右对齐
                , 'link' //超链接
                , 'unlink' //清除链接
                , 'code' //代码
            ],
            height: 380
        });

        $('#article_posts').click(function () {

                if ($('#article_title').val() === '') {
                    $('.ul_point>span').text("请补全标题");
                    $('.ul_point').css({
                        display: "block"
                    });
                    setTimeout(function () {
                        $('.ul_point').css({
                            display: "none"
                        })
                    }, 1000);
                } else {
                    if ($('#article_target').val() === '') {
                        $('.ul_point>span').text("请补全简介");
                        $('.ul_point').css({
                            display: "block"
                        });
                        setTimeout(function () {
                            $('.ul_point').css({
                                display: "none"
                            })
                        }, 1000);
                    } else {
                        if (layedit.getContent(indexs) === '') {
                            $('.ul_point>span').text("请补全内容");
                            $('.ul_point').css({
                                display: "block"
                            });
                            setTimeout(function () {
                                $('.ul_point').css({
                                    display: "none"
                                })
                            }, 1000);
                        } else {
                            $.ajax({
                                async: false,
                                type: "POST",
                                url: "/default/updateArticles/${article.articleUuid}",
                                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                                dataType: "json",
                                data: {
                                    "articleTitle": $('#article_titles').val(),
                                    "articleTarget": $('#article_targets').val(),
                                    "content": layedit.getContent(indexs)
                                },
                                success: function (response) {
                                    if (response['flag']) {
                                        $('.ul_point>span').text("修改成功，即将跳转");
                                        $('.ul_point').css({
                                            display: "block"
                                        });
                                        setTimeout(function () {
                                            $('.ul_point').css({
                                                display: "none"
                                            })
                                        }, 1000);
                                        setTimeout(function () {
                                            window.location.href = "/default/userinfo"
                                        }, 2000);
                                    } else {
                                        $('.ul_point>span').text("修改失败");
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
                            });
                        }
                    }
                }
            }
        );
    });
</script>
</html>
