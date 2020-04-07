<%-- 
    Document   : venta_detalles
    Created on : 26/11/2019, 01:58:36 PM
    Author     : AnonimusCrack
--%>

<%@page import="Modelos.Producto"%>
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
        <script src="js/html2pdf.bundle.min.js"></script>
        <script src="js/pdfConverter.js"></script>         
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <center>
                <div class="content-wrapper">
                    <div class="container form">
                        <div id="htmlToPDF">
                            <%
                                Compra.next();
                                comprador = Compra.getString("comprador");
                                Producto producto = Sentencias.readProductoId(Compra.getInt("idProducto"));
                                out.print("<h1 class='text-center'>Venta con No.Pedido " + Compra.getInt("noPedido") + " </h1><hr><br>");
                            %>
                            <div class="row">
                                <div class="col-md-6">

                                    <table class="table">

                                        <tr class="thead-dark">
                                            <th scope="col" class="thead-dark"><center>#</center></th>
                                            <% out.print("<td><center> " + Compra.getInt("noPedido") + "</center></td>"); %>                                                                                                                        
                                        </tr>                                              
                                        <tr class="thead-dark">
                                            <th scope="col" ><center>Fecha</center></th>
                                            <% out.print("<td><center id='fecha'> " + Compra.getTimestamp("fecha") + "</center></td>"); %>
                                        </tr>

                                        <tr class="thead-dark">
                                            <th scope="col"><center>Comprador</center></th>
                                            <% out.print("<td><center> " + Compra.getString("comprador") + "</center></td>"); %>                            
                                        </tr>
                                        <tr class="thead-dark">
                                            <%if (priv.equals("A")) {
                                                out.print("<th scope='col' ><center><br><br>Etiqueta de Envio</center></th>");                                        
                                                out.print("<td><center><div class='etiqueta'>");
                                                    ResultSet envio = Sentencias.datosEnvio(comprador);
                                                    while (envio.next()) {
                                                        out.print(envio.getString("np") + " " + envio.getString("ap") + " " + envio.getString("am") + "<br>");
                                                        out.print(envio.getString("calle") + " " + envio.getInt("noExt") + " ");
                                                        if (envio.getInt("noInt") != 0) {
                                                            out.print(envio.getInt("noInt") + "<br>");
                                                        } else {
                                                            out.print("<br>");
                                                        }
                                                        out.print(envio.getString("alc") + "<br>" + envio.getString("col") + "<br>");
                                                        out.print(envio.getString("edo") + " " + envio.getString("cd") + "<br>" + envio.getInt("cp"));
                                                    }
                                                    out.print("</div></center></td>");
                                            }%>
                                        </tr>                                                                     
                                    </table> 
                                </div>

                                <div class="col-md-5">
                                    <br><br><br>
                                    <%
                                        out.print("<img class='img-div img-fluid rounded d-block m-l2-none' src='assets/icons/logo.png'>");
                                    %>  
                                </div>
                                <div class="col-md-1">                                
                                </div>
                            </div>
                                <br>             
                                <h2>Productos</h2>
                                <div class="row">                                
                                    <div class="col-md-2"></div>
                                    <div class="col-md-8 ">

                                            <div class="card products-cards">                                        
                                                <div class="card-body">
                                                    <div class="row">                                                    
                                                        <div class="col-md-12 ">                                                        
                                                            <table class="table">
                                                                <thead class="thead-dark">
                                                                    <th>Imagen</th>
                                                                    <th>Nombre</th>
                                                                    <th>Precio</th>
                                                                    <th>Cantidad</th>
                                                                    <th>Subtotal</th>                                                                    

                                                                </thead>
                                                                <% float suma=0.0f;
                                                                    do { 
                                                                    producto = Sentencias.readProductoId(Compra.getInt("idProducto"));                                                                
                                                                    suma+=producto.getPrecio();
                                                                %>
                                                                    <tr class="thead-dark">      
                                                                        <td><% out.print("<img class='img-div img-fluid rounded d-block m-l2-none' src='data:image/jpg;base64," + producto.getFoto() + "'>"); %>  </td>
                                                                        <% out.print("<td><center><a href='ventas.jsp'>" + Compra.getString("nomProducto") + "</a></center></td>"); %>
                                                                        <% out.print("<td><center> " + producto.getPrecio() + "</center></td>"); %>
                                                                        <% out.print("<td><center> " + Compra.getInt("cantidadProdcuto") + "</center></td>"); %>
                                                                        <% out.print("<td><center> " + Compra.getInt("cantidadProdcuto")*producto.getPrecio() + "</center></td>"); %>                                                                
                                                                        
                                                                    </tr>
                                                                <% } while (Compra.next()); %>                                                                                                                         
                                                                <tr>
                                                                    <td><center></center></td>
                                                                    <td><center></center></td>
                                                                    <td><center></center></td>
                                                                    <td><center>Total: </center></td>
                                                                    <td><center><%out.print(suma);%></center></td>
                                                                    
                                                                </tr>
                                                            </table>
                                                        </div>                                            
                                                    </div>                                            
                                                </div>
                                            </div>

                                    </div>
                                    <div class="col-md-2"></div>
                            </div>                            
                            <br>
                        </div>                        
                        <% if (priv.equals("A")) { %>                                
                            <a href="ventas.jsp"><button type='button' class='btn btn-dark btn-lg'>Regresar</button></a>                            
                            <button type='button' onclick="savePDF()" id='create_pdf' class='btn btn-dark btn-lg '>Descargar PDF</button>
                        <%} else {%>
                            <a href="productos.jsp"><font color="#000000" >Regresar</font></a>
                        <%}%>
                </div>                
            </div>
        </center>
    </body>
</html>
