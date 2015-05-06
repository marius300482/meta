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
    <%@include file="menu.jspf" %>
    <div class="main">
        <h1>Archiv</h1>
        <ul>
            <spring:url value="/solr/reindex" var="reindexLink"/>
            <spring:url value="/process/reprocess" var="reprocessLink"/>
            <spring:url value="/files/upload" var="uploadLink"/>
            <spring:url value="/files/workingFormat" var="workingFormatLink"/>
            <spring:url value="/files/solrFormat" var="solrLink"/>
            <spring:url value="/archive/delete" var="deleteLink"/>
            <c:forEach var="core" items="${coreList}">
                <li>Solr Core: ${core}
                    [<a href="${reindexLink}/${core.path}">re-index latest</a>]
                    [<a href="${reprocessLink}/${core.path}">re-process latest</a>]
                </li>
                <ul>
                    <c:forEach var="institution" items="${core.entries}">
                        <li>Institution: ${institution}
                            [<a href="${reindexLink}/${institution.path}">re-index latest</a>]
                            [<a href="${reprocessLink}/${institution.path}">re-process latest</a>]
                        </li>
                        <ul>
                            <c:forEach var="versionUpload" items="${institution.entries}">
                                <li>Version ${versionUpload.versionNumber}.0:
                                    <a href="${uploadLink}/${versionUpload.path}">${versionUpload.uploadFile.fileName}</a>
                                    (${versionUpload.date})
                                    [<a href="${workingFormatLink}/${versionUpload.path}">working format</a>]
                                    [<a href="${solrLink}/${versionUpload.path}">solr format</a>]
                                    [<a href="${reprocessLink}/${versionUpload.path}">re-process</a>]
                                    [<a href="${deleteLink}/${versionUpload.path}">delete</a>]
                                </li>
                                <ul>
                                    <c:forEach var="updateUpload" items="${versionUpload.entries}">
                                        <li>Update ${versionUpload.versionNumber}.${updateUpload.updateNumber}:
                                            <a href="${uploadLink}/${updateUpload.path}">${updateUpload.uploadFile.fileName}</a>
                                            (${updateUpload.date})
                                            [<a href="${workingFormatLink}/${updateUpload.path}">working format</a>]
                                            [<a href="${solrLink}/${updateUpload.path}">solr format</a>]
                                            [<a href="${reprocessLink}/${updateUpload.path}">re-process</a>]
                                            [<a href="${deleteLink}/${updateUpload.path}">delete</a>]
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                </ul>
            </c:forEach>
            <% /*
            <c:forEach var="entry" items="${solrSet}">
                <li>
                    <a href="${reindexLink}/${entry}" target="_blank">${entry}</a>
                </li>
            </c:forEach>
            */ %>
        </ul>
    </div>
    <%@include file="footer.jspf" %>
</body>
</html>
