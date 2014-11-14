<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 17.07.14
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title></title>
</head>
<body>
<spring:url value="/archive" var="archive"/>
<spring:url value="/upload" var="url"/>
<spring:url value="/j_spring_security_logout" var="logoutUrl"/>

<h2>Re-indexing of ${core} failed!</h2>

<div>
    <a href="${archive}">Archiv</a>
    <a href="${url}">Upload file</a>
    <a href="${logoutUrl}">Logout</a>
</div>

<h1>Failure</h1>

<h2>Exception:</h2> ${exception}

<h2>Cause:</h2>
${cause}

<h2>Message:</h2>
${message}

<h2>Stacktrace:</h2>
<c:forEach var="trace" items="${stacktrace}">
    ${trace} <br/>
</c:forEach>

<br/>

<div>
    <a href="${archive}">Archiv</a>
    <a href="${url}">Upload file</a>
    <a href="${logoutUrl}">Logout</a>
</div>

</body>
</html>
