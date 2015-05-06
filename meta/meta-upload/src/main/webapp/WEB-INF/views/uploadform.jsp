<!DOCTYPE html>
<html>
<%@include file="head.jspf" %>
<body>
    <%@include file="menu.jspf" %>
    <div class="main" id="page-upload">
        <sec:authentication property="principal.username" var="user"/>
        <h1>
            Please upload a file.
            <sec:authorize access="hasAuthority('admin')">
                You are admin!
            </sec:authorize>
        </h1>
        <br />
        <form:form method="post" action="upload" enctype="multipart/form-data" modelAttribute="transformation">
            <form:label path="file">File to upload</form:label>
            <form:input path="file" type="file" name="file"/><br/>
            <br />
            <div style="display: none;"><sec:authorize access="hasAuthority('admin')"></div><div></sec:authorize>
                <form:label path="solr">Solr Core</form:label>
                <form:select path="solr" items="${solrServices}"/><br />
                <br/>
                <form:label path="institution">Library/Archive</form:label>
                <form:select path="institution" items="${institutions}"/><br />
                <br/>
            </div>
            <c:if test="${allowIncremental}">
                <form:checkbox path="incremental" value="${incrementalDefault}" label="Inkrementelles Update"/><br />
                <br/>
            </c:if>
            <input type="submit" value="Upload" class="btn" />
            <label class="buttonDescription">Click the button to upload the file!</label>
        </form:form>
    </div>
    <%@include file="footer.jspf" %>
</body>
</html>
