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
    <title>个人博客 - 后台主页 - 用户管理</title>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-bg-black" style="font-size: 24px">个人博客后台</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <%--            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                            <i class="layui-icon layui-icon-spread-left"></i>
                        </li>--%>

            <li class="layui-nav-item"><a href="/index">博客主页</a></li>
            <li class="layui-nav-item"><a href="/pageArticles/0">个人中心</a></li>
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
                    <img src="../../../resources/images/ava/ava.png" class="layui-nav-img">
                    ${username}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="/backstageexit">退出后台</a></dd>
                    <dd><a href="/backstagelogout">注销所有</a></dd>
                </dl>
            </li>
            <%--            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                            <a href="javascript:;">
                                <i class="layui-icon layui-icon-more-vertical"></i>
                            </a>
                        </li>--%>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
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
                        <dd><a href="/backstageindex/usermanagement" style="color: #978502">用户管理</a></dd>
                        <dd><a href="javascript:">文章管理</a></dd>
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
        <!-- 内容主体区域 -->
        <div style="width: 90%;padding:0 40px;top: 32%;position: absolute;left: 50%;transform: translate(-50%,-32%)">
            <table class="layui-hide" id="test" lay-filter="test"></table>
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                    <button class="layui-btn layui-btn-sm" lay-event="addCheckData">添加</button>
                    <button class="layui-btn layui-btn-sm" lay-event="getCheckData">删除</button>
                    <button class="layui-btn layui-btn-sm" lay-event="refresh">刷新</button>
                </div>
            </script>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>

        <%--        <div>
                    <div class="layui-panel"
                         style="width: 920px;margin: 25px auto 0;height: 100px;border-radius: 5px">
                        <div style="padding: 30px;"></div>
                    </div>
                </div>--%>
    </div>

    <div class="layui-footer" style="text-align: right">
        <!-- 底部固定区域 -->
        2021 - 2021 个人博客
    </div>
