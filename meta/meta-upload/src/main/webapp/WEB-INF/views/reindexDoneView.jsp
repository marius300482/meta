<%@include file="header.jspf" %>
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
</head>
<body>

<h2>Re-indexing ${"".equals(institution) ? "" : " of institution: " + institution} on Solr core ${core} done!</h2>

<h3>Solr response</h3>
${result}

<%@include file="footer.jspf" %>
</body>
</html>
