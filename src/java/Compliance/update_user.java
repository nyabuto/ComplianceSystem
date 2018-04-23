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
public class update_user extends HttpServlet {
HttpSession session;
String user_id,fullname,email,phone,gender,password;
int code;
String message;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
           user_id = request.getParameter("user_id");
           fullname = request.getParameter("fullname");
           email = request.getParameter("email");
           phone = request.getParameter("phone");
           gender = request.getParameter("gender");
           String pass1 = request.getParameter("pass1");
           String pass2 = request.getParameter("pass2");
           
           if(pass1.equals(pass2)){
            
               String checker = "SELECT id FROM user email=? || phone=? AND id!=?";
               conn.pst = conn.conn.prepareStatement(checker);
               conn.pst.setString(1, email);
               conn.pst.setString(2, phone);
               conn.pst.setString(3, user_id);
               
               conn.rs = conn.pst.executeQuery();
               if(conn.rs.next()){
                code=0;
                message = "Email or phone already registered to another.";
               }
               else{
                String updator = "UPDATE user SET fullname=?,email=?,phone=?,password=?,gender=? WHERE id=?"; 
                conn.pst = conn.conn.prepareStatement(updator);
                conn.pst.setString(1, fullname);
                conn.pst.setString(2, email);
                conn.pst.setString(3, phone);
                conn.pst.setString(4, password);
                conn.pst.setString(6, gender);
                conn.pst.setString(7, user_id);
                
                int num = conn.pst.executeUpdate();
                if(num>0){
                 
                    code=1;
                    message = "Profile update successfully.";
                }
                else{
                   code=0;
                   message="No change detected.";
                }
               }
            }
           else{
               code=0;
               message="Passwords do not match";
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
        Logger.getLogger(update_user.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(update_user.class.getName()).log(Level.SEVERE, null, ex);
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
