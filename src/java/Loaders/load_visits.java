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
public class load_visits extends HttpServlet {
HttpSession session;
String obligation_id;
String id,fullname,email,phone,lip_name,project_name,review_start_date,review_end_date,visit_date;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
           
            JSONObject finalobj = new JSONObject();
            JSONArray jarray = new JSONArray();
            System.out.println("was here");
            if(session.getAttribute("obligation_id")!=null){
            obligation_id = session.getAttribute("obligation_id").toString();
                System.out.println("obligation id : "+obligation_id);
            String getvisits = "SELECT visit.id AS id,user.fullname AS fullname,user.email AS email,user.phone AS phone,lip_name,name,review_start_date,review_end_date,date AS visit_date "
                    + "FROM visit LEFT JOIN obligation ON visit.obligation_id=obligation.id LEFT JOIN partner ON obligation.partner_id=partner.id "
                    + "LEFT JOIN project ON partner.project_id=project.id "
                    + "LEFT JOIN user ON visit.user_id=user.id WHERE obligation_id=? ORDER BY visit.timestamp DESC";
            conn.pst = conn.conn.prepareStatement(getvisits);
            conn.pst.setString(1, obligation_id);
            
            conn.rs = conn.pst.executeQuery();
            while(conn.rs.next()){
                id = conn.rs.getString(1);
                fullname = conn.rs.getString(2);
                email = conn.rs.getString(3);
                phone = conn.rs.getString(4);
                lip_name = conn.rs.getString(5);
                project_name = conn.rs.getString(6);
                review_start_date = conn.rs.getString(7);
                review_end_date = conn.rs.getString(8);
                visit_date = conn.rs.getString(9);
                
                
                JSONObject obj = new JSONObject();
                obj.put("id", id);
                obj.put("fullname", fullname);
                obj.put("email", email);
                obj.put("phone", phone);
                obj.put("lip_name", lip_name);
                obj.put("project_name", project_name);
                obj.put("review_start_date", review_start_date);
                obj.put("review_end_date", review_end_date);
                obj.put("visit_date", visit_date);
                
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
        Logger.getLogger(load_visits.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_visits.class.getName()).log(Level.SEVERE, null, ex);
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
