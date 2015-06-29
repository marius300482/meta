Hi ${user}!

The result of ${t} is ${result}.

<#if t.exception??>
Failure ${t.exception}
</#if>

Message:
${message}