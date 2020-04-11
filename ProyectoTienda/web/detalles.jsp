<%-- 
    Document   : detalles
    Created on : 13/11/2019, 12:22:46 PM
    Author     : gamma
--%>

<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
                HttpSession sesionOK = request.getSession();
                String username = (String) sesionOK.getAttribute("usuario");
                String priv = (String) sesionOK.getAttribute("priv");
                if(sesionOK.getAttribute("usuario") == null){
                    response.sendRedirect("index.jsp");
                }
                int idProducto = Integer.parseInt(request.getParameter("sku"));
                Producto aux = Sentencias.readProductoId(idProducto);
            %>
            
<!DOCTYPE html>
<html>
    <head>        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalles del Producto</title>
        <!--Scripts-->
	<!--Estilos-->
	<link rel="stylesheet" type="text/css" href="CSS/carrito.css">
        <link rel="stylesheet" type="text/css" href="CSS/universal.css">
	<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="CSS/detalles.css">
    </head>
    <body>        
            <jsp:include page="navbar.jsp" />                    
    <center>
        <div class="content-wrapper">
            <div class="container form">   
                <div class="row">
                    <div class="col-md-6 ">                        
                        <% 
                            out.print("<img class='img-div img-fluid rounded d-block m-l2-none' src='data:image/jpg;base64,"+aux.getFoto()+"'>");
                        %>                                                        
                        <br>
                    </div>
                        
                    <div class="col-md-6 product-info form-group">                        
                        <%      if(priv.equalsIgnoreCase("A")){%>
                        <div class='product-title'>Modificar Producto</div><hr>
                                <form action="ServletModProd" method="POST" >
                                        <% out.print("<input name='id' type='hidden' value='"+idProducto+"'>"); %>
                                        <div class="field-wrap">                                            
                                            Cambiar nombre:                                            
                                            <% out.print("<input name='nombre' class='form-control' type='text' value='"+aux.getNombre()+"'>"); %>

                                        </div>                                
                                        <div class="field-wrap">
                                            <label>
                                                Cambiar precio:<span class="req"></span>
                                            </label>
                                            <% out.print("<input name='precio' class='form-control' type='number' value='"+aux.getPrecio()+"'>"); %>
                                            <small id="emailHelp" class="form-text text-muted">mxn</small>
                                        </div>
                                        <div class="field-wrap">
                                                <label>
                                                    Cambiar stock:
                                                </label>
                                                <% out.print("<input name='stock' class='form-control' type='number' value='"+aux.getStock()+"'>");%>
                                                <small id="emailHelp" class="form-text text-muted">Unidades Disponibles</small>
                                            </div>
                                        <div class="field-wrap">
                                                <label>
                                                    Cambiar detalles:
                                                </label>
                                                <% out.print("<textarea class='form-control' name='detalles'>"+aux.getDetalles()+"</textarea>");%>
                                            </div>
                                    <input type='submit' value='Guardar Cambios' class='btn btn-success'>
                                </form>  
                                            
                          <%}else{
                              out.print("<div class='product-title'>"+aux.getNombre()+"</div>");
                              out.print("<div class='product-price'>$"+aux.getPrecio()+"</div>");
                              out.print("<div class='product-stock'>In Stock</div><hr>");
                              out.print("<div class='product-desc'>"+aux.getDetalles()+"</div><hr>");
                              
                              
                              out.print("<a href='ServletCarrito?accion=agregar&id="+aux.getId()+"'><button class='btn btn-success' onclick=\"agregar_carrito();\">Agregar al carrito</button></a><br>");
                                                                                                                                                                                                                          
                                
                         } %>                         
                    </div>
                </div>
                    </div>
                    </div>
            </center>
    </body>
</html>
