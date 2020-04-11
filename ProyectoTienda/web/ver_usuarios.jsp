<%-- 
    Document   : ver_usuarios
    Created on : 10/04/2020, 03:33:10 PM
    Author     : saulg
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Database.Sentencias"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios</title>
        <!--Scripts-->
	<!--Estilos-->
        <link rel="stylesheet" type="text/css" href="CSS/ver_usuarios.css">
        <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
    </head>
    <body>
       <jsp:include page="navbar.jsp" />
       <section id="contenedor">
           <header id="cabecera-usu">
               <h3>Administrador de usuarios</h3>
           </header>
           <div id="usuarios">
               <ul>
                   <%
                       ResultSet usuarios = Sentencias.obtenerUsuarios();
                       while(usuarios.next()){
                           out.print("<li>");
                               out.print("");
                               out.print("");
                           out.print("</li>");
                       }
                   %>
                   <li>
                       <form action="action" method="POST">
                           <span name="nombre">Nombre completo</span>
                           <span name="usuario">Nombre de usuario</span>
                           <span name="direccion">Dirección</span>
                           <span name="tel">Número de teléfono</span>
                           <input type="submit" value="Eliminar usuario">
                       </form>
                       <div class="clearfix"></div>
                   </li>   
               </ul>
           </div>     
           <div class="clearfix"></div>
       </section>
    </body>
</html>
