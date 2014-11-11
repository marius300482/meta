<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 30.10.14
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<ul>
    <spring:url value="/files" var="filelink"/>
    <c:forEach var="entry" items="${fileMap}">
        <li>
            <a href="${filelink}/${entry.key}" target="_blank">${entry.value.fileName}</a>
        </li>
    </c:forEach>
</ul>
<br/>

<ul>
    <spring:url value="/archive/reindex" var="reindexLink"/>
    <c:forEach var="entry" items="${solrSet}">
        <li>
            <a href="${reindexLink}/${entry}" target="_blank">${entry}</a>
        </li>
    </c:forEach>
</ul>

<spring:url value="/archive/reindex" var="reindex"/>
<a href="${reindex}">Re-index</a>
</body>
</html>
