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
public class load_projects extends HttpServlet {
HttpSession session;
String id,name,is_active,is_selected;
String counties;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
            JSONObject finalobj = new JSONObject();
            JSONArray jarray = new JSONArray();
            
            
            String getprojects = "SELECT id,name,is_active FROM project order by name ASC";
            conn.pst = conn.conn.prepareStatement(getprojects);
            conn.rs = conn.pst.executeQuery();
            while(conn.rs.next()){
              id = conn.rs.getString(1);
              name = conn.rs.getString(2);
              is_active = conn.rs.getString(3);
              
              if(session.getAttribute("project_id")!=null){
                  if(session.getAttribute("project_id").toString().equals(id)){
                      is_selected = "selected";
                  }
                  else{
                      is_selected = ""; 
                  }
              }
              else{
                   is_selected = "";
              }
              
             //get operating counties
             counties="";
              String getc = "SELECT county FROM project_county LEFT JOIN county ON project_county.county_id=county.id WHERE project_id=?";
              conn.pst1 = conn.conn.prepareStatement(getc);
              conn.pst1.setString(1, id);
              conn.rs1 = conn.pst1.executeQuery();
              while(conn.rs1.next()){
                  counties+=conn.rs1.getString(1)+", ";
              }
              
              if(!counties.equals("")){
              counties = removeLast(counties, 2);
              }
              JSONObject obj = new JSONObject();
              obj.put("id", id);
              obj.put("name", name);
              obj.put("is_active", is_active);
              obj.put("counties", counties);
              
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
        Logger.getLogger(load_projects.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(load_projects.class.getName()).log(Level.SEVERE, null, ex);
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

          public String removeLast(String str, int num) {
    if (str != null && str.length() > 0) {
        str = str.substring(0, str.length() - num);
    }
    return str;
    }
}
