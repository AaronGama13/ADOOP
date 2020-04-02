<%-- 
    Document   : hacer_compra
    Created on : 1/04/2020, 11:38:41 PM
    Author     : saulg
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="Database.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = "";
    String priv = "";
    String msj = "";
    ArrayList<Producto> Carrito = new ArrayList<Producto>();
    int[][] Cantidad = new int[100][2];
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--Scripts-->
        <!--CSS-->
        <link rel="stylesheet" type="text/css" href="CSS/hacer_compra.css">
        <title>Hacer compra</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <section id="contenedor">
            <div id="detalles">
                <h4>Pagar</h4>          
                <form action="" method="post">
                    <span>Ingrese los datos de su tarjeta de crédito</span>
                    <input type="text" name="nom-tarjeta" placeholder="Nombre en la tarjeta" id="nom-tarjeta">
                    <input type="number" name="num-tarjeta" placeholder="Número de la tarjeta"
                           id="num-tarjeta">
                    <select id="mes">
                        <option value="MM" selected="">MM</option>
                        <%for(int i = 1; i <= 12; i++){  
                            if(i < 10){
                                out.print("<option value='0"+ i +"'>0"+ i +"</option>");
                            } else {
                                out.print("<option value='" + i + "'>"+ i +"</option>");
                            }
                        }%>                        
                    </select>
                    <select id="anio">
                        <option value="AAAA" selected>AAAA</option>
                        <%for(int i = 2020; i <= 2040; i++){  
                            out.print("<option value='"+ i +"'>"+ i +"</option>");
                        }%>
                    </select>
                    <input type="number" max="3" id="cvc" placeholder="CVC">
                </form>
            </div>                 
            <div id="resumen">
                <h4>Resumen</h4>
                <span>Precio original</span>
                <span class="span-precio">$1000</span>
                <span>Descuento</span>
                <span class="span-precio">-$100</span><hr>
                <span>Total</span>
                <span class="span-precio">$900</span>
                <form action="action">
                    <input type="submit" id="comprar" value="Realizar pago" name="comprar">
                </form>
            </div> 
        </section>
    </body>
</html>
