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
public class load_all_obligations extends HttpServlet {
HttpSession session;
String partner_id;
String obligation_id,project,partner_name,us_dollar,local_currency,end_date,is_active;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
           JSONObject finalobj = new JSONObject();
            JSONArray jarray = new JSONArray();
//           partner_id = request.getParameter("partner_id");\

           String get_obligations = "SELECT project.name AS project, partner.lip_name AS partner_name, obligation.id AS obligation_id,obligation.us_dollar AS us_dollar," +
                    "obligation.local_currency AS local_currency, obligation.end_date AS end_date,obligation.is_active AS is_active " +
                    "FROM obligation " +
                    "LEFT JOIN partner ON obligation.partner_id=partner.id " +
                    "LEFT JOIN project ON partner.project_id=project.id " +
                    "ORDER BY project,partner_name,end_date ";
           
           conn.pst = conn.conn.prepareStatement(get_obligations);
//           conn.pst.setString(1, partner_id);
           conn.rs = conn.pst.executeQuery();
           while(conn.rs.next()){
            obligation_id = conn.rs.getString("obligation_id");
            project = conn.rs.getString("project");
            partner_name = conn.rs.getString("partner_name");
            us_dollar = conn.rs.getString("us_dollar");
            local_currency = conn.rs.getString("local_currency");
            end_date = conn.rs.getString("end_date");
            is_active = conn.rs.getString("is_active");
            
               JSONObject obj = new JSONObject();
               obj.put("obligation_id", obligation_id);
               obj.put("project", project);
               obj.put("partner_name", partner_name);
               if(us_dollar!=null){
               obj.put("obligation_amount", "$"+us_dollar);
               }
               else if(local_currency!=null){
               obj.put("obligation_amount", "Ksh. "+local_currency);
               }
               else{
                obj.put("obligation_amount", "Not Set");   
               }
               obj.put("end_date", end_date);
               obj.put("is_active", is_active);

             jarray.add(obj);
           }
           
           finalobj.put("data", jarray);
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
        Logger.getLogger(load_all_obligations.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_all_obligations.class.getName()).log(Level.SEVERE, null, ex);
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
