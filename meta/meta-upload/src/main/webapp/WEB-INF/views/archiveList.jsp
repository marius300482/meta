<%@include file="header.jspf" %>
<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 30.10.14
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title></title>
</head>
<body>
<%@include file="footer.jspf" %>

<h1>Archive</h1>

<ul>
    <spring:url value="/files" var="filelink"/>
    <c:forEach var="entry" items="${fileMap}">
        <li>
            <a href="${filelink}/${entry.key}" target="_blank">${entry.value.fileName}</a>
        </li>
    </c:forEach>
</ul>
<br/>

<h2>Re-Index</h2>
<ul>
    <spring:url value="/solr/reindex" var="reindexLink"/>
    <c:forEach var="entry" items="${solrSet}">
        <li>
            <a href="${reindexLink}/${entry}" target="_blank">${entry}</a>
        </li>
    </c:forEach>
</ul>
<%@include file="footer.jspf" %>
</body>
</html>
