
package Controlador;

import Database.Sentencias;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author gamma
 */
public class ServletBorrarUsu extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("usuario");
        System.out.println(username);
        if(Sentencias.borrarUsuarioAdmin(username)){
            response.sendRedirect("ver_usuarios.jsp");
        }else{
            try(PrintWriter out = response.getWriter()){
                out.print("<script>alert('Ha ocurrido un error al intentar eliminar el usuario)'</script>");
                response.sendRedirect("ver_usuarios.jsp");
            }
        }
    }

}
