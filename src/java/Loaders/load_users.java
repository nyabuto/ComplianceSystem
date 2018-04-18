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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author GNyabuto
 */
public class load_users extends HttpServlet {
HttpSession session;
String id,fullname,email,phone,level,status,gender,timestamp;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
           JSONObject final_data = new JSONObject();
            JSONArray jarray = new JSONArray();
           
           String getusers = "SELECT id,fullname,email,phone,level,status,gender,timestamp FROM user ORDER BY id";
           conn.pst = conn.conn.prepareStatement(getusers);
           conn.rs = conn.pst.executeQuery();
           while(conn.rs.next()){
//               for(int i=0;i<9000;i++){
             id = conn.rs.getString(1);
             fullname = conn.rs.getString(2);
             email = conn.rs.getString(3);
             phone = conn.rs.getString(4);
             level = conn.rs.getString(5);
             status = conn.rs.getString(6);
             gender = conn.rs.getString(7);
             timestamp = conn.rs.getString(8); 
             
               JSONObject obj = new JSONObject();
               obj.put("id", id);
               obj.put("fullname", fullname);
               obj.put("email", email);
               obj.put("phone", phone);
               obj.put("level", level);
               obj.put("status", status);
               obj.put("gender", gender);
               obj.put("timestamp", timestamp);

               jarray.add(obj);
//               }
           }
           
           final_data.put("data", jarray);
            out.println(final_data);
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
        Logger.getLogger(load_users.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_users.class.getName()).log(Level.SEVERE, null, ex);
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
