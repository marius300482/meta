<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Welcome</title>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
<sec:authentication property="principal.username" var="user"/>
<h1>Hello ${user}!</h1>

<h2>Please upload a file!</h2>

<form:form method="post" action="upload" enctype="multipart/form-data" modelAttribute="transformation">

    File to upload:
    <form:input path="file" type="file" name="file"/><br/>

    <div style="display: none;">
    <sec:authorize access="hasAuthority('admin')">
        </div>
        You are admin!
        <div>
    </sec:authorize>
    <br/>
    <form:label path="solr">Solr Core</form:label>
    <form:select path="solr" items="${solrServices}"/>
    <br/>
    <form:label path="institution">Library/Archive</form:label>
    <form:select path="institution" items="${institutions}"/>
    <br/>
    </div>

    <input type="submit" value="Upload"/>
    Click button to upload the file!
</form:form>
<spring:url value="/j_spring_security_logout" var="logoutUrl"/>
<a href="${logoutUrl}">Logout</a>
<sec:authorize access="hasAuthority('admin')">
    <br/>
    <spring:url value="/archive" var="archive"/>
    <a href="${archive}">Archiv</a>
</sec:authorize>

</body>
</html>
