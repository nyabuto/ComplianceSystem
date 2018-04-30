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
public class update_visit extends HttpServlet {
HttpSession session;
String visit_id,visit_start_date,review_start_date,review_end_date,visit_end_date;
String message;
int code;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
            dbConn conn = new dbConn();
            
            visit_id = request.getParameter("visit_id");
            visit_start_date = request.getParameter("visit_start_date");
            visit_end_date = request.getParameter("visit_end_date");
            review_start_date = request.getParameter("review_start_date");
            review_end_date = request.getParameter("review_end_date");
            code=0;
            message = "";
            
            if(!visit_id.equals("") && !visit_start_date.equals("") && !visit_end_date.equals("")  && !review_start_date.equals("") && !review_end_date.equals("")){
            String updator = "UPDATE visit SET visit_start_date=?,review_start_date=?,review_end_date=?,visit_end_date=? WHERE id=?";
            conn.pst = conn.conn.prepareStatement(updator);
            conn.pst.setString(1, visit_start_date);
            conn.pst.setString(2, review_start_date);
            conn.pst.setString(3, review_end_date);
            conn.pst.setString(4, visit_end_date);
            conn.pst.setString(5, visit_id);
            
            int num = conn.pst.executeUpdate();
            if(num>0){
                code = 1;
                message = "Visit details updated successfully";
            }
            else{
                code = 0;
                message = "No changes were effected. Try again.";
            }
            }
            else{
                code = 0;
                message = "Ensure all information is entered before updating.";
            }
            JSONObject finalobj = new JSONObject();
            JSONObject obj = new JSONObject();
            
            obj.put("code", code);
            obj.put("message", message);
            
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
        Logger.getLogger(update_visit.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(update_visit.class.getName()).log(Level.SEVERE, null, ex);
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
