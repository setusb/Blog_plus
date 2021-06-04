<%--
  User: setusb
  Date: 2021/4/21
  Time: 12:17
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ul class="content_ul">
    <c:forEach items="${article}" var="item">
        <li id="listers" onclick="jumpClick(${item.articleUuid})">
            <a id="listers_a" title="${item.articleTitle}" class="content_ul_a" href="/article/${item.articleUuid}"><span style="color: #000000">【 </span>${item.articleTitle}<span style="color: #000000"> 】</span></a>
            <p id="listers_p" title="${item.articleTarget}"><span style="color: #616161">[ </span>${item.articleTarget}<span style="color: #7b7b7b"> ]</span></p>
        </li>
    </c:forEach>
</ul>
