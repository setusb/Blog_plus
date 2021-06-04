<%--
  User: setusb
  Date: 2021/4/16
  Time: 16:59
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="lbts" style="width: 1080px;margin: 10px auto;box-shadow: 0 0 10px gray;position:relative;">
    <div class="layui-carousel" id="test1">
        <div carousel-item>
            <div><img src="<%=request.getContextPath()%>/resources/images/1.png" style="width: 100%; max-width: 100%; height: 300px"></div>
            <div><img src="<%=request.getContextPath()%>/resources/images/2.png" style="width: 100%; max-width: 100%; height: 300px"></div>
        </div>
    </div>
    <!-- 关闭轮播图 -->
    <div class="turnOffTheCarousel">
        <a id="turnOffTheCarouselButton" title="关闭轮播图按钮">关闭</a>
    </div>
</div>
