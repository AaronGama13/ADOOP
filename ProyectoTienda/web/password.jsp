<%-- 
    Document   : password
    Created on : 25/03/2020, 09:02:04 PM
    Author     : sistemas2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        
        <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card card-default">
          <div class="card-header">
              Cambiar contraseña
          </div>
          <div class="card-body">
        
  <div class="user-new">
      <form action="ServletCambioPassword" method="POST"> 
      <table class="table">
           <tr>
              <th>Contraseña</th>
              <td>
                <input type="password" class="form-control" placeholder="Contraseña" autocomplete="off" name="password" id="password" >
              </td>
            </tr>
           <tr>
              <th>Confirma contraseña</th>
              <td>
                <input type="password" class="form-control"  placeholder="Confirmar contraseña" autocomplete="off"  name="passwordConfirm" id="passwordConfirm" >
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
              
          </div>
        </div>
      </div>
    </div>
  </div>
        
        
    </body>
</html>
