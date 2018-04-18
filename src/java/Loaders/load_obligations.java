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
public class load_obligations extends HttpServlet {
HttpSession session;
String is_selected;
String partner;
String id,partner_id,local_currency,us_dollar,end_date,is_active,timestamp;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
            JSONObject finalobj = new JSONObject();
            JSONArray jarray = new JSONArray();
            
            partner = "";
            if(request.getParameter("partner_id")!=null){
             partner = request.getParameter("partner_id");
            }
            else{
              if(session.getAttribute("partner_id")!=null){
                 partner = session.getAttribute("partner_id").toString();
             }
            }
            System.out.println("partner id : "+partner);
            if(!partner.equals("")){
            String getprojects = "SELECT id,partner_id,local_currency,us_dollar,end_date,is_active,timestamp FROM obligation WHERE partner_id=?";
            conn.pst = conn.conn.prepareStatement(getprojects);
            conn.pst.setString(1, partner);
            conn.rs = conn.pst.executeQuery();
            while(conn.rs.next()){
           
             id = conn.rs.getString("id");
             partner_id = conn.rs.getString("partner_id");
             local_currency = conn.rs.getString("local_currency");
             us_dollar = conn.rs.getString("us_dollar");
             end_date = conn.rs.getString("end_date");
             is_active = conn.rs.getString("is_active");
             timestamp = conn.rs.getString("timestamp");
              
              if(session.getAttribute("obligation_id")!=null){
                  if(session.getAttribute("obligation_id").toString().equals(id)){
                      is_selected = "selected";
                  }
                  else{
                      is_selected = ""; 
                  }
              }
              else{
                   is_selected = "";
              }
              JSONObject obj = new JSONObject();
              obj.put("id", id);
              obj.put("partner_id", partner_id);
              obj.put("local_currency", local_currency);
              obj.put("us_dollar", us_dollar);
              obj.put("end_date", end_date);
              obj.put("is_active", is_active);
              obj.put("timestamp", timestamp);
              obj.put("is_active", is_active);
              obj.put("is_selected", is_selected);
              
              jarray.add(obj);
            }
            }
            else{
                
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
        Logger.getLogger(load_obligations.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_obligations.class.getName()).log(Level.SEVERE, null, ex);
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
