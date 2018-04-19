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
public class load_ind_details extends HttpServlet {
HttpSession session;
String id,observation,implication,control_measure,recommendation,responsibility,timeline,implementation_status;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            session = request.getSession();
            dbConn conn = new dbConn();
           
            id = request.getParameter("id");
            JSONObject finalobj = new JSONObject();
            
            String get_details = "SELECT id,observation,implication,control_measure,recommendation,responsibility,timeline,implementation_status FROM visit_details WHERE id=?";
            conn.pst = conn.conn.prepareStatement(get_details);
            conn.pst.setString(1, id);
            conn.rs = conn.pst.executeQuery();
            while(conn.rs.next()){
              id = conn.rs.getString("id");
              observation = conn.rs.getString("observation");
              implication = conn.rs.getString("implication");
              control_measure = conn.rs.getString("control_measure");
              recommendation = conn.rs.getString("recommendation");
              responsibility = conn.rs.getString("responsibility");
              timeline = conn.rs.getString("timeline");
              implementation_status = conn.rs.getString("implementation_status");  
            }
            
            JSONObject obj = new JSONObject();
            obj.put("id", id);
            obj.put("observation", observation);
            obj.put("implication", implication);
            obj.put("control_measure", control_measure);
            obj.put("recommendation", recommendation);
            obj.put("responsibility", responsibility);
            obj.put("timeline", timeline);
            obj.put("implementation_status", implementation_status);
            
            
            finalobj.put("data", obj);
            out.println(finalobj);
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
        Logger.getLogger(load_ind_details.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_ind_details.class.getName()).log(Level.SEVERE, null, ex);
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
