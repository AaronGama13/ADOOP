<%-- 
    Document   : cuenta
    Created on : 2/04/2020, 03:47:28 PM
    Author     : saulg
--%>

<%@page import="Modelos.Usuario"%>
<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="Database.Conexion"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = "";
    if(sesionOK.getAttribute("usuario")!=null){
        username = (String) sesionOK.getAttribute("usuario");
    }else{
        response.sendRedirect("index.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cuenta</title>
        <!--Scripts-->
        <!--CSS-->
        <link rel="stylesheet" type="text/css" href="CSS/cuenta.css">
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <div id="contenedor">
            <header id="con-header">
                <p><h3>Perfil</h3></p>
                <p>Puedes modificar los datos de tu cuenta</p>
                <%
                    Usuario user = Sentencias.obtenerInfoUsuario(username);
                %>
            </header>
            <div id="con-info">
                <p><span>Información básica:</span></p>
                <p>
                    <%
                        out.print("<input type='text' name='nombre' class='readonly' readonly value='"+user.getNp()+"'>");
                        out.print("<input type='text' name='ap' class='readonly' readonly value='"+user.getAp()+"'>");
                        out.print("<input type='text' name='am' class='readonly' readonly value='"+user.getAm()+"'>");
                    %>
                </p>
                <form id="info-basica">                    
                    <span class="titles">Calle</span>
                    <p><%out.print("<input type='text' name='calle' id='calle' value='"+user.getCalle()+"'>");%></p>
                    <span class="titles">Colonia</span>
                    <p><%out.print("<input type='text' name='col' id='col' value='"+user.getCol()+"'>");%></p>
                    <span class="titles">Alcaldía</span>
                    <p><%out.print("<input type='text' name='alc' id='alc' value='"+user.getAlc()+"'>");%></p>
                    <span class="titles">Código Postal</span>
                    <p><%out.print("<input type='number' name='cp' id='cp' value='"+String.valueOf(user.getCp())+"'>");%></p>
                    <span class="titles">Ciudad</span>
                    <p><%out.print("<input type='text' name='ciudad' id='ciudad' value='"+user.getCd()+"'>");%></p>
                    <span class="titles">Teléfono</span>
                    <p><%out.print("<input type='number' name='tel' id='tel' value='"+user.getTel()+"'>");%></p>                      
                    <p><input type="submit" name="Guardar" id="guardar" value="Guardar"></p>
                    <div class="clearfix"></div><hr>
                </form>
                <form id="info-password">
                    <span>Contraseña</span>
                    <p><input type="password" name="pass" id="pass"></p>
                    <span>Contraseña nueva</span>
                    <p><input type="password" name="new-pass" id="new-pass"></p>
                    <input type="submit" name="Guardar" id="guardar" value="Guardar">
                    <div class="clearfix"></div>
                </form>
            </div>
        </div>
    </body>
</html>
