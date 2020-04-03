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
            <title>Catálogo de productos</title>
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
                                <th scope="col">#</th>
                                <th scope="col">Fecha</th>
                                <th scope="col">Comprador</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td>Mark</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td>Jacob</td>
                                <td>Thornton</td>
                                <td>@fat</td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td>Larry</td>
                                <td>the Bird</td>
                                <td>@twitter</td>
                            </tr>
                        </tbody>
                    </table>

                    <table class="table">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">First</th>
                                <th scope="col">Last</th>
                                <th scope="col">Handle</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td>Mark</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td>Jacob</td>
                                <td>Thornton</td>
                                <td>@fat</td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td>Larry</td>
                                <td>the Bird</td>
                                <td>@twitter</td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <table>
                        <tr>
                            <td width='50'><center>noPedido</center></td>
                        <td width='200'><center>Fecha</center></td>
                        <td width='150'><center>Comprador</center></td>
                        <td width='70'><center>&nbsp</center></td>
                        </tr>
                        <%
                            try {
                                int k = 1;
                                ResultSet rs = Sentencias.Ventas();
                                while (rs.next()) {
                                    out.print("<tr>");
                                    out.print("<td><center> " + rs.getInt("noPedido") + " </center></td>");
                                    out.print("<td><center> " + rs.getTimestamp("fecha") + " </center></td>");
                                    out.print("<td><center> " + rs.getString("comprador") + " </center></td>");
                                    out.print("<td><center><a href='ServletVentas?accion=mostrar&id=" + rs.getInt("noPedido") + "'><button class='add_cart'>Mostrar</button></a></center></td>");
                                    out.print("</tr>");
                                }
                            } catch (Exception e) {
                            }
                        %>
                    </table>
                </div>
            </div>
        </center>         
    </body>
</html>
