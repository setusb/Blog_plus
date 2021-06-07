<%--
  User: setusb
  Date: 2021/6/1
  Time: 18:07
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="../../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<script src="../../../resources/js/jquery-3.6.0.min.js"></script>
<script src="../../../resources/layui/layui.js"></script>

<html>
<head>
    <title>个人博客 - 后台主页 - 评论管理</title>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-bg-black" style="font-size: 24px">个人博客后台</div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/index">博客主页</a></li>
            <li class="layui-nav-item"><a href="/default/userinfo">个人中心</a></li>
            <li class="layui-nav-item"><a href="/default/aqgl">安全管理</a></li>
            <li class="layui-nav-item">
                <a href="javascript:">更多</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:location.reload();">刷新数据</a></dd>
                    <dd><a href="javascript:setTimeout(function (){
                    alert('缓存清理完成');
                    location.reload();
                    },2000)">清理缓存</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <a href="javascript:">
                    <img src="../../../resources/images/ava/ava.png" class="layui-nav-img" alt="头像">
                    ${username}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="/backstageexit">退出后台</a></dd>
                    <dd><a href="/backstagelogout">注销所有</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item">
                    <a class="" href="javascript:">总体概览</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/backstageindex">控制台</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:">数据操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/backstageindex/usermanagement">用户管理</a></dd>
                        <dd><a href="/backstageindex/articlemanagement">文章管理</a></dd>
                        <dd><a href="/backstageindex/critiquemanagement" style="color: #978502">评论管理</a></dd>
                        <dd><a href="/backstageindex/messagemanagement">留言管理</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body" style="background-color: #F2F2F2;">
        <div style="width: 90%;padding:0 40px;top: 32%;position: absolute;left: 50%;transform: translate(-50%,-32%)">
            <table class="layui-hide" id="test" lay-filter="test"></table>
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                    <button class="layui-btn layui-btn-sm" lay-event="addCheckData">批量删除</button>
                    <button class="layui-btn layui-btn-sm" lay-event="refresh">刷新</button>
                </div>
            </script>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>
    </div>

    <div class="layui-footer" style="text-align: right">
        2021 - 2021 个人博客
    </div>
