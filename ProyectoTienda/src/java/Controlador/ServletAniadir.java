/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Database.Sentencias;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author saulg
 */
@WebServlet(name = "ServletAniadir", urlPatterns = {"/ServletAniadir"})
@MultipartConfig(location="/tmp", fileSizeThreshold=1024*1024,
        maxFileSize=1024*1024*5, maxRequestSize=1024*1024*5*5)
public class ServletAniadir extends HttpServlet {

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
        //response.setContentType("text/html;charset=UTF-8");
        response.setContentType("multipart/form-data;");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            
            
            String params[] = new String[5];
            params[0] = request.getParameter("nom");
            params[1] = request.getParameter("precio");
            params[2] = request.getParameter("stock");
            params[3] = request.getParameter("tipo");   
            System.out.println(params[3]);
            Part part = request.getPart("foto");
            InputStream foto = part.getInputStream();
            params[4] = request.getParameter("detalles");
                
            String patternStr = "</?[a-z][a-z0-9]*[^<>]*>";
            Pattern pattern = Pattern.compile(patternStr);
            
            Matcher matcher = pattern.matcher(params[0]);
            boolean invalidNom = matcher.find();
            matcher.reset(params[4]);
            boolean invalidDesc = matcher.find();
            if (invalidNom || invalidDesc){
                request.setAttribute("msg", "No se pudieron registrar sus datos");
                request.getRequestDispatcher("productos.jsp").forward(request, response);
            }else{
                if(Sentencias.insertarProducto(params, foto) == 1) {
                    response.sendRedirect("productos.jsp");
                } else {
                    request.setAttribute("msg", "No se pudieron registrar sus datos");
                    request.getRequestDispatcher("productos.jsp").forward(request, response);
                }
            }                                
            
        }
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
