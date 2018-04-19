/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Compliance;

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
public class update_observation extends HttpServlet {
HttpSession session;
String details_id,observation,area;
String message;
int code;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
           details_id = request.getParameter("details_id");
           observation = request.getParameter("observation");
           area = request.getParameter("area");
           
           if(!area.equals("") && !observation.equals("") && !details_id.equals("")){
            
               String updator = "UPDATE visit_details SET area_id=?, observation=? WHERE id=?";
               conn.pst = conn.conn.prepareStatement(updator);
               conn.pst.setString(1, area);
               conn.pst.setString(2, observation);
               conn.pst.setString(3, details_id);
               
               int num = conn.pst.executeUpdate();
               if(num>0){
                   code = 1;
                   message = "Observation details updated successfully.";
               }
               else{
                   code = 0;
                   message = "No changes were done. Kindly try again.";
               }
           }
           else{
               code = 0;
               message = "Ensure all details are provided.";
           }
            
            JSONObject finalobj = new JSONObject();
            JSONObject obj = new JSONObject();
            obj.put("code", code);
            obj.put("message", message);
           
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
        Logger.getLogger(update_observation.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(update_observation.class.getName()).log(Level.SEVERE, null, ex);
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
