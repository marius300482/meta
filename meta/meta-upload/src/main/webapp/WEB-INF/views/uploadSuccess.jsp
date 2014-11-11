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
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
</head>
<body>
<h1>It worked</h1>
<spring:url value="/upload" var="url"/>
<spring:url value="/files/" var="fileUrl"/>
<spring:url value="/j_spring_security_logout" var="logoutUrl"/>
<spring:url value="/upload/getResult" var="stateUrl"/>
<spring:url value="/resources/images/waiting.gif" var="waiting"/>

<h2>Job Id: ${result}</h2>

<div id="waiting">
    <img src="${waiting}">
    <br/>
    <span>Die Verarbeitung kann etwas länger dauern. Sie werden per E-Mail über das Ergebnis informiert.</span>
</div>

<div id="filelink" style="display: none;">
    <h2>Fertig</h2>
    <a id="filelink" href="${fileUrl}" target="_blank">Transformiertes XML-File</a>
</div>
<div id="failure" style="display: none;">
    <h2>Fehler!</h2>

    <div id="exception"></div>

</div>

<div>
    <a href="${url}">Next file</a>
    <a href="${logoutUrl}">Logout</a>
</div>

<script type="application/javascript">
    successCallback = function (v) {
        console.log(v);
        if (v.state === "<%= TransformationProgressState.DONE %>") {
            var link = jQuery("#filelink").find("a");
            var url = link.attr("href");
            link.attr("href", url + v.filename);
            jQuery("#filelink").toggle();
            done();
        }
        else if (v.state === "<%= TransformationProgressState.FAILURE %>") {
            var failure = jQuery("#failure");
            jQuery("#exception").text(v.exception);
            failure.toggle();
            done();
        }
    };

    done = function () {
        clearInterval(pollInterval);
        jQuery("#waiting").toggle();
    };

    poll = function () {
        jQuery.getJSON(
                "${stateUrl}",
                {"result": "${result}"},
                successCallback
        );
    };

    pollInterval = setInterval(poll, 15000);
</script>
</body>
</html>
