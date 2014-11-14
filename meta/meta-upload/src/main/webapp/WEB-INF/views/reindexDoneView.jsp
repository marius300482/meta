<%@ page import="de.idadachverband.transform.TransformationProgressState" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 17.07.14
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<spring:url value="/archive" var="archive"/>
<spring:url value="/upload" var="url"/>
<spring:url value="/j_spring_security_logout" var="logoutUrl"/>

<h2>Re-indexing of ${core} done!</h2>

<div>
    <a href="${archive}">Archiv</a>
    <a href="${url}">Upload file</a>
    <a href="${logoutUrl}">Logout</a>
</div>

</body>
</html>
