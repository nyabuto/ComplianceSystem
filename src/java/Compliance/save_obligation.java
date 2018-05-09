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
public class save_obligation extends HttpServlet {
HttpSession session;
String project_id,partner_id,currency,amount,end_date;
String message;
int code;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            session = request.getSession();
            dbConn conn = new dbConn();
            JSONObject finalobj  = new JSONObject();
            
            
            project_id = request.getParameter("project_id");
            partner_id = request.getParameter("partner_id");
            currency = request.getParameter("currency");
            amount = request.getParameter("amount");
            end_date = request.getParameter("end_date");
            

            //            checker
            String checker = "SELECT id FROM obligation WHERE partner_id=? AND end_date=?";
            conn.pst = conn.conn.prepareStatement(checker);
            conn.pst.setString(1, partner_id);
            conn.pst.setString(2, end_date);
            conn.rs = conn.pst.executeQuery();
            if(conn.rs.next()){
                code=0;
                message = "Similar Records Exist";
            }
            else{
                String inserter="INSERT INTO obligation (partner_id,local_currency,us_dollar,end_date) VALUES(?,?,?,?)";
                conn.pst = conn.conn.prepareStatement(inserter);
                conn.pst.setString(1, partner_id);
                switch (currency) {
                    case "local":
                        conn.pst.setString(2, amount);
                        conn.pst.setString(3, null);
                        break;
                    case "dollar":
                        conn.pst.setString(2, null);
                        conn.pst.setString(3, amount);
                        break;
                    default:
                        conn.pst.setString(2, null);     
                        conn.pst.setString(3, null);
                        break;
                }
                
                conn.pst.setString(4, end_date);
                int num = conn.pst.executeUpdate();
                if(num>0){
                   code=1;
                   message = "Obligation added successfully.";
               }
               else{
                   code = 0;
                   message = "Obligation was not saved";
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
        Logger.getLogger(save_obligation.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(save_obligation.class.getName()).log(Level.SEVERE, null, ex);
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
