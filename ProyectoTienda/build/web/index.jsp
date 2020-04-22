<%-- 
    Document   : index.jsp
    Created on : 26/10/2019, 04:14:51 PM
    Author     : García Medina Saúl
                 Sánchez Castro Aarón Gamaliel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>

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
        <title>Inicia sesión</title>
        <link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="CSS/normalize.min.css">
        <link rel="stylesheet" href="CSS/style2.css">
    </head>
    <body>
        <div class="form">
            <noscript>
                <h1>Por favor, habilite Javascript o utilice un navegador compatible</h1>
            </noscript>
            <ul class="tab-group">
              <li class="tab active"><a href="#signup">Regístrate</a></li>
              <li class="tab"><a href="#login">Iniciar Sesión</a></li>
            </ul>
            <div class="tab-content">
                <div id="signup">   
                    <h1>¡Únete!</h1>
                    <form action="ServletRegistro" method="POST">          
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                Usuario<span class="req"></span>
                            </label>
                            <input type="text" name="username" id="username" autocomplete="off" maxlength="30"
                                   pattern="[A-Za-z0-9-_]+" title="Únicamente letras (sin acentos), númemros, -, _ y no más de 30 caracteres"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Nombre<span class="req"></span>
                            </label>
                            <input type="text" name="np" id="np" autocomplete="off" required maxlength="70"
                                   pattern="[a-zA-ZáéíóúÁÉÍÓÚ]+" title="Únicamente letras y máximo 70 caracteres"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                              Apellido paterno<span class="req"></span>
                            </label>
                            <input type="text" name="ap" id="ap" required autocomplete="off" maxlength="30"
                                   pattern="[a-zA-ZáéíóúÁÉÍÓÚ]+" title="Únicamente letras y máximo 35 caracteres"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Apellido materno<span class="req"></span>
                            </label>
                            <input type="text" name="am" id="am" required autocomplete="off" maxlength="30"
                                   pattern="[a-zA-ZáéíóúÁÉÍÓÚ]+" title="Únicamente letras y máximo 35 caracteres"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                Calle<span class="req"></span>
                            </label>
                            <input type="text" name="calle" id="calle" required autocomplete="off" maxlength="30"
                                   pattern="[a-zA-Z0-9áéíóúÁÉÍÓÚ]+" title="Únicamente letras, números y máximo 30 caracteres"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                No. Exterior<span class="req"></span>
                            </label>
                            <input type="number" required autocomplete="off" name="noExt" id="noExt" min="0" 
                                   title="Únicamente números positivos"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                No. Interior<span class="req"></span>
                            </label>
                            <input type="number" required autocomplete="off" name="noInt" id="noInt" min="0"
                                   title="Únicamente números positivos"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Colonia<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="col" id="col" maxlength="100"
                                   pattern="[a-zA-Z0-9\s\.áéíóúÁÉÍÓÚ]+" title="Únicamente letras, números y máximo 100 caracteres"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                Alcaldía<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="alc" id="alc" maxlength="255"
                                   pattern="[a-zA-ZáéíóúÁÉÍÓÚ\s\.]+" title="Únicamente letras y máximo 255 caracteres"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Municipio<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="muni" id="muni" maxlength="255"
                                   pattern="[a-zA-ZáéíóúÁÉÍÓÚ\s\.]+" title="Únicamente letras y máximo 255 caracteres"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                Estado<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="edo" id="edo" maxlength="100"
                                   pattern="[a-zA-ZáéíóúÁÉÍÓÚ\s\c]+" title="Únicamente letras y máximo 100 caracteres"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Ciudad<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="cd" id="cd" maxlength="255"
                                   pattern="[a-zA-ZáéíóúÁÉÍÓÚ\s\.]+" title="Únicamente letras y máximo 255 caracteres"/>
                        </div>
                    </div>
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                Código Postal<span class="req"></span>
                            </label>
                            <input type="number" required autocomplete="off" name="cp" id="cp" min="0"
                                   title="Únicamente números positivos"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Teléfono<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="tel" id="tel" maxlength="10" minlength="10"
                                   pattern="[0-9]" title="Únicamente números de 10 dígitos"/>
                        </div>
                    </div>
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                Contraseña<span class="req"></span>
                            </label>
                            <input type="password" required autocomplete="off" name="pass" id="pass" maxlength="30"
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" 
                                   title="Al menos un número, al menos una letra mayúscula y una minúscula, al menos 8 caracteres y máximo 30"/>
                        </div>
                    </div>                    
                        <br>                    
                    <button type="submit" class="button button-block"/>Registrarse</button>
                    </form>
                </div>
                
                <div id="login">   
                    <h1>¡Bienvenido!</h1>          
                    <form action="ServletLoguin?accion=loguin" method="POST">
                        <input type="hidden" name="accion" value="loguin"/>
                        <div class="field-wrap">
                            <label>
                              Usuario<span class="req"></span>
                            </label>
                            <input type="text"required autocomplete="off" name="username"  maxlength="30"
                                   pattern="[A-Za-z0-9-_]+" title="Únicamente letras (sin acentos), númemros, -, _ y no más de 30 caracteres"/>
                        </div>
                        <div class="field-wrap">
                        <label>
                          Contraseña<span class="req" ></span>
                        </label>
                        <input type="password"required autocomplete="off" name="pass" maxlength="30"
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,30}" 
                                   title="Al menos un número, al menos una letra mayúscula y una minúscula, al menos 8 caracteres y máximo 30"/>
                        </div>
                        <button class="button button-block"/>Iniciar Sesión</button>
                    </form>
                </div>
            </div><!-- tab-content -->
        </div> <!-- /form -->
        <script src='js/jquery.min.js'></script>
        <script src="js/index.js"></script>
             <%
              if(request.getAttribute("msg")!=null)
                 out.println(request.getAttribute("msg"));
             %>        
    </body>
</html>
