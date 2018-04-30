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
public class review_details extends HttpServlet {
HttpSession session;
String partner_id;
int no_observation;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            session = request.getSession();
            dbConn conn = new dbConn();
            
            JSONObject finalobj = new JSONObject();
            JSONArray jarray = new JSONArray();
            
            
            partner_id = request.getParameter("partner_id");
            
            no_observation=0;
            String getdetails = "SELECT count(visit_details.id) AS no_observations,visit.id AS id, review_start_date,review_end_date,visit_start_date,visit_end_date,"+
                        "fullname,email,phone,obligation.end_date AS obligation_end_date " +
                        "FROM visit LEFT JOIN user ON visit.user_id=user.id " +
                        "LEFT JOIN obligation ON visit.obligation_id=obligation.id " +
                        "LEFT JOIN partner ON obligation.partner_id=partner.id " +
                        "LEFT JOIN visit_details ON visit_details.visit_id=visit.id " +
                        "WHERE partner_id=? GROUP BY id";
            conn.pst = conn.conn.prepareStatement(getdetails);
            conn.pst.setString(1, partner_id);
            conn.rs = conn.pst.executeQuery();
            while(conn.rs.next()){
                JSONObject obj = new JSONObject();
                if(conn.rs.getInt("no_observations")>0){
                obj.put("id", conn.rs.getString("id"));
                obj.put("review_start_date",  conn.rs.getString("review_start_date"));
                obj.put("review_end_date",  conn.rs.getString("review_end_date"));
                obj.put("visit_start_date",  conn.rs.getString("visit_start_date"));
                obj.put("visit_end_date",  conn.rs.getString("visit_end_date"));
                obj.put("fullname",  conn.rs.getString("fullname"));
                obj.put("email",  conn.rs.getString("email"));
                obj.put("phone",  conn.rs.getString("phone"));
                obj.put("obligation_end_date",  conn.rs.getString("obligation_end_date"));
                obj.put("no_observations", conn.rs.getString("no_observations"));
                jarray.add(obj);
                }
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
        Logger.getLogger(review_details.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(review_details.class.getName()).log(Level.SEVERE, null, ex);
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
