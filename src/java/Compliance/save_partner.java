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
public class save_partner extends HttpServlet {
HttpSession session;
String id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,is_active;
String message,partner_id;
int code;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           
            JSONObject finalobj = new JSONObject();
            
           id_code = request.getParameter("id_code");
           fco = request.getParameter("fco");
           lip_name = request.getParameter("lip_name");
           project_id = request.getParameter("project_id");
           start_date = request.getParameter("start_date");
           end_date = request.getParameter("end_date");
           total_budget = request.getParameter("total_budget");
           currency = request.getParameter("currency");
           project_monitor = request.getParameter("project_monitor");
           finance_monitor = request.getParameter("finance_monitor");
           String [] counties_array = request.getParameter("counties").split(",");
           
           String checker = "SELECT id FROM partner WHERE lip_name=? AND project_id=?";
           conn.pst = conn.conn.prepareStatement(checker);
           conn.pst.setString(1, lip_name);
           conn.pst.setString(2, project_id);
           
           conn.rs = conn.pst.executeQuery();
           if(conn.rs.next()){
               code = 0;
               message = "Partner exist in this project.";
           }
           else{
             String adder = "INSERT INTO partner (id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor) VALUES (?,?,?,?,?,?,?,?,?,?)";
             conn.pst = conn.conn.prepareStatement(adder);
             conn.pst.setString(1, id_code);
             conn.pst.setString(2, fco);
             conn.pst.setString(3, lip_name);
             conn.pst.setString(4, project_id);
             conn.pst.setString(5, start_date);
             conn.pst.setString(6, end_date);
             conn.pst.setString(7, total_budget);
             conn.pst.setString(8, currency);
             conn.pst.setString(9, project_monitor);
             conn.pst.setString(10, finance_monitor);
             
             int num = conn.pst.executeUpdate();
             if(num>0){
               String  getmaxcounty = "SELECT MAX(id) FROM partner";
                  conn.rs1 = conn.st1.executeQuery(getmaxcounty);
                  if(conn.rs1.next()){
                   partner_id = conn.rs1.getString(1);
                    //add project county mapping
                    for(String county_id:counties_array){
              //checker 
              String checker2 = "SELECT id FROM partner_county WHERE partner_id=? AND county_id=?";
              conn.pst1 = conn.conn.prepareStatement(checker2);
              conn.pst1.setString(1, partner_id);
              conn.pst1.setString(2, county_id);
                      conn.rs2 = conn.pst1.executeQuery();
                      if(conn.rs2.next()){
                          
                      }
                      else{
                       String adder2 = "INSERT INTO partner_county (partner_id,county_id,is_active) VALUES(?,?,?)";
                       conn.pst1 = conn.conn.prepareStatement(adder2);
                       conn.pst1.setString(1, partner_id);
                       conn.pst1.setString(2, county_id);
                       conn.pst1.setInt(3, 1);
                       
                       conn.pst1.executeUpdate();
                      }
                        }
                  }
                  
                  code = 1;
                    message = "Partner details added  successfully";
             }
             else{
                 code = 0;
                 message="Record not saved. Try again";
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
        Logger.getLogger(save_partner.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(save_partner.class.getName()).log(Level.SEVERE, null, ex);
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
