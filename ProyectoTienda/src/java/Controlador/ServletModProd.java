
package Controlador;

import Database.Sentencias;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "ServletModProd", urlPatterns = {"/ServletModProd"})

public class ServletModProd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()){
            int idProducto = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            Double precio = Double.parseDouble(request.getParameter("precio"));
            String detalles = request.getParameter("detalles");
            int stock = Integer.parseInt(request.getParameter("stock"));
            
            String patternStr = "</?[a-z][a-z0-9]*[^<>]*>";
            Pattern pattern = Pattern.compile(patternStr);
            
            Matcher matcher = pattern.matcher(nombre);
            boolean invalidNom = matcher.find();
            matcher.reset(detalles);
            boolean invalidDesc = matcher.find();
            
            if (invalidNom || invalidDesc){
                response.sendRedirect("detalles.jsp?sku="+idProducto);
                out.print("<script type='text/javascript'>alert('Error al modificar el producto');</script>");
            }else{
                if(Sentencias.updateProductInfo(nombre, precio, stock, detalles,idProducto)==1){
                    response.sendRedirect("productos.jsp");
                }else{
                    response.sendRedirect("detalles.jsp?sku="+idProducto);
                    out.print("<script type='text/javascript'>alert('Error al modificar el producto');</script>");
                }
            }
            
            
        }catch(Exception e){
            System.out.println("ERROR (ServletModProd.doPost): "+e);
            e.printStackTrace();
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
