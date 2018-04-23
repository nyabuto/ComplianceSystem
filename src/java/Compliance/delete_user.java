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
public class delete_user extends HttpServlet {
    HttpSession session;
    String user_id,message;
    int code;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
            dbConn conn = new dbConn();
              if(session.getAttribute("level")!=null){
             if(session.getAttribute("level").toString().equals("1")){
            user_id = request.getParameter("user_id");
            String checker = "SELECT id FROM visit WHERE user_id=?";
            conn.pst = conn.conn.prepareStatement(checker);
            conn.pst.setString(1, user_id);
            conn.rs = conn.pst.executeQuery();
            if(conn.rs.next()){
                code = 0;
                message = "User cannot be deleted as several visits have been made by the user";
            }
            else{
                String deleter = "DELETE FROM user WHERE id=?";
                conn.pst = conn.conn.prepareStatement(deleter);
                conn.pst.setString(1, user_id);
                
                int num = conn.pst.executeUpdate();
                if(num>0){
                    code = 1;
                    message = "User deleted successfully";
                }
                else{
                    code = 0;
                    message = "No changes detected";
                }
            }
             }
             else{
                 code=0;
                 message="Not allowed to undertake this action.";
             }
             }else{
                 code=0;
                 message = "You are not allowed to undertake this operation";
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
            Logger.getLogger(delete_user.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(delete_user.class.getName()).log(Level.SEVERE, null, ex);
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
