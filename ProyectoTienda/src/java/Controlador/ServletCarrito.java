/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Database.Sentencias;
import Modelos.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.*;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ServletCarrito", urlPatterns = {"/ServletCarrito"})
public class ServletCarrito extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            
            int idProducto = Integer.parseInt(request.getParameter("id"));
            String accion = request.getParameter("accion");
            HttpSession sesion = request.getSession();
            int[][] Cantidad = (int [][]) sesion.getAttribute("Cantidad");
            ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
            
            if(accion.equals("agregar")){
                Producto aux = Sentencias.readProductoId(idProducto);
                if(Carrito == null)
                    Carrito = new ArrayList<Producto>();  
                Carrito.add(aux);
                Cantidad = SacarCantidad(Carrito);
                sesion.setAttribute("Carrito", Carrito);
                sesion.setAttribute("Cantidad", Cantidad);
                response.sendRedirect("productos.jsp");
            }
            else if(accion.equals("quitar")){
                Producto aux = Sentencias.readProductoId(idProducto);
                //int i = Carrito.indexOf((Object) aux);
                //if(Carrito == null)
                //    Carrito = new ArrayList<Producto>();
                
                for(int i = 0; i < 100; i++){
                    if(Cantidad[i][0] == aux.getId())
                    {
                        Cantidad[i][1]--;
                        if(Cantidad[i][1] <= 0){
                            for(int k = i; k < 99; k++){
                                if(Cantidad[k+1][0] == 0)
                                    break;
                                Cantidad[k][0] = Cantidad[k+1][0];
                                Cantidad[k][1] = Cantidad[k+1][1];
                            }
                        }
                        break;
                    }
                }
                sesion.setAttribute("Cantidad", Cantidad);
                response.sendRedirect("carrito.jsp");
            }
            else if(accion.equals("eliminar")) {
                if(Sentencias.eliminarProducto(idProducto)){
                    response.sendRedirect("productos.jsp");
                } else {
                    response.sendRedirect("productos.jsp");
                    out.print("<script>alert('No se pudo eliminar el producto')</script>");
                }
            }
            else if(accion.equals("Tarjeta")){
                if(idProducto == 0){
                    sesion.setAttribute("Tarjeta", "VISA");
                    System.out.println("ES UNA VISA");
                    response.sendRedirect("hacer_compra.jsp");
                }                    
                else if(idProducto == 1){
                    System.out.println("ES UNA MASTERCARD");
                    sesion.setAttribute("Tarjeta", "Mastercard");
                    response.sendRedirect("hacer_compra.jsp");
                }
            }
        } catch(Exception e){
            System.out.println("ERROR (ServletCarrito.doGet): "+e);
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            String username = (String) sesion.getAttribute("usuario");
            int dcto = Integer.parseInt(request.getParameter("descuento"));
            ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
            String Tarjeta = (String) sesion.getAttribute("Tarjeta");
            if(Carrito == null || Carrito.isEmpty()){
                response.sendRedirect("carrito.jsp?msj=Selecciona%20al%20menos%20un%20producto%20para%20comprar");
                return;
            }
            else if(Tarjeta.equals("")){
                response.sendRedirect("hacer_compra.jsp?msj=Seleccione%20el%20tipo%20de%20tarjeta");
                return;
            }
            
            String anio = request.getParameter("anio");
            String mes = request.getParameter("mes");
            SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-DD");
            Date sFech =  formateador.parse(anio+"-"+mes+"-01");
            String aux2 = formateador.format(new Date());
            Date fechaActual =  formateador.parse(aux2);

            String sNum =  request.getParameter("NumTarjeta");            
            sNum = sNum.replace(" ","");
            if(sNum.length() != 16){
                response.sendRedirect("hacer_compra.jsp?msj=Tarjeta%20no%20valida");
                return;
            }
            if(sFech.before(fechaActual)){
                response.sendRedirect("hacer_compra.jsp?msj=Tarjeta%20vencida");
                return;
            }
            for(int i = 0; i < 16; i++){
                if (!Character.isDigit(sNum.charAt(i))){
                    response.sendRedirect("hacer_compra.jsp?msj=Tarjeta%20no%20valida");
                    return;
                }
            }
            if(sNum.charAt(0) != '4' && Tarjeta.equals("VISA")){
                response.sendRedirect("hacer_compra.jsp?msj=Tarjeta%20VISA%20no%20valida");
                return;
            }
            int aux = Integer.parseInt(Character.toString(sNum.charAt(0)) + Character.toString(sNum.charAt(1)));
            if(!(aux > 50 && aux < 56) && Tarjeta.equals("Mastercard")){
                response.sendRedirect("hacer_compra.jsp?msj=Tarjeta%20Mastercard%20no%20valida");
                return;
            }
            //Ingresar valor a la tabla
            int[][] Cantidad = SacarCantidad(Carrito);
            String msj = Sentencias.insertarCompra(username,Cantidad,dcto);
            //if(msj.equals("Compra realizada con éxito"))
            //    Carrito.clear();
            //sesion.setAttribute("msj", msj);
            //sesion.setAttribute("Carrito", Carrito);
            int Pedido = Sentencias.maxNoPedido() - 1;
            ResultSet Compra = Sentencias.NoVenta(Pedido);
            sesion.setAttribute("Carrito", null);
            sesion.setAttribute("Cantidad", null);
            sesion.setAttribute("rs",Compra);
            response.sendRedirect("venta_detalles.jsp");
       }catch(Exception e){
            System.out.println("ERROR (Sentencias.readProductos): "+e);
            e.printStackTrace();
        }
    }
    
    public static int[][] SacarCantidad(ArrayList<Producto> Carrito){
        int[][] Cantidad = new int [100][2];
        int k = 0; 
        ciclo:
        for(Producto p : Carrito){
            for(int i = 0; i < 100; i++){
                if(Cantidad[i][0] == p.getId()){
                    Cantidad[i][1]++;
                    continue ciclo;
                }
                if(Cantidad[i][0] == 0){
                    k = i;
                    break;
                }
            }
            Cantidad[k][0] = p.getId();
            Cantidad[k][1] = 1;
        }
        return Cantidad;
    }
    
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
