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
    <title>个人博客 - 后台主页 - 文章管理</title>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-bg-black" style="font-size: 24px">个人博客后台</div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/index">博客主页</a></li>
            <li class="layui-nav-item"><a href="/default/userinfo">个人中心</a></li>
            <li class="layui-nav-item"><a href="">安全管理</a></li>
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
                        <dd><a href="/backstageindex/articlemanagement" style="color: #978502">文章管理</a></dd>
                        <dd><a href="javascript:">评论管理</a></dd>
                        <dd><a href="javascript:">留言管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:">开关操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:">全部开关</a></dd>
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
                    <button class="layui-btn layui-btn-sm" lay-event="addCheckData">添加文章</button>
                    <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="plsp">批量审批<span
                            style="color: darkred;font-weight: bold">（通过）</span></button>
                    <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="plsps">批量审批<span
                            style="color: purple;font-weight: bold">（未批）</span></button>
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

    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , $ = layui.$;
    });

    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#test'
            , url: '/backstageindex/articlelist'
            , toolbar: '#toolbarDemo'
            , height: '558px'
            , cols: [[
                {type: 'checkbox', width: 60, unresize: true}
                , {field: 'articleUuid', width: 70, title: 'ID', sort: true, unresize: true}
                , {field: 'articleusername', width: 100, title: '发布者', unresize: true}
                , {field: 'articleTitle', width: 140, title: '标题', unresize: true}
                , {field: 'articleTarget', width: 140, title: '简介', unresize: true}
                , {field: 'articleContent', Width: 220, title: '内容', unresize: true}
                , {field: 'check', title: '审核', width: 85, unresize: true, sort: true}
                , {field: 'dateString', width: 110, title: '发布时间', unresize: true, sort: true}
                , {field: 'critiqueCount', width: 80, title: '评论', unresize: true, sort: true}
                , {field: 'articlePoints', width: 90, title: '点赞', sort: true, unresize: true}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120, unresize: true}
            ]]
            , page: false,
        });

        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除' + obj.data.articleusername + '的文章吗' +
                    '<br/>' +
                    '该文章下的评论点赞都将一并删除！', function (index) {
                    layer.close(index);
                    deleteUser(obj.data.articleUuid, obj);
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
                    content: "<div style='width: 1080px;height: 500px;background-color: white;position: relative;'>" +
                        "<div class='layui-form-item' style='margin-top: 15px;display: inline-block'>" +
                        "<label class='layui-form-label'>文章标题</label>" +
                        "<div class='layui-input-block'>" +
                        "<input id='wztitle' style='width: 320px' value='" + obj.data.articleTitle + "' type='text' name='title' required  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input'>" +
                        "</div>" +
                        "</div>" +
                        "<div class='layui-form-item' style='margin-top: 15px;float: right;margin-right: 40px'>" +
                        "<label class='layui-form-label'>文章简介</label>" +
                        "<div class='layui-input-block'>" +
                        "<input id='wztarget' style='width: 360px' value='" + obj.data.articleTarget + "' type='text' name='title' required  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input'>" +
                        "</div>" +
                        "</div>" +
                        "<div id='editor' style='width: auto;height: 320px;background-color: rgba(168,168,168,0.14)'>" +
                        "" + obj.data.articleContent + "" +
                        "</div>" +
                        "<button id='modifywz' style='width: 160px;height: 50px;letter-spacing: 8px;font-size: 20px;border-radius: 30px;position: absolute;left: 50%;margin-top: 10px;transform: translate(-50%)' class='layui-btn'>修改" +
                        "</button>" +
                        "</div>"
                });

                var toolbarOptions = [
                    ['bold', 'italic', 'underline', 'strike'],
                    ['blockquote', 'code-block'],

                    [{'header': 1}, {'header': 2}],
                    [{'list': 'ordered'}, {'list': 'bullet'}],
                    [{'script': 'sub'}, {'script': 'super'}],
                    [{'indent': '-1'}, {'indent': '+1'}],
                    [{'direction': 'rtl'}],

                    [{'size': ['small', false, 'large', 'huge']}],
                    [{'header': [1, 2, 3, 4, 5, 6, false]}],

                    [{'color': []}, {'background': []}],
                    [{'font': []}],
                    [{'align': []}],

                    ['clean'],
                ];

                var quill = new Quill('#editor', {
                    modules: {
                        toolbar: toolbarOptions
                    },
                    theme: 'snow',
                });

                $('#modifywz').click(function () {
                    let articleuuid = obj.data.articleUuid;
                    var content = quill.container.firstChild.innerHTML;
                    let title = $('#wztitle').val();
                    let target = $('#wztarget').val();

                    if (title.length > 0) {
                        if (target.length > 0) {
                            if (content.length > 0) {
                                $.ajax({
                                    type: "POST",
                                    url: "/backstageindex/articlemodification",
                                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                                    data: {
                                        "uuid": articleuuid,
                                        "title": title,
                                        "target": target,
                                        "content": content
                                    },
                                    dataType: "json",
                                    success: function (response) {
                                        if (response['a']) {
                                            layer.close(setb);
                                            table.reload('test');
                                        }
                                    }
                                });
                            } else {
                                layer.alert("内容不能为空！")
                            }
                        } else {
                            layer.alert("简介不能为空！")
                        }
                    } else {
                        layer.alert("标题不能为空！")
                    }
                });
            }
        });

        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'addCheckData':
                    var indexs = layer.open({
                        type: 1,
                        anim: 0,
                        resize: false,
                        title: false,
                        closeBtn: 2,
                        shadeClose: true,
                        id: 'adduser',
                        skin: '',
                        content: "<div style='width: 1080px;height: 500px;background-color: white;position: relative;'>" +
                            "<div class='layui-form-item' style='margin-top: 15px;display: inline-block'>" +
                            "<label class='layui-form-label'>文章标题</label>" +
                            "<div class='layui-input-block'>" +
                            "<input id='wztitles' style='width: 320px' type='text' name='title' required  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input'>" +
                            "</div>" +
                            "</div>" +
                            "<div class='layui-form-item' style='margin-top: 15px;float: right;margin-right: 40px'>" +
                            "<label class='layui-form-label'>文章简介</label>" +
                            "<div class='layui-input-block'>" +
                            "<input id='wztargets' style='width: 360px' type='text' name='title' required  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input'>" +
                            "</div>" +
                            "</div>" +
                            "<div id='editors' style='width: auto;height: 320px;background-color: rgba(168,168,168,0.14)'>" +
                            "</div>" +
                            "<button id='modifywzs' style='width: 160px;height: 50px;letter-spacing: 8px;font-size: 20px;border-radius: 30px;position: absolute;left: 50%;margin-top: 10px;transform: translate(-50%)' class='layui-btn'>修改" +
                            "</button>" +
                            "</div>"
                    });

                    var toolbarOptions = [
                        ['bold', 'italic', 'underline', 'strike'],
                        ['blockquote', 'code-block'],

                        [{'header': 1}, {'header': 2}],
                        [{'list': 'ordered'}, {'list': 'bullet'}],
                        [{'script': 'sub'}, {'script': 'super'}],
                        [{'indent': '-1'}, {'indent': '+1'}],
                        [{'direction': 'rtl'}],

                        [{'size': ['small', false, 'large', 'huge']}],
                        [{'header': [1, 2, 3, 4, 5, 6, false]}],

                        [{'color': []}, {'background': []}],
                        [{'font': []}],
                        [{'align': []}],

                        ['clean'],
                    ];

                    var quills = new Quill('#editors', {
                        modules: {
                            toolbar: toolbarOptions
                        },
                        theme: 'snow',
                    });

                    $('#modifywzs').click(function () {
                        let ts = $('#wztitles').val();
                        let tas = $('#wztargets').val();
                        let cons = quills.container.firstChild.innerHTML;

                        if (ts.length > 0) {
                            if (tas.length > 0) {
                                if (cons.length > 0) {
                                    $.ajax({
                                        type: "POST",
                                        url: "/backstageindex/articleadd",
                                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                                        data: {
                                            "title": ts,
                                            "target": tas,
                                            "content": cons
                                        },
                                        dataType: "json",
                                        success: function (response) {
                                            if (response['a']) {
                                                layer.close(indexs);
                                                table.reload('table');
                                            } else {
                                                layer.close(indexs);
                                                layer.alert("添加失败！")
                                            }
                                        }
                                    });
                                } else {
                                    layer.alert("内容不能为空！")
                                }
                            } else {
                                layer.alert("简介不能为空！")
                            }
                        } else {
                            layer.alert("标题不能为空！")
                        }
                    });
                    break;
                case 'refresh':
                    table.reload('test');
                    break;
                case 'plsp':
                    var data = checkStatus.data;
                    if (data.length === 0) {
                        layer.alert("请选中文章，然后在点击" +
                            "<br>" +
                            "选中的文章如果是未批的将会通过");
                        break;
                    } else if (data.length > 0) {
                        $.each(data, function (index, obj) {
                            articleReview(obj.articleUuid, 0, table);
                        });
                        break;
                    }
                    break;
                case 'plsps':
                    var data = checkStatus.data;
                    if (data.length === 0) {
                        layer.alert("请选中文章，然后在点击" +
                            "<br>" +
                            "选中的文章如果是通过的将会未批");
                        break;
                    } else if (data.length > 0) {
                        $.each(data, function (index, obj) {
                            articleReview(obj.articleUuid, 1, table);
                        });
                        break;
                    }
                    break;
            }
        });
    });

    function articleReview(uuid, is, obj) {
        $.ajax({
            type: "POST",
            url: "/backstageindex/articlereview",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "uuid": uuid,
                "is": is
            },
            dataType: "json",
            success: function (response) {
                if (response['a']) {
                    obj.reload('test');
                } else {
                    layer.alert("审核未知错误，请查看后台报错！")
                }
            }
        });
    }

    function deleteUser(uuid, obj) {
        $.ajax({
            type: "POST",
            url: "/backstageindex/articledelete",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "uuid": uuid,
            },
            dataType: "json",
            success: function (response) {
                if (response['a']) {
                    obj.del();
                    layer.alert("删除成功！")
                } else {
                    layer.alert("删除失败，请勿重复删除！")
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
