<!DOCTYPE html>
<html>
<%@include file="head.jspf" %>
<body onload='document.f.j_username.focus();'>
    <header>
        <div id="slogan">
            Daten-Upload<br />Metadaten-Katalog
        </div>
        <div id="logo">
        </div>
        <div id="mainMenu"></div>
    </header>
    <div class="main">
        <h3>Login with Username and Password</h3>
        <form name='f' action='/j_spring_security_check' method='POST'>
            <table>
                <tr><td>User:</td><td><input type='text' name='j_username' value=''></td></tr>
                <tr><td>Password:</td><td><input type='password' name='j_password'/></td></tr>
                <tr><td colspan='2'><input name="submit" type="submit" value="Login"/></td></tr>
            </table>
        </form>
    </div>
</body>
</html>