<%-- 
    Document   : productos
    Created on : 26/10/2019, 05:28:33 PM
    Author     : gamma
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

    <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Catálogo de productos</title>            
            <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet"> 
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">            
            <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
            <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
            
            <link rel="stylesheet" type="text/css" href="CSS/carrito.css">
        <link rel="stylesheet" type="text/css" href="CSS/universal.css">
	<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="CSS/detalles.css">
    </head>
    
        <%
            if (sesionOK.getAttribute("usuario") != null) {
                username = (String) sesionOK.getAttribute("usuario");
                priv = (String) sesionOK.getAttribute("priv");
                if(priv.equalsIgnoreCase("u")){
                    Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
                    Cantidad = (int[][]) sesionOK.getAttribute("Cantidad");
                    msj = (String) sesionOK.getAttribute("msj");
                
        %>        
                    <nav class="navbar navbar-expand-lg  ">
                        <div class="collapse navbar-collapse">
                            <ul class="navbar-nav mr-auto">
                                <li class="navbar-item">
                                    <img src="assets/icons/logo.png" class="logo">
                                </li>
                                <li class="navbar-item">
                                    <a class="nav-link products-link" href="productos.jsp">Productos</a>
                                </li>                                
                            </ul>          
                            <a href='carrito.jsp'><img src='assets/icons/cart.png' class='cart'></a>
                            <div class="dropdown">                                
                                
                                    <button class="btn btn-default dropdown-toggle text-white" type="button" id="menu1" data-toggle="dropdown">
                                        <% out.print(username); %>
                                        <img src='assets/icons/profile.png' class='profile'>
                                        <span class="caret"></span>
                                    </button>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li><a href='password.jsp'>Cambiar contraseña</a></li>
                                    <li><a href="cuenta.jsp">Cuenta</a></li>
                                </ul>
                            </div>                                                                                     

                        </div>
                    </nav>	
        <%      } else if(priv.equalsIgnoreCase("A")){ %>
                    <nav class="navbar navbar-expand-lg  ">
                        <div class="collapse navbar-collapse">
                            <ul class="navbar-nav mr-auto">
                                <li class="navbar-item">
                                    <img src="assets/icons/logo.png" class="logo">
                                </li>
                                <li class="navbar-item">
                                    <a class="nav-link products-link" href="productos.jsp">Productos</a>                                    
                                </li>
                                <li class="navbar-item">
                                    <a class="nav-link products-link" href="aniadir_producto.jsp">Agregar Producto</a>
                                </li>
                                <li class="navbar-item">
                                    <a class="nav-link products-link" href="ventas.jsp">Ventas</a>                                    
                                </li>
                            </ul>                                      
                            <div class="dropdown">                                                                
                                    <button class="btn btn-default dropdown-toggle text-white" type="button" id="menu1" data-toggle="dropdown">
                                        <% out.print(username); %>
                                        <img src='assets/icons/profile.png' class='profile'>
                                        <span class="caret"></span>
                                    </button>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li><a href='password.jsp'>Cambiar contraseña</a></li>
                                    <li><a href="cuenta.jsp">Cuenta</a></li>
                                </ul>
                            </div>                                                                                     

                        </div>
                    </nav>
        <%      }else{  %>
                    <nav class="navbar navbar-expand-lg  ">
                        <div class="collapse navbar-collapse">
                            <ul class="navbar-nav mr-auto">
                                <li class="navbar-item">
                                    <img src="assets/icons/logo.png" class="logo">
                                </li>
                                <li class="navbar-item">
                                    <a class="nav-link products-link" href="productos.jsp">Productos</a>
                                </li>                          
                            </ul>                
                            <a class='nav-link products-link' href='index.jsp'>Registrarse / Iniciar sesión</a>                

                        </div>
                    </nav>

                <%}
            }else{ 
        %>            
                <nav class="navbar navbar-expand-lg  ">
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav mr-auto">
                            <li class="navbar-item">
                                <img src="assets/icons/logo.png" class="logo">
                            </li>
                            <li class="navbar-item">
                                <a class="nav-link products-link" href="productos.jsp">Productos</a>
                            </li>                          
                        </ul>                
                        <a class='nav-link products-link' href='index.jsp'>Registrarse / Iniciar sesión</a>                

                    </div>
                </nav>	
        <%  } 
             %>        