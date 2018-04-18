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
public class load_visit_details extends HttpServlet {
HttpSession session;
String id,area,area_description,observation,implication,control_measure,recommendation,responsibility,timeline,implementation_status;
String visit_id;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            session = request.getSession();
            dbConn conn = new dbConn();
            
            JSONObject finalobj = new JSONObject();
            JSONArray jarray = new JSONArray();
            System.out.println("loading details");
            if(session.getAttribute("visit_id")!=null){
            visit_id = session.getAttribute("visit_id").toString();
                System.out.println("visit id "+visit_id);
            String get_details = "SELECT visit_details.id AS id, IFNULL(area.name,'') AS area,IFNULL(area.description,'') AS area_description,IFNULL(observation,'') AS observation,IFNULL(implication,'') AS implication,IFNULL(control_measure,'') AS control_measure,IFNULL(recommendation,'') AS recommendation,IFNULL(responsibility,'') AS responsibility,IFNULL(timeline,'') AS timeline,IFNULL(implementation_status,'') AS implementation_status "
                    + " FROM visit_details LEFT JOIN area ON visit_details.area_id = area.id WHERE visit_id=? ORDER BY visit_details.timestamp DESC";
           conn.pst = conn.conn.prepareStatement(get_details);
           conn.pst.setString(1, visit_id);
           conn.rs = conn.pst.executeQuery();
           while(conn.rs.next()){
            id = conn.rs.getString("id");
            area = conn.rs.getString("area");
            area_description = conn.rs.getString("area_description");
            observation = conn.rs.getString("observation");
            implication = conn.rs.getString("implication");
            control_measure = conn.rs.getString("control_measure");
            recommendation = conn.rs.getString("recommendation");
            responsibility = conn.rs.getString("responsibility");
            timeline = conn.rs.getString("timeline");
            implementation_status = conn.rs.getString("implementation_status");
            
            JSONObject obj = new JSONObject();
            obj.put("id", id);
            obj.put("area", area);
            obj.put("area_description", area_description);
            obj.put("observation", observation);
            obj.put("implication", implication);
            obj.put("control_measure", control_measure);
            obj.put("recommendation", recommendation);
            obj.put("responsibility", responsibility);
            obj.put("timeline", timeline);
            obj.put("implementation_status", implementation_status);
            
            jarray.add(obj);
           }
            
           finalobj.put("data", jarray);
            
            }
            
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
        Logger.getLogger(load_visit_details.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_visit_details.class.getName()).log(Level.SEVERE, null, ex);
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
