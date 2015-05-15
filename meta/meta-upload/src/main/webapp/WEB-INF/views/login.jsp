<!DOCTYPE html>
<html>
<%@include file="head.jspf" %>
<body onload='document.f.j_username.focus();'>
<header>
    <div id="slogan">
        File-Upload<br />Metadaten-Katalog
    </div>
    <div id="logo"></div>
    <div style="height: 105px"></div>
</header>
<div class="main">
    <c:if test="${'fail' eq param.auth}">
		<div class="error">Invalid username or password!</div><br />
	</c:if>
	<c:if test="${'success' eq param.logout}">
		<div class="msg">You have been successfully logged out.</div><br />
	</c:if>
	<h1>Login</h1>
    <form name='f' action='j_spring_security_check' method='POST'>
        <input type='text' name='j_username' value='' placeholder="Username" style="width: 300px"  /><br />
        <br />
        <input type='password' name='j_password' placeholder="Password" style="width: 300px" /><br />
        <br />
        <br />
        <input name="submit" type="submit" value="Login" class="btn"/>
    </form>
</div>
</body>
</html>