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
public class load_ind_partner extends HttpServlet {
HttpSession session;
String partner_id,id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,is_active,project_name,timestamp;
String counties,projects;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            session = request.getSession();
            dbConn conn = new dbConn();
            
            partner_id = request.getParameter("partner_id");
            projects =currency= "";
            String get_details = "SELECT id,id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,is_active,timestamp FROM partner WHERE id=?";
            conn.pst = conn.conn.prepareStatement(get_details);
            conn.pst.setString(1, partner_id);
            conn.rs = conn.pst.executeQuery();
            if(conn.rs.next()){
             partner_id = conn.rs.getString("id");
             id_code = conn.rs.getString("id_code");
             fco = conn.rs.getString("fco");
             lip_name = conn.rs.getString("lip_name");
             project_id = conn.rs.getString("project_id");
             start_date = conn.rs.getString("start_date");
             end_date = conn.rs.getString("end_date");
             total_budget = conn.rs.getString("total_budget");
             String currency_1 = conn.rs.getString("currency");
             project_monitor = conn.rs.getString("project_monitor");
             finance_monitor = conn.rs.getString("finance_monitor");
             is_active = conn.rs.getString("is_active");
             timestamp = conn.rs.getString("timestamp");
             
             //currency
              String getcurr = "SELECT id,name FROM currency ORDER BY name";
             conn.rs1 = conn.st1.executeQuery(getcurr);
             while(conn.rs1.next()){
                 if(conn.rs1.getString(2).equals(currency_1)){
                 currency += "<option value =\""+conn.rs1.getString(2)+"\" selected>"+conn.rs1.getString(2)+"</option>";   
                 }
                 else{
                 currency += "<option value =\""+conn.rs1.getString(2)+"\">"+conn.rs1.getString(2)+"</option>";       
                 }
             }
             
             
             //get projects
             String getprojects = "SELECT id,name FROM project ORDER BY name";
             conn.rs1 = conn.st1.executeQuery(getprojects);
             while(conn.rs1.next()){
                 if(conn.rs1.getString(1).equals(project_id)){
                 projects += "<option value =\""+conn.rs1.getString(1)+"\" selected>"+conn.rs1.getString(2)+"</option>";   
                 }
                 else{
                 projects += "<option value =\""+conn.rs1.getString(1)+"\">"+conn.rs1.getString(2)+"</option>";       
                 }
             }
             //end of getting projects
             // load counties
             counties="";
             String get_projects = "SELECT * FROM (SELECT county.id AS id,county.county As county,1 AS is_found "
                     + "FROM county LEFT JOIN partner_county ON county.id=partner_county.county_id WHERE partner_id=? " +
                       "UNION " +
                       "SELECT county.id AS id,county.county As county,0 as is_found "
                     + "FROM county LEFT JOIN project_county ON county.id=project_county.county_id WHERE project_id=?) AS all_ct GROUP BY county ";
             conn.pst1 = conn.conn.prepareStatement(get_projects);
             conn.pst1.setString(1, partner_id);
             conn.pst1.setString(2, project_id);
             conn.rs1 = conn.pst1.executeQuery();
             while(conn.rs1.next()){
             if(conn.rs1.getInt(3)==1){
               counties+="<option value=\""+conn.rs1.getString(1)+"\" selected>"+conn.rs1.getString(2)+"</option>";  
             } 
             else{
             counties+="<option value=\""+conn.rs1.getString(1)+"\">"+conn.rs1.getString(2)+"</option>";      
             }
             }
            }
            
            JSONObject finalobj = new JSONObject();
            JSONObject obj = new JSONObject();
            
              obj.put("id", partner_id);
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
              obj.put("counties", counties);
              obj.put("projects", projects);
            
            finalobj.put("data", obj);
            out.println(finalobj);
            System.out.println(finalobj);
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
        Logger.getLogger(load_ind_partner.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_ind_partner.class.getName()).log(Level.SEVERE, null, ex);
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
