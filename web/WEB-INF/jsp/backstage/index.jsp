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
    <title>个人博客 - 后台主页 - 控制台</title>
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
                    <img src="../../../resources/images/ava/ava.png" class="layui-nav-img">
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
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:">总体概览</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/backstageindex" style="color: #978502">控制台</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:">数据操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="/backstageindex/usermanagement">用户管理</a></dd>
                        <dd><a href="/backstageindex/articlemanagement">文章管理</a></dd>
                        <dd><a href="/backstageindex/critiquemanagement">评论管理</a></dd>
                        <dd><a href="/backstageindex/messagemanagement">留言管理</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body" style="background-color: #F2F2F2;">
        <div style="width: 90%;margin: 0 auto">
            <div class="divasb layui-card" style="width: 50%;height: 200px;margin: 15px 0 15px 15px">
                <div class="layui-card-header">运行监控</div>
                <div class="layui-card-body" style="line-height: 45px">
                    处理器: <span id="cpu_name">${cpuName}</span>
                    <br>
                    服务器内存: <span id="mem_total">${memTao}GB</span>
                    <br>
                    消耗内存: <span id="mem_consume">${memAva}GB</span>
                    <br>
                </div>
            </div>
            <div class="divasb layui-card" style="width: 20%;height: 200px;margin: 15px 0 15px 15px">
                <div class="layui-card-header">用户监控</div>
                <div class="layui-card-body" style="line-height: 35px">
                    注册用户: <span id="registeredUser">${userContAll}人</span>
                    <br>
                    管理员用户: <span id="admin_user">${userContAdmin}人</span>
                    <br>
                    发帖评论用户: <span id="postACommentUser">${userCont1}人</span>
                    <br>
                    仅评论用户: <span id="commentUsersOnly">${userCont0}人</span>
                </div>
            </div>
            <div class="divasb layui-card" style="width: 20%;height: 200px;margin: 15px 0 15px 15px">
                <div class="layui-card-header">文章监控</div>
                <div class="layui-card-body" style="line-height: 45px">
                    总文章: <span id="totalArticles">${articleContAll}篇</span>
                    <br>
                    正常文章: <span id="normalArticle">${articleContCommon}篇</span>
                    <br>
                    待审核文章: <span id="bannedArticles">${articleContBan}篇</span>
                </div>
            </div>
        </div>
        <div class="layui-show-lg-block layui-hide-sm layui-hide-xs layui-hide-md"
             style="width: 800px;height: 200px;position: absolute;top: 50%;left: 50%;transform: translate(-50%,-50%)">
            <canvas id="myChart" style="display: block;background-color: #F2F2F2"></canvas>
        </div>
    </div>

    <div class="layui-footer" style="text-align: right">
        2021 - 2021 个人博客
    </div>
</div>
<script src="../../../resources/chart.js-3.3.2/auto/auto.js"></script>
<script src="../../../resources/chart.js-3.3.2/dist/chart.js"></script>
<script src="../../../resources/chart.js-3.3.2/helpers/helpers.js"></script>
<script>
    var ctx = document.getElementById('myChart');

    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['用户数', '文章', '评论', '留言'],
            datasets: [{
                label: '# 总数',
                data: ${tes},
                backgroundColor: [
                    'rgb(156,149,149)',
                ],
                borderColor: [
                    'rgb(156,149,149)',
                ],
                borderWidth: 2
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: false,
                }
            }
        }
    });
</script>
</body>
<style>

    .divasb {
        float: left;
    }

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
</style>
</html>
