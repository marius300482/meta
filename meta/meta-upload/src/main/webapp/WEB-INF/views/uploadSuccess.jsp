<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 17.07.14
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<%@ include file="head.jspf" %>
<%@ page import="de.idadachverband.job.JobProgressState" %>
<body>
    <%@include file="menu.jspf" %>
    <div class="main">
        <h1>You successfully uploaded one file</h1>
        <spring:url value="/files/solrFormat/" var="fileUrl"/>
        <spring:url value="/result/getResult" var="stateUrl"/>
        <spring:url value="/resources/images/waiting.gif" var="waiting"/>

        <h2>Job Id: ${jobId}</h2>

        <div id="waiting">
            <img src="${waiting}"><br />
            <br/>
            <span>Die Verarbeitung kann etwas l&auml;nger dauern. Sie werden per E-Mail &uuml;ber das Ergebnis informiert.</span>
        </div>

        <div id="filelink" style="display: none;">
            <h2>Fertig</h2>
            <a href="${fileUrl}" target="_blank">Transformiertes XML-File</a>
        </div>

        <div id="failure" style="display: none;">
            <h2>Fehler!</h2>
            <div id="exception"></div>
        </div>

        <script type="application/javascript">
            successCallback = function (v) {
                console.log(v);
                if (v.state === "<%= JobProgressState.DONE %>") {
                    var link = jQuery("#filelink").find("a");
                    var url = link.attr("href");
                    link.attr("href", url + v.path);
                    jQuery("#filelink").toggle();
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
