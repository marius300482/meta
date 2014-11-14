Hi ${user}!

The result of upload ${t.key} is ${result}.

<#if t.exception??>
Failure ${t.exception}
</#if>

<#if t.solrResponse??>
Solr result: ${t.solrResponse}
</#if>

<#if t.transformationMessages??>
Errors and warnings from transformation: ${t.transformationMessages}
</#if>