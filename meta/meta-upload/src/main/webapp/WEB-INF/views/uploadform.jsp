<!DOCTYPE html>
<html>
<%@include file="head.jspf" %>
<body>
    <c:set var="currentTab" value="upload"/>
    <%@include file="menu.jspf" %>
    <div class="main" id="page-upload">
        <h1>
            Please upload a file.
            <sec:authorize access="hasAuthority('admin')">
                You are admin!
            </sec:authorize>
        </h1>
        <form:form method="post" action="upload" enctype="multipart/form-data" modelAttribute="transformation">
            <form:label path="file">File to upload</form:label>
            <form:input path="file" type="file" name="file"/><br/>
            <br />
            <div style="display: none;"><sec:authorize access="hasAuthority('admin')"></div><div></sec:authorize>
                <form:label path="solr">Solr Core</form:label>
                <form:select path="solr">
                	<c:forEach items="${solrServices}" var="solrService">
    					<c:choose>
    						<c:when test="${solrService eq defaultSolrService}">
	    						<form:option value="${solrService}" selected="selected"/>
	    					</c:when>
	    					<c:otherwise>
	    						<form:option value="${solrService}"/>
	    					</c:otherwise>
	    				</c:choose>
					</c:forEach>
                </form:select><br />
                <br/>
            </div>
            <div style="display: none;"><c:if test="${institutions.size() gt 1}"></div><div></c:if>
                <form:label path="institution">Library/Archive</form:label>
                <form:select path="institution">
                	<c:forEach items="${institutions}" var="institution">
    					<form:option value="${institution.institutionId}" label="${institution.institutionName}"/>
					</c:forEach>
                </form:select><br />
                <br/>
            </div>
            <c:if test="${allowIncremental}">
                <form:checkbox path="incremental" value="${incrementalDefault}" label="Incremental update"/>
                <span class="infoBubble" title="An incremental update is one that provides the changes since the last incremental update.">i</span><br />
                <br/>
            </c:if>
            <input type="submit" value="Upload" class="btn" />
            <label class="buttonDescription">Click the button to upload the file!</label>
        </form:form>
    </div>
    <%@include file="footer.jspf" %>
</body>
</html>
