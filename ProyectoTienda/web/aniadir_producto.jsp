<%-- 
    Document   : aniadir_producto
    Created on : 15/11/2019, 08:59:37 PM
    Author     : saulg
--%>
<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = "";
    String priv = "";    
    if(sesionOK.getAttribute("usuario") != null){
        username = (String) sesionOK.getAttribute("usuario");
        priv = (String) sesionOK.getAttribute("priv");        
    }else{
        response.sendRedirect("productos.jsp");
    }
    %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalles del Producto</title>
        <!--Scripts-->
        <script type="text/javascript" src="js/validacionNumeros.js"></script>
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
                        <div class="col-md-2"></div>
                        <div class="col-md-8 product-info form-group details-container">                        
                            <% if(priv.equalsIgnoreCase("A")){%>                                                       


                            <form id="formu" action="ServletAniadir" method="POST" onsubmit="return validarNum();" enctype="multipart/form-data">

                                                    <div class='product-title text-center'>Agregar Producto</div><hr>
                                                    <div class="field-wrap">                                            
                                                        Nombre:                                            
                                                        <input name="nom" class='form-control' type='text'>
                                                    </div>                                
                                                    <div class="field-wrap">                                                
                                                        Precio:
                                                        <input name='precio' id="precioo" class='form-control' type='number' step="0.01">
                                                        <small id="moneda" class="form-text text-muted">mxn</small>
                                                    </div>
                                                    <div class="field-wrap">                                                    
                                                        Stock:                                                    
                                                        <input name='stock' id="stockk" class='form-control' type='number' >
                                                        <small id="unidades" class="form-text text-muted">Unidades Disponibles</small>
                                                    </div>
                                                    <div class="field-wrap">                                                    
                                                        Tipo de Producto:
                                                        <select class="form-control" name='tipo'>
                                                          <option value="L">Libro</option>
                                                          <option value="P">Pelicula</option>
                                                          <option value="M">Musica</option>                                                          
                                                        </select>                                                        
                                                    </div>
                                                    <div class="field-wrap">                                                    
                                                        Imagen
                                                        <input type="file" name="foto" class='form-control' required>
                                                    </div>
                                                    <div class="field-wrap">
                                                        Detalles:
                                                        <textarea spellcheck="true" class='form-control' name='detalles'></textarea>
                                                    </div>
                                                    <input type='submit' value='Agregar Producto' class='btn btn-success'>                                                                                        
                                            </form>

                            <%} %>
                        </div>                        
                        <div class="col-md-2"></div>
                    </div>
                        </div>
                        </div>
                </center>
                                        
    </body>
</html>

