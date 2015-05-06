<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 23.01.15
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<%@include file="head.jspf" %>
<body>
    <%@include file="menu.jspf" %>
    <div class="main" id="page-jobs">
        <h1>Jobs</h1>
        <br />
        <ul class="jobs">
            <c:forEach var="entry" items="${jobs}">
                <li>(${entry.value.startTime}) ${entry.value}: ${entry.value.progressState}
                    <c:if test="${entry.value.progressState == 'PROCESSING'}">
                        <a href="cancel/${entry.key}">Cancel</a>
                    </c:if>
                </li>
            </c:forEach>
        </ul>
        <c:if test="${removedTransformations != null}">
            <h2>Removed Jobs</h2>
            <ul class="jobs">
                <c:forEach var="entry" items="${removedTransformations}">
                    <li>${entry.value}: ${entry.value.progressState}</li>
                </c:forEach>
            </ul>
        </c:if>
        <br />
        <a href="clear" class="btn">Clear</a>
    </div>
    <%@include file="footer.jspf" %>
</body>
</html>