</div>
<script>


    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , $ = layui.$;
    });

    layui.use('table', function () {
        var table = layui.table;

        /*        setInterval(function () {
                    table.render({
                        elem: '#test'
                        , url: '/backstageindex/userlist'
                        , toolbar: '#toolbarDemo'
                        , height: '404px'
                        ,unresize: true
                        , cols: [[
                            {type: 'checkbox', width: 60},
                            {field: 'uuid', width: 80, title: 'uuid', sort: true}
                            , {field: 'username', width: 120, title: '账号'}
                            , {field: 'nickname', width: 120, title: '昵称'}
                            , {field: 'password', width: 120, title: '密码'}
                            , {field: 'sex', title: '性别', width: 80}
                            , {field: 'userinfo', Width: 180, title: '用户信息'}
                            , {field: 'authoritystring', width: 80, title: '权限'}
                            , {field: 'verification', width: 100, title: '贡献点', sort: true}
                            , {field: 'datestring', width: 110, title: '注册日期'}
                            , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120}
                        ]]
                        , page: false,
                    });
                }, 1000);*/

        table.render({
            elem: '#test'
            , url: '/backstageindex/userlist'
            , toolbar: '#toolbarDemo'
            , height: '404px'
            , cols: [[
                {type: 'checkbox', width: 60, unresize: true},
                {field: 'uuid', width: 80, title: 'uuid', sort: true, unresize: true}
                , {field: 'username', width: 80, title: '账号', unresize: true}
                , {field: 'nickname', width: 80, title: '昵称', unresize: true}
                , {field: 'password', width: 80, title: '密码', unresize: true}
                , {field: 'sex', title: '性别', width: 80, unresize: true}
                , {field: 'userinfo', Width: 120, title: '用户信息', unresize: true}
                , {field: 'authoritystring', width: 80, title: '权限', unresize: true}
                , {field: 'verification', width: 90, title: '贡献点', sort: true, unresize: true}
                , {field: 'datestring', width: 110, title: '注册日期', unresize: true}
                , {field: 'articlecount', width: 60, title: '文章', unresize: true}
                , {field: 'critiquecount', width: 60, title: '评论', unresize: true}
                , {field: 'messagecount', width: 60, title: '留言', unresize: true}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120, unresize: true}
            ]]
            , page: false,
        });

        table.on('tool(test)', function (obj) {
            var data = obj.data;
            //console.log(obj)
            if (obj.event === 'del') {
                layer.confirm('真的删除' + obj.data.username + '这个用户吗' +
                    '<br/>' +
                    '该用户的文章、评论、留言也将一并删除！', function (index) {
                    layer.close(index);
                    deleteUser(obj.data.uuid, obj);
                });
            } else if (obj.event === 'edit') {
                var setb = layer.open({
                    type: 1,
                    anim: 2,
                    /*                    maxmin: true,*/
                    resize: false,
                    title: false,
                    closeBtn: 2,
                    shadeClose: true,
                    skin: '',
                    content: "<div style='width: 960px;height: 420px;background-color: white;position: relative;'>" +
                        "<form style='width: 510px;position: absolute;top: 10%;left: 45%;transform: translate(-45%,-10%)''>" +
                        "<label class='layui-form-label' style='margin-top: 10px'>账号:</label>" +
                        "<div class='layui-input-block' style='margin-top: 10px'>" +
                        "<input id='newusername' ' style='width: 400px;color: black' type='text' name='title' value='" + obj.data.username + "' required  lay-verify='required' disabled autocomplete='off' class='layui-input layui-btn layui-btn-radius layui-btn-disabled'>" +
                        "</div>" +
                        "<label class='layui-form-label' style='margin-top: 10px'>昵称:</label>" +
                        "<div class='layui-input-block' style='margin-top: 10px'>" +
                        "<input id='newusernick' style='width: 400px' type='text' name='title' value='" + obj.data.nickname + "' required  lay-verify='required' placeholder='请输入新昵称' autocomplete='off' class='layui-input'>" +
                        "</div>" +
                        "<label class='layui-form-label' style='margin-top: 10px'>密码:</label>" +
                        "<div class='layui-input-block' style='margin-top: 10px'>" +
                        "<input id='newpwd' style='width: 400px' type='text' name='title' value='" + obj.data.password + "' required  lay-verify='required' placeholder='请输入新密码' autocomplete='off' class='layui-input'>" +
                        "</div>" +
                        "<label class='layui-form-label' style='margin-top: 10px'>贡献:</label>" +
                        "<div class='layui-input-block' style='margin-top: 10px'>" +
                        "<input id='newgx' style='width: 400px' type='text' name='title' value='" + obj.data.verification + "' required  lay-verify='required' placeholder='请输入贡献点' autocomplete='off' class='layui-input'>" +
                        "</div>" +
                        "<label class='layui-form-label' style='margin-top: 10px'>信息:</label>" +
                        "<div class='layui-input-block' style='margin-top: 10px'>" +
                        "<textarea id='newinfo' style='resize: none;width: 400px' class='layui-textarea' placeholder='请输入新信息'>" + obj.data.userinfo + "</textarea>" +
                        "</div>" +
                        "<div class='layui-form-item'>" +
                        "<label class='layui-form-label' style='margin-top: 10px'>性别:</label>" +
                        "<div class='layui-input-inline' style='margin-top: 10px'>" +
                        "<select id='newsex' style='margin-top: 10px;border: none' name='sex' lay-verify='required'>" +
                        "<option value='" + obj.data.sex + "'>" + obj.data.sex + "</option>" +
                        "<option value='男'>男</option>" +
                        "<option value='女'>女</option>" +
                        "</select>" +
                        "</div>" +
                        "</div>" +
                        "<div style='position: absolute;left: 50%;transform: translate(-50%)'>" +
                        "<button id='modify' type='button' class='layui-btn'>修改</button>" +
                        "<button type='reset' class='layui-btn'>重置</button>" +
                        "</div>" +
                        "</form>" +
                        "</div>"
                });
                $('#modify').click(function () {
                    let uuid = obj.data.uuid;
                    let username1 = $('#newusername').val();
                    let usernick1 = $('#newusernick').val();
                    let pwd1 = $('#newpwd').val();
                    let gx1 = $('#newgx').val();
                    let userinfo1 = $('#newinfo').val();
                    let usersex1 = $('#newsex').val();

                    if (username1 === "") {
                        layer.alert("账号不能为空");
                    } else if (username1.length < 3 || username1.length > 6) {
                        layer.alert("账号长度在3-6区间");
                    } else if (usernick1 === '') {
                        layer.alert("昵称长度不能为空");
                    } else if (usernick1.length > 12) {
                        layer.alert("昵称长度不能超过12");
                    } else if (pwd1 === '') {
                        layer.alert("密码不能为空");
                    } else if (pwd1.length < 6) {
                        layer.alert("密码不能小于6位");
                    } else if (gx1 === '') {
                        layer.alert("贡献不能为空");
                    } else if (userinfo1 === '') {
                        layer.alert("用户信息不能为空");
                    } else {
                        $.ajax({
                            type: "POST",
                            url: "/backstageindex/usermodification",
                            contentType: "application/x-www-form-urlencoded; charset=utf-8",
                            data: {
                                "uuid": uuid,
                                "username": username1,
                                "usernick": usernick1,
                                "pwd": pwd1,
                                "gx": gx1,
                                "userinfo": userinfo1,
                                "usersex": usersex1
                            },
                            dataType: "json",
                            success: function (response) {
                                if (response['a']) {
                                    layer.confirm('修改成功，是否重载表格数据', function (index) {
                                        layer.close(index);
                                        layer.close(setb);
                                        table.reload('test');
                                    });
                                } else {
                                    layer.alert("未修改！")
                                }
                                if (response['b']) {
                                    layer.alert("异常，请查看后台！")
                                }
                            }, error: function () {
                                layer.alert("异常！");
                            }
                        });
                    }
                });
            }
        });

        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
            switch (obj.event) {
                case 'getCheckData':
                    var data = checkStatus.data;  //获取选中行数据
                    if (data.length === 0) {
                        layer.alert("请选择数据");
                        break;
                    } else if (data.length > 0) {
                        $.each(data, function (index, obj) {
                            //多删除操作
                            deleteMore(obj.uuid, index);
                        });
                        break;
                    }
                case 'addCheckData':
                    var indexs = layer.open({
                        type: 1,
                        anim: 2,
                        resize: false,
                        title: false,
                        closeBtn: 2,
                        shadeClose: true,
                        id: 'adduser',
                        skin: '',
                        content: "<div style='width: 960px;height: 420px;background-color: white;position: relative;'>" +
                            "<form style='width: 510px;position: absolute;top: 10%;left: 45%;transform: translate(-45%,-10%)''>" +
                            "<label class='layui-form-label' style='margin-top: 10px'>账号:</label>" +
                            "<div class='layui-input-block' style='margin-top: 10px'>" +
                            "<input id='zh1' style='width: 400px;color: black' type='text' name='title' value='' placeholder='请输入账号'  lay-verify='required' autocomplete='off' class='layui-input'>" +
                            "</div>" +
                            "<label class='layui-form-label' style='margin-top: 10px'>昵称:</label>" +
                            "<div class='layui-input-block' style='margin-top: 10px'>" +
                            "<input id='zh2' style='width: 400px' type='text' name='title' value='' required  lay-verify='required' placeholder='请输入昵称' autocomplete='off' class='layui-input'>" +
                            "</div>" +
                            "<label class='layui-form-label' style='margin-top: 10px'>密码:</label>" +
                            "<div class='layui-input-block' style='margin-top: 10px'>" +
                            "<input id='zh3' style='width: 400px' type='text' name='title' value='' required  lay-verify='required' placeholder='请输入密码' autocomplete='off' class='layui-input'>" +
                            "</div>" +
                            "<label class='layui-form-label' style='margin-top: 10px'>贡献:</label>" +
                            "<div class='layui-input-block' style='margin-top: 10px'>" +
                            "<input id='zh4' style='width: 400px' type='text' name='title' value='' required  lay-verify='required' placeholder='请输入贡献点' autocomplete='off' class='layui-input'>" +
                            "</div>" +
                            "<label class='layui-form-label' style='margin-top: 10px'>信息:</label>" +
                            "<div class='layui-input-block' style='margin-top: 10px'>" +
                            "<textarea id='zh5' style='resize: none;width: 400px' class='layui-textarea' placeholder='请输入信息'></textarea>" +
                            "</div>" +
                            "<div class='layui-form-item'>" +
                            "<label class='layui-form-label' style='margin-top: 10px'>性别:</label>" +
                            "<div class='layui-input-inline' style='margin-top: 10px'>" +
                            "<select id='zh6' style='margin-top: 10px;border: none' name='sex' lay-verify='required'>" +
                            "<option value='男'>男</option>" +
                            "<option value='女'>女</option>" +
                            "</select>" +
                            "</div>" +
                            "</div>" +
                            "<div style='position: absolute;left: 50%;transform: translate(-50%)'>" +
                            "<button id='addUser' type='button' class='layui-btn'>添加</button>" +
                            "<button type='reset' class='layui-btn'>重置</button>" +
                            "</div>" +
                            "</form>" +
                            "</div>"
                    });
                    $('#addUser').click(function () {
                        var username = $('#zh1').val();
                        var usernick = $('#zh2').val();
                        var pwd = $('#zh3').val();
                        var gx = $('#zh4').val();
                        var userinfo = $('#zh5').val();
                        var usersex = $('#zh6').val();

                        if (username === "") {
                            layer.alert("账号不能为空");
                        } else if (username.length < 3 || username.length > 6) {
                            layer.alert("账号长度在3-6区间");
                        } else if (usernick === '') {
                            layer.alert("昵称长度不能为空");
                        } else if (usernick.length > 12) {
                            layer.alert("昵称长度不能超过12");
                        } else if (pwd === '') {
                            layer.alert("密码不能为空");
                        } else if (pwd.length < 6) {
                            layer.alert("密码不能小于6位");
                        } else if (gx === '') {
                            layer.alert("贡献不能为空");
                        } else if (userinfo === '') {
                            layer.alert("用户信息不能为空");
                        } else {
                            $.ajax({
                                type: "POST",
                                url: "/backstageindex/useradd",
                                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                                data: {
                                    "username": username,
                                    "usernick": usernick,
                                    "pwd": pwd,
                                    "gx": gx,
                                    "userinfo": userinfo,
                                    "usersex": usersex
                                },
                                dataType: "json",
                                success: function (response) {
                                    if (response['a']) {
                                        layer.confirm('添加成功，是否重载表格数据', function (index) {
                                            layer.close(index);
                                            layer.close(indexs);
                                            /*location.reload();*/
                                            table.reload('test');
                                        });
                                    } else {
                                        $('#zh1').val("");
                                        layer.alert("账号重复，请修改账号！")
                                    }
                                }, error: function () {
                                    $('#zh4').val("");
                                    layer.alert("贡献不能设置非数字以外的值！");
                                }
                            });
                        }
                    });
                    break;
                case 'refresh':
                    table.reload('test');
            }
        });
    });

    function deleteMore(uuid, obj) {
        $.ajax({
            type: "POST",
            url: "/backstageuserdeletemulti",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "uuid": uuid,
            },
            dataType: "json",
            success: function (response) {

                if (response['c']) {
                    layer.alert("管理员账号无法直接删除")
                    layer.close(obj);
                }
                if (response['a']) {
                    layer.confirm("删除成功,是否重载表格数据！", function () {
                        layer.close(obj);
                        table.reload('test');
                    });
                } else {
                    if (response['info'] != null) {
                        layer.alert(response['info'] + '用户无法删除！');
                        layer.close(obj);
                    }
                    if (response['yc']) {
                        layer.alert('未知错误，请查看报错！');
                        layer.close(obj);
                    }
                }
            }
        });
    }

    function deleteUser(uuid, obj) {
        $.ajax({
            type: "POST",
            url: "/backstageindex/userdelete",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "uuid": uuid,
            },
            dataType: "json",
            success: function (response) {

                if (response['b']) {
                    layer.alert("管理员账号无法直接删除");
                } else {
                    if (response['a']) {
                        obj.del();
                        layer.confirm('删除成功，是否重载表格数据', function (index) {
                            layer.close(index);
                            table.reload('test');
                        });
                    } else {
                        layer.alert("删除失败，请勿重复删除！")
                    }
                }
            }
        });
    }
</script>
</body>
<style>
    /*    .asb {
            z-index: 9999;
            width: 800px;
            height: 800px;
            background-color: red;
            !*        position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%)*!
            position: relative;
            top: 50%;
            left: 50%;
            margin-top: 10px;
            transform: translate(-50%, -50%)
        }*/

    .body_1 {
        box-shadow: 0 0 2px gray;
        width: 200px;
        height: 100px;
        border: 1px solid gray;
        margin: 15px;
    }

    /*    .layui-nav-child {
            top: 45px;
        }*/

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

    /*使用方法渲染的方式生成数据表格，添加了radio，但发现radio位置不居中
        解决方案！
    */
    /*        .layui-table-cell .layui-form-checkbox[lay-skin="radio"]{
                top: 50%;
                transform: translateY(-50%);
            }*/

    /*    .laytable-cell-checkbox, .laytable-cell-numbers, .laytable-cell-radio, .laytable-cell-space {
            padding: 15px;
        }*/
    .laytable-cell-checkbox, .laytable-cell-numbers, .laytable-cell-radio, .laytable-cell-space {
        padding: 8px;
    }
</style>
</html>
