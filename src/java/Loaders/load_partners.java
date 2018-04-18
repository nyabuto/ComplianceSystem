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
public class load_partners extends HttpServlet {
HttpSession session;
String is_selected;
String project;
String id,id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,is_active,project_name;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
            JSONObject finalobj = new JSONObject();
            JSONArray jarray = new JSONArray();
            
            project = "";
            if(request.getParameter("project_id")!=null){
             project = request.getParameter("project_id");   
            }
            else{
              if(session.getAttribute("project_id")!=null){
                 project = session.getAttribute("project_id").toString();
                    }
            }
            System.out.println("project id : "+project);
            if(!project.equals("")){
            String getprojects = "SELECT partner.id AS id,id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,partner.is_active AS is_active,project.name AS project_name FROM partner LEFT JOIN project ON partner.project_id=project.id where project_id=? order by project_name,lip_name ASC";
            conn.pst = conn.conn.prepareStatement(getprojects);
            conn.pst.setString(1, project);
            conn.rs = conn.pst.executeQuery();
            while(conn.rs.next()){
           
             id = conn.rs.getString("id");
             id_code = conn.rs.getString("id_code");
             fco = conn.rs.getString("fco");
             lip_name = conn.rs.getString("lip_name");
             project_id = conn.rs.getString("project_id");
             start_date = conn.rs.getString("start_date");
             end_date = conn.rs.getString("end_date");
             total_budget = conn.rs.getString("total_budget");
             currency = conn.rs.getString("currency");
             project_monitor = conn.rs.getString("project_monitor");
             finance_monitor = conn.rs.getString("finance_monitor");
             is_active = conn.rs.getString("is_active");
             project_name = conn.rs.getString("project_name");
              
              if(session.getAttribute("partner_id")!=null){
                  if(session.getAttribute("partner_id").toString().equals(id)){
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
              obj.put("id_code", id_code);
              obj.put("fco", fco);
              obj.put("lip_name", lip_name);
              obj.put("project_id", project_id);
              obj.put("start_date", start_date);
              obj.put("end_date", end_date);
              obj.put("total_budget", total_budget);
              obj.put("currency", currency);
              obj.put("project_monitor", project_monitor);
              obj.put("finance_monitor", finance_monitor);
              obj.put("project_name", project_name);
              obj.put("is_active", is_active);
              
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
        Logger.getLogger(load_partners.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_partners.class.getName()).log(Level.SEVERE, null, ex);
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
