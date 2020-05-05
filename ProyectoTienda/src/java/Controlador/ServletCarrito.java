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
            ArrayList<Integer> Cantidad = (ArrayList<Integer>) sesion.getAttribute("Cantidad");
            ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
            
            if(accion.equals("agregar")){
                Producto aux = Sentencias.readProductoId(idProducto);
                System.out.println("Quieren agregar "+aux.getNombre()+" con id="+aux.getId());
                int index = 0;
                if(Carrito == null){
                    System.out.println("El carrito es null");
                    Carrito = new ArrayList<Producto>();
                    Cantidad = new ArrayList<Integer>();
                    System.out.println("El carrito no lo contiene, se agrega");
                    Carrito.add(aux);
                    Cantidad.add(new Integer(1));
                }else{
                    for(Producto p : Carrito){
                        if(p.getId()==aux.getId()){
                            index = Carrito.indexOf(p);
                            break;
                        }
                    }
                    if(index==0&&Carrito.get(index).getId()!=aux.getId()){
                        Carrito.add(aux);
                        Cantidad.add(new Integer(1));
                    }else{
                        Cantidad.set(index,Cantidad.get(index)+1);
                    }
                }
                sesion.setAttribute("Carrito", Carrito);
                sesion.setAttribute("Cantidad", Cantidad);
                System.out.println("Se actualiza el atributo");
                response.sendRedirect("productos.jsp");
            }
            else if(accion.equals("quitar")){
                
                Producto aux = Sentencias.readProductoId(idProducto);
                int index = 0;
                for(Producto p : Carrito){
                    if(p.getId()==aux.getId()){
                        index = Carrito.indexOf(p);
                        break;
                    }
                }
                System.out.println("El index del producto es"+index);
                if(Cantidad.get(index)==1){
                    Carrito.remove(index);
                    Cantidad.remove(index);
                }
                sesion.setAttribute("Carrito",Carrito);
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
            }else if(accion.equals("Vaciar")){
                Carrito = null;
                Cantidad = null;
                sesion.setAttribute("Carrito",Carrito);
                sesion.setAttribute("Cantidad",Cantidad);
                response.sendRedirect("carrito.jsp");
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
            ArrayList<Integer> Cantidad = (ArrayList<Integer>) sesion.getAttribute("Cantidad");
            
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
            String msj = Sentencias.insertarCompra(username,Cantidad,dcto,Carrito);
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

}
