<%--
  Created by IntelliJ IDEA.
  User: boehm
  Date: 30.10.14
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<%@include file="head.jspf" %>
<body>	
	<c:set var="currentTab" value="archive"/>
	<%@include file="menu.jspf" %>
    <div class="main" id="page-archiveList">
        <h1>Archive</h1>
        <ul class="institutionList">
            <spring:url value="/solr/reindex" var="reindexLink"/>
            <spring:url value="/process/reprocess" var="reprocessLink"/>
            <spring:url value="/files/upload" var="uploadLink"/>
            <spring:url value="/files/workingFormat" var="workingFormatLink"/>
            <spring:url value="/files/solrFormat" var="solrLink"/>
            <spring:url value="/archive/delete" var="deleteLink"/>
            <c:forEach var="core" items="${coreList}">
                <li>
                    <strong>Solr Core: ${core.coreName}</strong>
                    <a href="${reprocessLink}/${core.coreName}" class="btn">re-process latest</a>
                    <a href="${reindexLink}/${core.coreName}" class="btn">re-index latest</a>
                    <ul>
                        <c:forEach var="institution" items="${core.institutions}">
                            <li>
                                <strong>Institution: ${institution.institutionName}</strong>
                                <a href="${reprocessLink}/${core.coreName}/${institution.institutionId}" class="btn">re-process latest</a>
                                <a href="${reindexLink}/${core.coreName}/${institution.institutionId}" class="btn">re-index latest</a>
                                <ul>
                                    <c:forEach var="baseVersion" items="${institution.baseVersions}">
                                        <li>Version ${baseVersion.version} (<fmt:formatDate value="${baseVersion.date}" pattern="yyyy-MM-dd HH:mm"/>)
                                            <span class="infoBubble" title="${baseVersion.description}">i</span>
                                            <a href="${uploadLink}/${core.coreName}/${institution.institutionId}/${baseVersion.version}" class="btn btn-bright">original format</a>
                                            <a href="${workingFormatLink}/${core.coreName}/${institution.institutionId}/${baseVersion.version}" class="btn btn-bright">working format</a>
                                            <a href="${solrLink}/${core.coreName}/${institution.institutionId}/${baseVersion.version}" class="btn btn-bright">solr format</a>
                                            <a href="${reprocessLink}/${core.coreName}/${institution.institutionId}/${baseVersion.version}" class="btn">re-process</a>
                                            <a href="${reindexLink}/${core.coreName}/${institution.institutionId}/${baseVersion.version}" class="btn">re-index</a>
                                            <a href="${deleteLink}/${core.coreName}/${institution.institutionId}/${baseVersion.version}" class="delete" title="delete"></a>
                                            <ul>
                                                <c:forEach var="updateVersion" items="${baseVersion.incrementalUpdates}">
                                                    <li>Update ${updateVersion.version} (<fmt:formatDate value="${updateVersion.date}" pattern="yyyy-MM-dd HH:mm"/>)
                                                    	<span class="infoBubble" title="${updateVersion.description}">i</span>
                                                    	<a href="${uploadLink}/${core.coreName}/${institution.institutionId}/${updateVersion.version}" class="btn btn-bright">original format</a>
                                                        <a href="${workingFormatLink}/${core.coreName}/${institution.institutionId}/${updateVersion.version}" class="btn btn-bright">working format</a>
			                                            <a href="${solrLink}/${core.coreName}/${institution.institutionId}/${updateVersion.version}" class="btn btn-bright">solr format</a>
			                                            <a href="${reprocessLink}/${core.coreName}/${institution.institutionId}/${updateVersion.version}" class="btn">re-process</a>
			                                            <a href="${reindexLink}/${core.coreName}/${institution.institutionId}/${updateVersion.version}" class="btn">re-index</a>
			                                            <a href="${deleteLink}/${core.coreName}/${institution.institutionId}/${updateVersion.version}" class="delete" title="delete"></a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
            </c:forEach>
        </ul>
    </div>
    <%@include file="footer.jspf" %>
</body>
</html>
