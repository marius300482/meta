<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 17.07.14
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<%@include file="head.jspf" %>
<%@ page import="de.idadachverband.job.JobProgressState" %>
<body>
    <%@include file="menu.jspf" %>
    <div class="main">
        <h1>You successfully started the re-processing of the archived upload version ${version} for ${institution} on ${core}.</h1>
        <spring:url value="/files/" var="fileUrl"/>
        <spring:url value="/result/getResult" var="stateUrl"/>
        <spring:url value="/resources/images/waiting.gif" var="waiting"/>

        <div id="waiting">
            <div style="display: inline-block">
                <img src="${waiting}">
            </div>
            <div style="display: inline-block; padding-left: 20px; vertical-align: top">
                <h2>Job ID: ${jobId}</h2>
                Processing may take a little longer. You can close this window.<br />
                You will be informed by e-mail about the outcome.
            </div>
        </div>

        <div id="success" style="display: none;">
            <h2>Done</h2>
        </div>

        <div id="failure" style="display: none;">
            <h2>Error!</h2>
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
                        {"jobId": "${jobId}"},
                        successCallback
                );
            };

            pollInterval = setInterval(poll, 15000);
        </script>
    </div>
    <%@include file="footer.jspf" %>
</body>
</html>
