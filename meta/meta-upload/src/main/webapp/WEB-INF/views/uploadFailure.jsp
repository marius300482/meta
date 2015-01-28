<%@include file="header.jspf" %>
<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 17.07.14
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <title></title>
</head>
<body>

<h1>Upload failure</h1>

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

<%@include file="footer.jspf" %>
</body>
</html>
