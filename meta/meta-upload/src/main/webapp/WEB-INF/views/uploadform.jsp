<!DOCTYPE html>
<html>
<%@include file="header.jspf" %>
<body>
    <%@include file="menu.jspf" %>

    <sec:authentication property="principal.username" var="user"/>

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
        <c:if test="${allowIncremental}">
            <form:checkbox path="incremental" value="${incrementalDefault}" label="Inkrementelles Update"/>
            <br/>
        </c:if>

        <input type="submit" value="Upload"/>
        Click button to upload the file!
    </form:form>
    <%@include file="footer.jspf" %>
</body>
</html>
