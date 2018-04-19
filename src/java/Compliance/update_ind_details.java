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
public class update_ind_details extends HttpServlet {

  HttpSession session;
  String id,implication,control_measure,recommendation,responsibility,timeline,implementation_status;
  String message;
  int code;
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
           id = request.getParameter("id");
           implication = request.getParameter("implication");
           control_measure = request.getParameter("control_measure");
           recommendation = request.getParameter("recommendation");
           responsibility = request.getParameter("responsibility");
           timeline = request.getParameter("timeline");
           implementation_status = request.getParameter("implementation_status");
           
           String update = "UPDATE visit_details SET implication=?,control_measure=?,recommendation=?,responsibility=?,timeline=?,implementation_status=? WHERE id=?";
           conn.pst = conn.conn.prepareStatement(update);
           conn.pst.setString(1, implication);
           conn.pst.setString(2, control_measure);
           conn.pst.setString(3, recommendation);
           conn.pst.setString(4, responsibility);
           conn.pst.setString(5, timeline);
           conn.pst.setString(6, implementation_status);
           conn.pst.setString(7, id);
           
           
           int num = conn.pst.executeUpdate();
           if(num>0){
             code=1;
             message = "Details updated successfully";
           }
           else{
           code = 0;
           message = "Nothing updated as no changes were detected.";
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
          Logger.getLogger(update_ind_details.class.getName()).log(Level.SEVERE, null, ex);
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
          Logger.getLogger(update_ind_details.class.getName()).log(Level.SEVERE, null, ex);
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
