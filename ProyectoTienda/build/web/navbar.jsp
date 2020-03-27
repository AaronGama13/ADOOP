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
<html>
    <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Catálogo de productos</title>
            <link rel="stylesheet" href="CSS/catalogo.css" type="text/css">
            <link rel="stylesheet" href="CSS/universal.css" type="text/css">
            <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet"> 
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg  ">
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="navbar-item">
                        <img src="assets/icons/logo.png" class="logo">
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link products-link" href="productos.jsp">Productos</a>
                    </li>
                    <c:if test=" sesionOK.getAttribute('usuario') != null">
                        
      <li class="nav-item dropdown  ">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <%
                    if(sesionOK.getAttribute("usuario") != null){
                    username = (String) sesionOK.getAttribute("usuario");
                        out.print(username);
                    }
            %>    
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a href='password.jsp'>Cambiar contraseña</a>
        </div>
      </li>
                        
                    </c:if>          
                </ul>
                <%
                    if(sesionOK.getAttribute("usuario") != null){
                        //RECUPERAMOS LOS DATOS DE LA SESIÓN
                    username = (String) sesionOK.getAttribute("usuario");
                    priv = (String) sesionOK.getAttribute("priv");
                    if(!priv.equals("A")){
                        Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
                        Cantidad = (int[][]) sesionOK.getAttribute("Cantidad");                
                        msj = (String) sesionOK.getAttribute("msj");
                        out.print("<a href='ajustes.jsp'><img src='assets/icons/profile.png' class='profile'></a>");
                        out.print("<a href='carrito.jsp'><img src='assets/icons/cart.png' class='cart'></a>");
                    }
                    }else{
                        out.print("<a class='nav-link products-link' href='index.jsp'>Registrarse / Iniciar sesión</a>");    
                    }
            %>    
            </div>
        </nav>	
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>