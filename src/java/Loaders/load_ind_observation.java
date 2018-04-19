/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Loaders;

import Db.dbConn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;

/**
 *
 * @author GNyabuto
 */
public class load_ind_observation extends HttpServlet {
HttpSession session;
String id,areas,observation;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
            dbConn conn = new dbConn();
            
            id = request.getParameter("id");
            System.out.println("id : "+id);
            areas = observation="";
            String get_details = "SELECT area_id,observation FROM visit_details WHERE id=?";
            conn.pst = conn.conn.prepareStatement(get_details);
            conn.pst.setString(1, id);
            conn.rs = conn.pst.executeQuery();
            if(conn.rs.next()){
                
                String get_areas = "SELECT id,name FROM area WHERE is_active=?";
                conn.pst1 = conn.conn.prepareStatement(get_areas);
                conn.pst1.setInt(1, 1);
                conn.rs1 = conn.pst1.executeQuery();
                while(conn.rs1.next()){
                    if(conn.rs1.getString(1).equals(conn.rs.getString(1))){
                    areas+="<option value='"+conn.rs1.getString(1)+"' selected>"+conn.rs1.getString(2)+"</option>";
                        
                    }
                    else{
                     areas+="<option value='"+conn.rs1.getString(1)+"'>"+conn.rs1.getString(2)+"</option>";   
                    }
                }
                observation = conn.rs.getString(2);
            }
            
            JSONObject finalobj = new JSONObject();
            JSONObject obj = new JSONObject();
            
            obj.put("areas", areas);
            obj.put("observation", observation);
            
            finalobj.put("data", obj);
            out.println(finalobj);
            System.out.println(finalobj);
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
    try {
        processRequest(request, response);
    } catch (SQLException ex) {
        Logger.getLogger(load_ind_observation.class.getName()).log(Level.SEVERE, null, ex);
    }
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
    try {
        processRequest(request, response);
    } catch (SQLException ex) {
        Logger.getLogger(load_ind_observation.class.getName()).log(Level.SEVERE, null, ex);
    }
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
