<%-- 
    Document   : ventas
    Created on : 26/11/2019, 12:40:49 PM
    Author     : AnonimusCrack
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = (String) sesionOK.getAttribute("usuario");
    String priv = (String) sesionOK.getAttribute("priv");
    if(sesionOK.getAttribute("usuario") == null){
        response.sendRedirect("index.jsp");
    }
    %>
    
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ventas</title>
        <link rel="stylesheet" href="CSS/catalogo.css" type="text/css">
        <link rel="stylesheet" href="CSS/universal.css" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">             
        <link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <center>
            <div class="content-wrapper">
                <div class="container form">   
                    <h1>Ventas Realizadas</h1><hr><br>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col"><center>#</center></th>
                                <th scope="col"><center>Fecha</center></th>
                                <th scope="col"><center>Comprador</center></th>
                                <th scope="col"><center>Ver</center></th>
                            </tr>
                        </thead>
                        <tbody>                            
                            <%
                                try {
                                    int k = 1;
                                    ResultSet rs = Sentencias.Ventas();
                                    while (rs.next()) {
                                        out.print("<tr>");
                                        out.print("<th scope='row' ><center> " + rs.getInt("noPedido") + " </center></th>");
                                        out.print("<td><center> " + rs.getTimestamp("fecha") + " </center></td>");
                                        out.print("<td><center> " + rs.getString("comprador") + " </center></td>");
                                        out.print("<td><center><a href='ServletVentas?accion=mostrar&id=" + rs.getInt("noPedido") + "'>"
                                                + "<button type='button' class='btn btn-dark'>Mostrar</button></a></center></td>");
                                        out.print("</tr>");
                                    }
                                } catch (Exception e) {
                                }
                            %>
                        </tbody>
                    </table>                    
                    
                    
                </div>
            </div>
        </center>         
    </body>
</html>
