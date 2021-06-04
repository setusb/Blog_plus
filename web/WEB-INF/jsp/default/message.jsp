<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: setusb
  Date: 2021/6/1
  Time: 8:57
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="../../../resources/layui/css/layui.css" rel="stylesheet" type="text/css">
<script src="../../../resources/js/jquery-3.6.0.min.js"></script>

<!-- jquery ui 的导入 -->
<link href="../../../resources/jqui/jquery-ui.css" rel="stylesheet">
<script src="../../../resources/jqui/external/jquery/jquery.js"></script>
<script src="../../../resources/jqui/jquery-ui.js"></script>
<html>
<head>
    <title>个人博客 - 留言</title>
</head>
<body>
<div class="gradient-pattern"></div>

<div class="messageBox">
    <div class="messageBox_x">X</div>
    <ul class="ul" style="margin-top: 20px">
        <c:if test="${msl.size() > 0}">
            <c:forEach items="${msl}" var="msl">
                <li>
                    <a style="margin-right: 60px;padding-left: 5px">${msl.name}</a><span>${msl.date}</span>
                    <p style="padding-left: 5px">${msl.content}</p>
                </li>
            </c:forEach>
        </c:if>
        <c:if test="${msl.size() == 0}">
            <h1 style="position: absolute;top: 50%;left: 50%;transform: translate(-50%,-50%);font-weight: bold;">暂无留言</h1>
        </c:if>
    </ul>
</div>

<div class="div1">
    <div class="div1_4"></div>
    <div class="div1_3">
        <div class="div1_3_1">●</div>
    </div>
    <div class="div1_2"></div>
    <div class="div1_1">
        <button type="button" id="extractMessage" class="feedback-button">点击抽取留言</button>
    </div>
</div>
<label>
    <textarea class="div2" id="textContent" placeholder="按下回车留言，按下Esc返回主页（你的留言将会存放在留言箱中，期待有缘人抽到查看）"></textarea>
</label>

</body>
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

        $(document).keyup(function (event) {
            if (event.keyCode === 27) {
                window.location = "/index"
            }

            if (event.keyCode === 13) {
                if ($('#textContent').val() !== '') {
                    a();
                }
            }
        });

/*        $( ".messageBox" ).draggable();*/

        $('#extractMessage').click(function () {
            $('.messageBox').css({display: "block"})
            $('.div1_4').css({
                boxShadow: "0 -10px 50px rgba(255, 230, 0, 0.82)"
            })
        });

        $('.messageBox_x').click(function () {
            $('.messageBox').css({display: "none"})
            location.reload();
        });
    });


    function a() {
        $.ajax({
            async: false,
            type: "POST",
            url: "/messageInsert",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                "textContent": $('#textContent').val()
            },
            dataType: "json",
            success: function (response) {
                if (response['a']) {
                    $('#textContent').val("");
                    location.reload();
                }
            }
        });
    }
