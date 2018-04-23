/*
 * To change this license header, choose License Headers in partner Properties.
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
public class delete_partner extends HttpServlet {
HttpSession session;
String partner_id,message;
int code;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
            dbConn conn = new dbConn();
            
            
            partner_id = request.getParameter("partner_id");
            
               if(session.getAttribute("level")!=null){
          if(session.getAttribute("level").toString().equals("1")){
            String checker = "SELECT id FROM obligation WHERE partner_id=?";
            conn.pst = conn.conn.prepareStatement(checker);
            conn.pst.setString(1, partner_id);
            
            conn.rs = conn.pst.executeQuery();
              System.out.println(conn.pst);
            if(conn.rs.next()){
               code = 0;
               message = "This partner cannot be deleted. Several Obligations have been added under it.";
            }
            else{
              String deleter = "DELETE FROM partner WHERE id=?";
          conn.pst = conn.conn.prepareStatement(deleter);
          conn.pst.setString(1, partner_id);
          
          int num = conn.pst.executeUpdate();
          if(num>0){
              code = 1;
              message = "partner details deleted successfully.";
              
              conn.st.executeUpdate("DELETE FROM partner_county WHERE partner_id='"+partner_id+"'");
          }
          else{
           code = 0;
           message = "No changes made to the system. Try again";
        }  
            }
            }
          else{
          code = 0;
         message = "Error. You do not have permissions to delete partner.";     
          }
          }
          else{
              code = 0;
              message = "Error. Unknown user. Login a fresh to do any operation.";
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
        Logger.getLogger(delete_partner.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(delete_partner.class.getName()).log(Level.SEVERE, null, ex);
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
