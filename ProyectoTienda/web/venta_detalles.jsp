<%-- 
    Document   : venta_detalles
    Created on : 26/11/2019, 01:58:36 PM
    Author     : AnonimusCrack
--%>

<%@page import="Database.Sentencias"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = (String) sesionOK.getAttribute("usuario");
    String priv = (String) sesionOK.getAttribute("priv");
    String comprador;
    ResultSet Compra = (ResultSet) sesionOK.getAttribute("rs");
    if(sesionOK.getAttribute("usuario") == null){
        response.sendRedirect("index.jsp");
    }
    %>
    
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Detalle de la venta</title>
        <link rel="stylesheet" href="CSS/catalogo.css" type="text/css">
        <link rel="stylesheet" href="CSS/universal.css" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">             
        <link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <center>            
            <div>
                <%
                Compra.next();
                out.print("<h1>Venta con No.Pedido " +  Compra.getInt("noPedido") + " </h1>");
                %>
                <table>
                    <tr>
                        <td width='200'><center>Fecha:</center></td>
                        <td width='150'><center>Comprador:</center></td>
                    </tr>
                    <tr>
                    <%
                        out.print("<td><center> " + Compra.getTimestamp("fecha") + "</center></td>");
                        out.print("<td><center> " + Compra.getString("comprador") + "</center></td>");
                        comprador=Compra.getString("comprador");
                    %>
                    </tr>
                </table>
                <br><br><br>
                <table>
                    <tr>
                        <td width='50'><center>idProducto</center></td>
                        <td width='150'><center>Nombre del Producto</center></td>
                        <td width='50'><center>Cantidad</center></td>
                    </tr>
                    <%
                        do{
                            out.print("<tr>");
                            out.print("<td><center> " + Compra.getInt("idProducto") + "</center></td>");
                            out.print("<td><center> " + Compra.getString("nomProducto") + "</center></td>");
                            out.print("<td><center> " + Compra.getInt("cantidadProdcuto") + "</center></td>");
                            out.print("</tr>");
                        }while(Compra.next()); %>
                </table>
                <br>
                <br>
                <%if(priv.equals("A")){
                    out.print("Etiqueta de envio<div class='etiqueta'>");
                    ResultSet envio = Sentencias.datosEnvio(comprador);
                    while(envio.next()){
                        out.print(envio.getString("np")+ " " +envio.getString("ap")+ " " +envio.getString("am")+"<br>");
                        out.print(envio.getString("calle")+" "+envio.getInt("noExt")+" ");
                        if(envio.getInt("noInt")!=0){
                            out.print(envio.getInt("noInt")+"<br>");
                        }else{
                            out.print("<br>");
                        }
                        out.print(envio.getString("alc")+"<br>"+envio.getString("col")+"<br>");
                        out.print(envio.getString("edo")+" "+envio.getString("cd")+"<br>"+envio.getInt("cp"));
                    }
                    out.print("</div>");
                %>
                <br>
                <br>
                <a href="ventas.jsp"><font color="#000000" >Regresar</font></a>
                <%}else{%>
                    <a href="productos.jsp"><font color="#000000" >Regresar</font></a>
                <%}%>
            </div>
        </center>
    </body>
</html>
