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
public class load_ind_visit extends HttpServlet {
HttpSession session;
String visit_id,visit_start_date,visit_end_date,review_start_date,review_end_date;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           session = request.getSession();
           dbConn conn = new dbConn();
           
           visit_id = request.getParameter("visit_id");
           
           String getdetails = "SELECT visit_start_date,review_start_date,review_end_date,visit_end_date FROM visit WHERE id=?";
           conn.pst = conn.conn.prepareStatement(getdetails);
           conn.pst.setString(1, visit_id);
           
           conn.rs = conn.pst.executeQuery();
           if(conn.rs.next()){
               visit_start_date = conn.rs.getString(1);
               review_start_date = conn.rs.getString(2);
               review_end_date = conn.rs.getString(3);
               visit_end_date = conn.rs.getString(4);
           }
             JSONObject obj = new JSONObject();
             obj.put("visit_start_date", visit_start_date);
             obj.put("review_start_date", review_start_date);
             obj.put("review_end_date", review_end_date);
             obj.put("visit_end_date", visit_end_date);
           
             JSONObject finalobj = new JSONObject();
          
                finalobj.put("data", obj);
                out.println(finalobj);
                
                 System.out.println("visit id : "+visit_id+"    details res : "+finalobj);
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
        Logger.getLogger(load_ind_visit.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_ind_visit.class.getName()).log(Level.SEVERE, null, ex);
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
