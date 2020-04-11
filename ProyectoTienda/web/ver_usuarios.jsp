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
    <%
        HttpSession sesionOK = request.getSession();
        if(sesionOK.getAttribute("usuario")!=null){
            if(!sesionOK.getAttribute("priv").toString().equalsIgnoreCase("A")){
               response.sendRedirect("productos.jsp");
            }
        }
    %>
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
                            out.print("<form action='ServletBorrarUsu' method='post'>");
                             out.print("<span name='nombre'>Nombre: "+usuarios.getString("np")+" "+usuarios.getString("ap")+" "
                                     + ""+usuarios.getString("am")+"</span>");
                             out.print("<input name='usuario' type='hidden' value='"+usuarios.getString("username")+"'>");
                             out.print("<span name='usuario'>Nombre de usuario: "+usuarios.getString("username")+"</span>");
                             out.print("<span name='direccion'>Dirección: "+usuarios.getString("calle")+", No. Ext."+usuarios.getInt("noExt")+
                                     ", No. Int. "+usuarios.getInt("noInt")+", Col. "+usuarios.getString("col")+", Municipio"+usuarios.getString("muni")
                                    +", Edo. "+usuarios.getString("edo")+", Ciudad "+usuarios.getString("cd")+", C.P. "+usuarios.getInt("cp")+"</span>");
                             out.print("<span name='tel'>Teléfono: "+usuarios.getString("tel")+"</span>");
                             out.print("<input type='submit' value='Eliminar usuario'>");
                            out.print("</form>");
                           out.print("</li>");
                       }
                   %>
               </ul>
           </div>     
           <div class="clearfix"></div>
       </section>
    </body>
</html>
