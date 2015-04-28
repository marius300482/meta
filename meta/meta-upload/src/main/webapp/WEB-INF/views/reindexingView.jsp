<%@ include file="header.jspf" %>
<%@ page import="de.idadachverband.job.JobProgressState" %>
<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 17.07.14
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
</head>
<body>
<h1>You successfully started the re-indexing of the latest archived upload for ${institution} on ${core}.</h1>
<spring:url value="/files/" var="fileUrl"/>
<spring:url value="/result/getResult" var="stateUrl"/>
<spring:url value="/resources/images/waiting.gif" var="waiting"/>

<h2>Job Id: ${jobId}</h2>

<div id="waiting">
    <img src="${waiting}">
    <br/>
    <span>Die Verarbeitung kann etwas länger dauern. Sie werden per E-Mail über das Ergebnis informiert.</span>
</div>

<div id="success" style="display: none;">
    <h2>Fertig</h2>
</div>
<div id="failure" style="display: none;">
    <h2>Fehler!</h2>

    <div id="exception"></div>

</div>


<script type="application/javascript">
    successCallback = function (v) {
        console.log(v);
        if (v.state === "<%= JobProgressState.DONE %>") {
            jQuery("#success").toggle();
            done();
        }
        else if (v.state === "<%= JobProgressState.FAILURE %>") {
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
                {"result": "${jobId}"},
                successCallback
        );
    };

    pollInterval = setInterval(poll, 15000);
</script>

<%@include file="footer.jspf" %>
</body>
</html>