</div>
<script src="../../../resources/quill/quill.js" charset="UTF-8"></script>
<link href="../../../resources/quill/quill.snow.css" rel="stylesheet">
<script>
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#test'
            , url: '/backstageindex/critiquelist'
            , toolbar: '#toolbarDemo'
            , height: '558px'
            , cols: [[
                {type: 'checkbox', width: 60, unresize: true}
                , {field: 'uuidCritique', width: 90, title: '评论ID', sort: true, unresize: true}
                , {field: 'critiqueArticleTitle', width: 160, title: '文章(标题)', unresize: true}
                , {field: 'critiqueUserName', width: 120, title: '评论用户', unresize: true, sort: true}
                , {field: 'contentCritique', Width: 220, title: '评论内容', unresize: true}
                , {field: 'critiqueDateString', width: 140, title: '发布时间', unresize: true, sort: true}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120, unresize: true}
            ]]
            , page: false,
        });

        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除' + obj.data.critiqueUserName + '的评论吗'
                    , function (index) {
                        layer.close(index);
                        critiqueDeleteAll(obj.data.uuidCritique);
                        obj.del();
                    });
            } else if (obj.event === 'edit') {
                var setb = layer.open({
                    type: 1,
                    anim: 0,
                    resize: false,
                    title: false,
                    closeBtn: 2,
                    shadeClose: true,
                    skin: '',
                    content: "<div style='width: 1080px;height: 290px;background-color: white;position: relative;'>" +
                        "<div class='layui-form-item' style='margin-top: 15px;display: inline-block'>" +
                        "<label class='layui-form-label'>评论文章</label>" +
                        "<div class='layui-input-block'>" +
                        "<input style='width: 320px' value='" + obj.data.critiqueArticleTitle + "' type='text' name='title' required disabled  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input layui-btn-disabled'>" +
                        "</div>" +
                        "</div>" +
                        "<div class='layui-form-item' style='margin-top: 15px;float: right;margin-right: 40px'>" +
                        "<label class='layui-form-label'>评论作者</label>" +
                        "<div class='layui-input-block'>" +
                        "<input style='width: 360px' value='" + obj.data.critiqueUserName + "' type='text' name='title' required disabled  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input layui-btn-disabled'>" +
                        "</div>" +
                        "</div>" +
                        "<div style='width: 100%;height: 140px;border-top:1px solid #eee;border-bottom:1px solid #eee'>" +
                        "<textarea id='wbyConfig' placeholder='请输入内容' class='layui-textarea' style='width: 100%;height: auto;resize: none;outline: none;border-radius: 0;border: none'>" +
                        "" + obj.data.contentCritique + "" +
                        "</textarea>" +
                        "</div>" +
                        "<button id='modifywz' style='width: 160px;height: 50px;position: absolute;left: 50%;transform: translate(-50%);bottom: 5%;letter-spacing: 8px;font-size: 20px;border-radius: 30px' class='layui-btn'>" +
                        "修改" +
                        "</button>" +
                        "</div>"
                });

                $('#modifywz').click(function () {
                    var nr = $('#wbyConfig').val();
                    var copyNr = obj.data.contentCritique;
                    var cuuid = obj.data.uuidCritique;

                    if (copyNr === nr) {
                        layer.close(setb);
                        layer.alert("你并没有修改任何内容");
                    } else {
                        if (nr !== null && nr.length <=30) {
                            $.ajax({
                                type: "POST",
                                url: "/backstageindex/critiquemodification",
                                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                                data: {
                                    "uuid": cuuid,
                                    "content": nr
                                },
                                dataType: "json",
                                success: function (response) {
                                    if (response['a']) {
                                        layer.close(setb);
                                        table.reload('test');
                                    } else {
                                        layer.close(setb);
                                        layer.alert("数据库错误，请查看后台报错！")
                                    }
                                }
                            });
                        } else {
                            layer.alert("评论内容不能为空，且长度不能超过30位");
                        }
                    }
                });
            }
        });

        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'addCheckData':
                    var data = checkStatus.data;
                    if (data.length === 0) {
                        layer.alert("请选中评论，然后在点击" +
                            "<br>" +
                            "选中的评论点击后将删除");
                        break;
                    } else if (data.length > 0) {
                        $.each(data, function (index, obj) {
                            critiqueDeleteAll(obj.uuidCritique);
                        });
                        table.reload('test');
                        break;
                    }
                    break;
                case 'refresh':
                    table.reload('test');
                    break;
            }
        });
    });

    function critiqueDeleteAll(uuid) {
        $.ajax({
            type: "POST",
            url: "/backstageindex/critiqueDeleteAll",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "uuid": uuid,
            },
            dataType: "json",
            success: function (response) {
                if (!response['a']) {
                    layer.alert("删除未知错误，请查看后台报错！")
                }
            }
        });
    }
</script>
</body>
<style>
    .body_1 {
        box-shadow: 0 0 2px gray;
        width: 200px;
        height: 100px;
        border: 1px solid gray;
        margin: 15px;
    }

    .layui-nav .layui-this:after, .layui-nav-bar, .layui-nav-tree .layui-nav-itemed:after {
        background-color: transparent;
    }

    .div1 {
        width: 80%;
        float: right;
    }

    .ul_1 {
        background-color: #393D49;
    }

    * {
        margin: 0;
        padding: 0;
    }

    .layui-nav {
        border-radius: 0;
    }

    .laytable-cell-checkbox, .laytable-cell-numbers, .laytable-cell-radio, .laytable-cell-space {
        padding: 8px;
    }
</style>
</html>
