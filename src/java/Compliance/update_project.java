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
public class update_project extends HttpServlet {
HttpSession session;
String project_id,counties,project;
int code;
String message;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
          session = request.getSession();
           dbConn conn = new dbConn();
           
            JSONObject finalobj = new JSONObject();
            
            project_id = request.getParameter("project_id");
            project = request.getParameter("project");
            String [] counties_array = request.getParameter("counties").split(",");
            
            String checker = "SELECT id FROM project WHERE name=? AND id!=?";
            conn.pst = conn.conn.prepareStatement(checker);
            conn.pst.setString(1, project);
            conn.pst.setString(2, project_id);
            
            conn.rs = conn.pst.executeQuery();
            if(conn.rs.next()){
                code = 0;
                message = "Similar project exist within the system.";
            }
            else{
                String inserter = "UPDATE project SET name=? WHERE id=?";
                conn.pst = conn.conn.prepareStatement(inserter);
                conn.pst.setString(1, project);
                conn.pst.setString(2, project_id);
                
                int num = conn.pst.executeUpdate();
                if(num>0){
                    code = 1;
                    message = "Project updated  successfully";
                }
                else{
                    code = 0;
                    message = "No changes were detected.";
                }
                
                
                conn.st.executeUpdate("DELETE FROM project_county WHERE project_id='"+project_id+"'");
                    //add project county mapping
                    for(String county_id:counties_array){
              //checker 
              String checker2 = "SELECT id FROM project_county WHERE project_id=? AND county_id=?";
              conn.pst1 = conn.conn.prepareStatement(checker2);
              conn.pst1.setString(1, project_id);
              conn.pst1.setString(2, county_id);
                      conn.rs2 = conn.pst1.executeQuery();
                      if(conn.rs2.next()){
                          
                      }
                      else{
                       String adder2 = "INSERT INTO project_county (project_id,county_id,is_active) VALUES(?,?,?)";
                       conn.pst1 = conn.conn.prepareStatement(adder2);
                       conn.pst1.setString(1, project_id);
                       conn.pst1.setString(2, county_id);
                       conn.pst1.setInt(3, 1);
                       
                       conn.pst1.executeUpdate();
                      }
                        }
                  
            }
            
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
        Logger.getLogger(update_project.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(update_project.class.getName()).log(Level.SEVERE, null, ex);
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
