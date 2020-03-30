
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username;
    if(sesionOK.getAttribute("usuario") != null){
        username = (String) sesionOK.getAttribute("usuario");
    }
    %>

<!DOCTYPE html>
<html>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ajustes</title>
 </head>
   <body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                 <div class="card card-default">
                    <div class="card-header">
                        Cambiar Informacion
                    </div>

                    <div class="card-body">
                        <div class="user-new">
                                <form action="ServletCambiaInfo" method="POST"> 
                                    <table class="table">
                                        <tr>
                                            <th>Nombre de Usuario</th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Usuario" autocomplete="off" name="username" id="username" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Nombre </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Nombre" autocomplete="off" name="np" id="np" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Apellido Paterno </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Apellido Paterno" autocomplete="off" name="ap" id="ap" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Apellido Materno </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Apellido Materno" autocomplete="off" name="am" id="am" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Calle </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Calle" autocomplete="off" name="calle" id="calle" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>No. Exterior </th>
                                            <td>
                                                <input type="number" class="form-control" placeholder="No. Exterior" autocomplete="off" name="noExt" id="noExt" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>No. Interior </th>
                                            <td>
                                                <input type="number" class="form-control" placeholder="No. Interior" autocomplete="off" name="noInt" id="noInt" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Colonia </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Colonia" autocomplete="off" name="col" id="col" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Alcaldía </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Alcaldía" autocomplete="off" name="alc" id="alc" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Municipio </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Municipio" autocomplete="off" name="muni" id="muni" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Estado </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Estado" autocomplete="off" name="muni" id="muni" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Ciudad </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Ciudad" autocomplete="off" name="cd" id="cd" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Código Postal </th>
                                            <td>
                                                <input type="number" class="form-control" placeholder="Código Postal" autocomplete="off" name="cp" id="cp" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Teléfono </th>
                                            <td>
                                                <input type="text" class="form-control" placeholder="Teléfono" autocomplete="off" name="tel" id="tel" >
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="text-right">
                                                <input type="submit"  value="Guardar" class="btn btn-primary">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-center">
                                                <%
                                                if(request.getAttribute("msg")!=null)
                                                    out.println(request.getAttribute("msg"));
                                                %>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </form>
                                </div>

                                <div class="card card-default">
                                    <div class="card-header">
                                        Eliminar cuenta
                                    </div>

                                    <div>
                                        <label>Para eliminar su cuenta introduzca su usuario y contraseña</label>
                                    </div>
                                     <div class="card-body">
                                        <div class="user-new">
                                            <form action="ServletLoguin?accion=borrar" method="POST">
                                                <table class="table">
                                                    <tr>
                                                        <th>Usuario</th>
                                                        <td>
                                                            <input type="text" name="username" placeholder="Usuario">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Contraseña</th>
                                                        <td>
                                                            <input type="password" name="pass" placeholder="Contraseña">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-right">
                                                            <input type="submit" value ="Borrar" name="Borrar" class="btn btn-primary">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>
