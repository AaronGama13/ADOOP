
package Controlador;

import Database.Sentencias;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author martinalonso
 */
@WebServlet(name = "ServletCambiaInfo", urlPatterns = {"/ServletCambiaInfo"})
public class ServletCambiaInfo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesionOK = request.getSession();
        try (PrintWriter out = response.getWriter()) {

            String [] params = new String[15];
            
            params[0] = request.getParameter("username");
            params[1] = "a";
            params[2] = request.getParameter("np");
            params[3] = request.getParameter("ap");
            params[4] = request.getParameter("am");
            params[5] = request.getParameter("calle");
            params[6] = request.getParameter("noExt");
            params[7] = request.getParameter("noInt");
            params[8] = request.getParameter("col");
            params[9] = request.getParameter("alc");
            params[10] = request.getParameter("muni");
            params[11] = request.getParameter("edo");
            params[12] = request.getParameter("cd");
            params[13] = request.getParameter("cp");
            params[14] = request.getParameter("tel");
            params[15] = (String) sesionOK.getAttribute("usuario");
            

        if(Sentencias.updateUsuario2(params)==1){
                response.sendRedirect("ajustes.jsp");
            }else {
                request.setAttribute("msg", "No se pudo cambiar la informacion");
                request.getRequestDispatcher("ajustes.jsp").forward(request, response);
            } 




        } //catch

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