</script>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    .ul li {
        margin: 10px 0 26px 0;
        border-top: 1px solid black;
        border-bottom: 1px solid black;
        cursor: pointer;
    }

    .div1_3_1 {
        font-size: 40px;
    }

    .messageBox_x {
        position: absolute;
        right: 5px;
        top: 5px;
        cursor: pointer;
        font-weight: bold;
    }

    .messageBox {
        width: 480px;
        height: 480px;
        background-color: white;
        position: absolute;
        left: 50%;
        top: 18%;
        transform: translate(-50%, -18%);
        border: 5px solid gray;
        border-radius: 10px;
        z-index: 99999;
        display: none;
    }

    .div1_4 {
        width: 100%;
        height: 80px;
        background-color: rgb(0, 0, 0);
        border-top-left-radius: 20px;
        border-top-right-radius: 20px;
        border: 1px solid black;
        /*       box-shadow: 0 -10px 50px rgba(255, 230, 0, 0.82);*/

    }

    .div1_3 {
        width: 48px;
        height: 48px;
        background-color: #d7bd00;
        border-radius: 50%;
        position: absolute;
        border: 3px solid white;
        left: 50%;
        top: 3%;
        transform: translate(-50%, -3%);
        text-align: center;
        box-shadow: 0 0 5px red;
    }

    .div1_2 {
        width: 100%;
        height: 10px;
        background-color: #a8a8a8;
        position: absolute;
        top: 15%;
        border: 1px solid #a8a8a8;

    }

    .div1 {
        position: relative;
        width: 1080px;
        height: 500px;
        margin: 30px auto;
        -moz-border-radius-topleft: 30px;
        -moz-border-radius-topright: 30px;
        border-top-left-radius: 30px;
        border-top-right-radius: 30px;
        border: 10px solid #a8a8a8;
        box-shadow: 0 -5px 0 gray;
        -webkit-box-sizing: content-box;
        -moz-box-sizing: content-box;
        box-sizing: content-box;
        font: normal 100%/normal Arial, Helvetica, sans-serif;
        color: rgb(255, 255, 255);
        -o-text-overflow: clip;
        text-overflow: clip;
        background: -webkit-repeating-linear-gradient(45deg, rgba(0, 0, 0, 0) 5px, rgba(10, 35, 45, 0.498039) 5px, rgba(10, 35, 45, 0.498039) 10px, rgba(211, 119, 111, 0) 10px, rgba(211, 119, 111, 0) 35px, rgba(211, 119, 111, 0.498039) 35px, rgba(211, 119, 111, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 50px, rgba(10, 35, 45, 0) 50px, rgba(10, 35, 45, 0) 60px, rgba(211, 119, 111, 0.498039) 60px, rgba(211, 119, 111, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 80px, rgba(247, 179, 84, 0) 80px, rgba(247, 179, 84, 0) 90px, rgba(211, 119, 111, 0.498039) 90px, rgba(211, 119, 111, 0.498039) 110px, rgba(211, 119, 111, 0) 110px, rgba(211, 119, 111, 0) 120px, rgba(10, 35, 45, 0.498039) 120px, rgba(10, 35, 45, 0.498039) 140px), -webkit-repeating-linear-gradient(-45deg, rgba(0, 0, 0, 0) 5px, rgba(10, 35, 45, 0.498039) 5px, rgba(10, 35, 45, 0.498039) 10px, rgba(211, 119, 111, 0) 10px, rgba(211, 119, 111, 0) 35px, rgba(211, 119, 111, 0.498039) 35px, rgba(211, 119, 111, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 50px, rgba(10, 35, 45, 0) 50px, rgba(10, 35, 45, 0) 60px, rgba(211, 119, 111, 0.498039) 60px, rgba(211, 119, 111, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 80px, rgba(247, 179, 84, 0) 80px, rgba(247, 179, 84, 0) 90px, rgba(211, 119, 111, 0.498039) 90px, rgba(211, 119, 111, 0.498039) 110px, rgba(211, 119, 111, 0) 110px, rgba(211, 119, 111, 0) 140px, rgba(10, 35, 45, 0.498039) 140px, rgba(10, 35, 45, 0.498039) 160px), rgb(234, 213, 185);
        background: -moz-repeating-linear-gradient(45deg, rgba(0, 0, 0, 0) 5px, rgba(10, 35, 45, 0.498039) 5px, rgba(10, 35, 45, 0.498039) 10px, rgba(211, 119, 111, 0) 10px, rgba(211, 119, 111, 0) 35px, rgba(211, 119, 111, 0.498039) 35px, rgba(211, 119, 111, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 50px, rgba(10, 35, 45, 0) 50px, rgba(10, 35, 45, 0) 60px, rgba(211, 119, 111, 0.498039) 60px, rgba(211, 119, 111, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 80px, rgba(247, 179, 84, 0) 80px, rgba(247, 179, 84, 0) 90px, rgba(211, 119, 111, 0.498039) 90px, rgba(211, 119, 111, 0.498039) 110px, rgba(211, 119, 111, 0) 110px, rgba(211, 119, 111, 0) 120px, rgba(10, 35, 45, 0.498039) 120px, rgba(10, 35, 45, 0.498039) 140px), -moz-repeating-linear-gradient(135deg, rgba(0, 0, 0, 0) 5px, rgba(10, 35, 45, 0.498039) 5px, rgba(10, 35, 45, 0.498039) 10px, rgba(211, 119, 111, 0) 10px, rgba(211, 119, 111, 0) 35px, rgba(211, 119, 111, 0.498039) 35px, rgba(211, 119, 111, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 50px, rgba(10, 35, 45, 0) 50px, rgba(10, 35, 45, 0) 60px, rgba(211, 119, 111, 0.498039) 60px, rgba(211, 119, 111, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 80px, rgba(247, 179, 84, 0) 80px, rgba(247, 179, 84, 0) 90px, rgba(211, 119, 111, 0.498039) 90px, rgba(211, 119, 111, 0.498039) 110px, rgba(211, 119, 111, 0) 110px, rgba(211, 119, 111, 0) 140px, rgba(10, 35, 45, 0.498039) 140px, rgba(10, 35, 45, 0.498039) 160px), rgb(234, 213, 185);
        background: repeating-linear-gradient(45deg, rgba(0, 0, 0, 0) 5px, rgba(10, 35, 45, 0.498039) 5px, rgba(10, 35, 45, 0.498039) 10px, rgba(211, 119, 111, 0) 10px, rgba(211, 119, 111, 0) 35px, rgba(211, 119, 111, 0.498039) 35px, rgba(211, 119, 111, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 50px, rgba(10, 35, 45, 0) 50px, rgba(10, 35, 45, 0) 60px, rgba(211, 119, 111, 0.498039) 60px, rgba(211, 119, 111, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 80px, rgba(247, 179, 84, 0) 80px, rgba(247, 179, 84, 0) 90px, rgba(211, 119, 111, 0.498039) 90px, rgba(211, 119, 111, 0.498039) 110px, rgba(211, 119, 111, 0) 110px, rgba(211, 119, 111, 0) 120px, rgba(10, 35, 45, 0.498039) 120px, rgba(10, 35, 45, 0.498039) 140px), repeating-linear-gradient(135deg, rgba(0, 0, 0, 0) 5px, rgba(10, 35, 45, 0.498039) 5px, rgba(10, 35, 45, 0.498039) 10px, rgba(211, 119, 111, 0) 10px, rgba(211, 119, 111, 0) 35px, rgba(211, 119, 111, 0.498039) 35px, rgba(211, 119, 111, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 40px, rgba(10, 35, 45, 0.498039) 50px, rgba(10, 35, 45, 0) 50px, rgba(10, 35, 45, 0) 60px, rgba(211, 119, 111, 0.498039) 60px, rgba(211, 119, 111, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 70px, rgba(247, 179, 84, 0.498039) 80px, rgba(247, 179, 84, 0) 80px, rgba(247, 179, 84, 0) 90px, rgba(211, 119, 111, 0.498039) 90px, rgba(211, 119, 111, 0.498039) 110px, rgba(211, 119, 111, 0) 110px, rgba(211, 119, 111, 0) 140px, rgba(10, 35, 45, 0.498039) 140px, rgba(10, 35, 45, 0.498039) 160px), rgb(234, 213, 185);
        -webkit-background-origin: padding-box;
        background-origin: padding-box;
        -webkit-background-clip: border-box;
        background-clip: border-box;
        -webkit-background-size: auto auto;
        background-size: auto auto;
    }

    .div1_1 {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 202px;
        transform: translate(-50%, -50%);
    }


    .feedback-button {
        border-radius: 5px;
        display: inline-block;
        -webkit-box-sizing: content-box;
        -moz-box-sizing: content-box;
        box-sizing: content-box;
        float: left;
        position: relative;
        cursor: pointer;
        margin: 0 2% 0 0;
        padding: 12px 22px;
        overflow: hidden;
        border: none;
        font: normal normal bold 1.6em/normal "Syncopate", Helvetica, sans-serif;
        color: #ecf0f1;
        -o-text-overflow: clip;
        text-overflow: clip;
        background: -webkit-linear-gradient(-90deg, #ff8583 0, #ff5350 100%);
        background: -moz-linear-gradient(180deg, #ff8583 0, #ff5350 100%);
        background: linear-gradient(180deg, #ff8583 0, #ff5350 100%);
        background-position: 50% 50%;
        -webkit-background-origin: padding-box;
        background-origin: padding-box;
        -webkit-background-clip: border-box;
        background-clip: border-box;
        -webkit-background-size: auto auto;
        background-size: auto auto;
        -webkit-box-shadow: 0 10px 0 0 rgba(178, 49, 49, 1);
        box-shadow: 0 10px 0 0 rgba(178, 49, 49, 1);
        text-shadow: 0 0 0 rgb(196, 80, 78), 1px 1px 0 rgb(196, 80, 78), 2px 2px 0 rgb(196, 80, 78), 3px 3px 0 rgb(196, 80, 78), 4px 4px 0 rgb(196, 80, 78), 5px 5px 0 rgb(196, 80, 78), 6px 6px 0 rgb(196, 80, 78), 7px 7px 0 rgb(196, 80, 78), 8px 8px 0 rgb(196, 80, 78), 9px 9px 0 rgb(196, 80, 78), 10px 10px 0 rgb(196, 80, 78), 11px 11px 0 rgb(196, 80, 78), 12px 12px 0 rgb(196, 80, 78), 13px 13px 0 rgb(196, 80, 78), 14px 14px 0 rgb(196, 80, 78), 15px 15px 0 rgb(196, 80, 78), 16px 16px 0 rgb(196, 80, 78), 17px 17px 0 rgb(196, 80, 78), 18px 18px 0 rgb(196, 80, 78), 19px 19px 0 rgb(196, 80, 78), 20px 20px 0 rgb(196, 80, 78), 21px 21px 0 rgb(196, 80, 78), 22px 22px 0 rgb(196, 80, 78), 23px 23px 0 rgb(196, 80, 78), 24px 24px 0 rgb(196, 80, 78), 25px 25px 0 rgb(196, 80, 78), 26px 26px 0 rgb(196, 80, 78), 27px 27px 0 rgb(196, 80, 78), 28px 28px 0 rgb(196, 80, 78), 29px 29px 0 rgb(196, 80, 78), 30px 30px 0 rgb(196, 80, 78), 31px 31px 0 rgb(196, 80, 78), 32px 32px 0 rgb(196, 80, 78), 33px 33px 0 rgb(196, 80, 78), 34px 34px 0 rgb(196, 80, 78), 35px 35px 0 rgb(196, 80, 78), 36px 36px 0 rgb(196, 80, 78), 37px 37px 0 rgb(196, 80, 78), 38px 38px 0 rgb(196, 80, 78), 39px 39px 0 rgb(196, 80, 78), 40px 40px 0 rgb(196, 80, 78), 41px 41px 0 rgb(196, 80, 78), 42px 42px 0 rgb(196, 80, 78), 43px 43px 0 rgb(196, 80, 78), 44px 44px 0 rgb(196, 80, 78), 45px 45px 0 rgb(196, 80, 78), 46px 46px 0 rgb(196, 80, 78), 47px 47px 0 rgb(196, 80, 78), 48px 48px 0 rgb(196, 80, 78), 1px 1px 0 rgba(196, 80, 78, 0.980392), 2px 2px 0 rgba(196, 80, 78, 0.960784), 3px 3px 0 rgba(196, 80, 78, 0.941176), 4px 4px 0 rgba(196, 80, 78, 0.921569), 5px 5px 0 rgba(196, 80, 78, 0.901961), 6px 6px 0 rgba(196, 80, 78, 0.882353), 7px 7px 0 rgba(196, 80, 78, 0.862745), 8px 8px 0 rgba(196, 80, 78, 0.843137), 9px 9px 0 rgba(196, 80, 78, 0.819608), 10px 10px 0 rgba(196, 80, 78, 0.8), 11px 11px 0 rgba(196, 80, 78, 0.780392), 12px 12px 0 rgba(196, 80, 78, 0.760784), 13px 13px 0 rgba(196, 80, 78, 0.741176), 14px 14px 0 rgba(196, 80, 78, 0.721569), 15px 15px 0 rgba(196, 80, 78, 0.701961), 16px 16px 0 rgba(196, 80, 78, 0.682353), 17px 17px 0 rgba(196, 80, 78, 0.658824), 18px 18px 0 rgba(196, 80, 78, 0.639216), 19px 19px 0 rgba(196, 80, 78, 0.619608), 20px 20px 0 rgba(196, 80, 78, 0.6), 21px 21px 0 rgba(196, 80, 78, 0.580392), 22px 22px 0 rgba(196, 80, 78, 0.560784), 23px 23px 0 rgba(196, 80, 78, 0.541176), 24px 24px 0 rgba(196, 80, 78, 0.521569), 25px 25px 0 rgba(196, 80, 78, 0.498039), 26px 26px 0 rgba(196, 80, 78, 0.478431), 27px 27px 0 rgba(196, 80, 78, 0.458824), 28px 28px 0 rgba(196, 80, 78, 0.439216), 29px 29px 0 rgba(196, 80, 78, 0.419608), 30px 30px 0 rgba(196, 80, 78, 0.4), 31px 31px 0 rgba(196, 80, 78, 0.380392), 32px 32px 0 rgba(196, 80, 78, 0.360784), 33px 33px 0 rgba(196, 80, 78, 0.341176), 34px 34px 0 rgba(196, 80, 78, 0.317647), 35px 35px 0 rgba(196, 80, 78, 0.298039), 36px 36px 0 rgba(196, 80, 78, 0.278431), 37px 37px 0 rgba(196, 80, 78, 0.258824), 38px 38px 0 rgba(196, 80, 78, 0.239216), 39px 39px 0 rgba(196, 80, 78, 0.219608), 40px 40px 0 rgba(196, 80, 78, 0.2), 41px 41px 0 rgba(196, 80, 78, 0.180392), 42px 42px 0 rgba(196, 80, 78, 0.156863), 43px 43px 0 rgba(196, 80, 78, 0.137255), 44px 44px 0 rgba(196, 80, 78, 0.117647), 45px 45px 0 rgba(196, 80, 78, 0.0980392), 46px 46px 0 rgba(196, 80, 78, 0.0784314), 47px 47px 0 rgba(196, 80, 78, 0.0588235), 48px 48px 0 rgba(196, 80, 78, 0.0392157), 50px 50px 0 rgba(196, 80, 78, 0);
    }

    .feedback-button:hover {
        text-align: center;
        background: -webkit-linear-gradient(-90deg, #ce6161 0, #ef6664 100%);
        background: -moz-linear-gradient(180deg, #ce6161 0, #ef6664 100%);
        background: linear-gradient(180deg, #ce6161 0, #ef6664 100%);
        background-position: 50% 50%;
        -webkit-background-origin: padding-box;
        background-origin: padding-box;
        -webkit-background-clip: border-box;
        background-clip: border-box;
        -webkit-background-size: auto auto;
        background-size: auto auto;
    }

    .feedback-button:active {
        top: 5px;
        background: -webkit-linear-gradient(-90deg, #ff8583 0, #ff5350 100%);
        background: -moz-linear-gradient(180deg, #ff8583 0, #ff5350 100%);
        background: linear-gradient(180deg, #ff8583 0, #ff5350 100%);
        background-position: 50% 50%;
        -webkit-background-origin: padding-box;
        background-origin: padding-box;
        -webkit-background-clip: border-box;
        background-clip: border-box;
        -webkit-background-size: auto auto;
        background-size: auto auto;
        -webkit-box-shadow: 0 5px 0 0 rgba(178, 49, 49, 1);
        box-shadow: 0 5px 0 0 rgba(178, 49, 49, 1);
    }

    .div2 {
        width: 960px;
        height: 100px;
        display: block;
        margin: 0 auto;
        resize: none;
        text-decoration: none;
        outline: none;
        font-size: 16px;
        font-weight: bold;
        color: gray;
        border: 10px solid #a8a8a8;
        border-radius: 3px;
        box-shadow: 0 0 3px gray;
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
