<%-- 
    Document   : carrito
    Created on : 26/10/2019, 05:55:09 PM
    Author     : gamma
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page import="Database.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    
    String username = null ,priv = null;
    ArrayList<Producto> Carrito = null;
    Double total = 0.0;
    ArrayList <Integer> Cantidad = null;
    if(sesionOK.getAttribute("usuario")!=null){
        username = (String) sesionOK.getAttribute("usuario");
        priv = (String) sesionOK.getAttribute("priv");
        Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
        Cantidad = (ArrayList<Integer>) sesionOK.getAttribute("Cantidad");
    }
    
    if(priv.equals("A")){
        response.sendRedirect("productos.jsp");
        out.print("<script type='text/javascript'>alert('No tienes permiso para entrar al carrito');</script>");
    }
    
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--Scripts-->
	<!--Estilos-->
	<link rel="stylesheet" type="text/css" href="CSS/carrito.css">
        <link rel="stylesheet" type="text/css" href="CSS/universal.css">
	<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css">
    </head>
    <body>
        <!--Cabecera-->
	<jsp:include page="navbar.jsp" />	
	<div class="clearfix"></div>
	<section id="global">
		<div id="carrito">
			<header id="tu-carrito">
				<h1>Tu carrito</h1>
				<div class="carroC">	
					<img src="assets/icons/cart.png">
				</div>
				<div class="clearfix"></div>
			</header>
			<div id="productos">
                            <%
                            try{
                                out.print("<ul id='lista-productos'>");
                                for(Producto p: Carrito) {
                                    out.print("<div class='articulo'>");    
                                    out.print("<li>");
                                    out.print("<img src='data:image/jpg;base64, " + p.getFoto() + "'id='imagen'>");
                                    out.print("<div id='descripcion'>");
                                    out.print("<p>" + p.getNombre() + "</p>");
                                    out.print("</div>");
                                    out.print("<div id='precio'>");
                                    out.print("<p>$" + p.getPrecio() + "</p>");
                                    out.print("</div><br><br>");
                                    out.print("<div id='btn-remover'>");
                                    out.print("<form method='get' action='ServletCarrito'>");
                                    out.print("<input type='hidden' name='accion' value='quitar'>");
                                    out.print("<input type='hidden' name='id' value='"+ p.getId() +"'>");
                                    out.print("<input type='submit' name='remover' id='remover' value='remover'>");                                        
                                    out.print("</form>");
                                    out.print("</div>");
                                    out.print("</li>");
                                    out.print("<div class='clearfix'></div>");
                                    out.print("</div><hr>");
                                    total = total + (p.getPrecio()*Cantidad.get(Carrito.indexOf(p)));
                                }
                                out.print("</ul>");
                                sesionOK.setAttribute("total",total);
                            }catch(Exception e){
                                System.out.println("Error perro " + e);
                            }
                            %>
			</div>
		</div>
		<div id="subtotal">
			<div id="resumen">
				<h1>resumen</h1>
			</div>
			<div id="total">
				<span>Total a pagar</span><br>
				<span>$<%out.print(total);%>mxn</span>
			</div>
			<div id="pagar">				
                            <a href="hacer_compra.jsp" id="btn-pagar">Pagar</a>                                        
                            <button id="btn-vaciar"><a href="ServletCarrito?id=0&accion=Vaciar" class="vaciar">Vaciar carrito</a></button>
			</div>
                    <button id="seguir-comprando"><a href="productos.jsp">Seguir comprando</a></button>
		</div>
		<div class="clearfix"></div>
	</section>
    </body>
</html>
