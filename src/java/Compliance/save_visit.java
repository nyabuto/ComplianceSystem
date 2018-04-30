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
public class save_visit extends HttpServlet {
HttpSession session;
String obligation_id,visit_start_date,visit_end_date,review_start_date,review_end_date,user_id;
String message;
int code;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            session = request.getSession();
            dbConn conn = new dbConn();
            
            visit_start_date = request.getParameter("visit_start_date");
            visit_end_date = request.getParameter("visit_end_date");
            review_start_date = request.getParameter("review_start_date");
            review_end_date = request.getParameter("review_end_date");
            obligation_id = message="";
            code=0;
            if(session.getAttribute("obligation_id")!=null && session.getAttribute("id")!=null){
                obligation_id = session.getAttribute("obligation_id").toString();
                user_id = session.getAttribute("id").toString();
              //check existence of record
             String checker = "SELECT id FROM visit WHERE obligation_id=? AND visit_start_date=? AND visit_end_date=?";
             conn.pst = conn.conn.prepareStatement(checker);
             conn.pst.setString(1, obligation_id);
             conn.pst.setString(2, visit_start_date);
             conn.pst.setString(3, visit_end_date);
             conn.rs = conn.pst.executeQuery();
             if(conn.rs.next()){
              code = 0;
              message = "Visit details already exist in the system";
             }
             else{
                 String add = "INSERT INTO visit (obligation_id,user_id,visit_start_date,review_start_date,review_end_date,visit_end_date) VALUES(?,?,?,?,?,?)";
                 conn.pst = conn.conn.prepareStatement(add);
                 conn.pst.setString(1, obligation_id);
                 conn.pst.setString(2, user_id);
                 conn.pst.setString(3, visit_start_date);
                 conn.pst.setString(4, review_start_date);
                 conn.pst.setString(5, review_end_date);
                 conn.pst.setString(6, visit_end_date);
                 
                 int num = conn.pst.executeUpdate();
                 if(num==1){
                     code = 1;
                     message = "Visit details added successfully.";
                 }
                 else{
                     code = 0;
                     message = "Visit not saved";
                 }
             }
                
            }
            else{
                code = 0;
                message = "An error occured while trying to save the record. Log out and login again";
            }
            
            JSONObject obj = new JSONObject();
            obj.put("code", code);
            obj.put("message", message);
            
            JSONObject finalobj = new JSONObject();
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
        Logger.getLogger(save_visit.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(save_visit.class.getName()).log(Level.SEVERE, null, ex);
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
