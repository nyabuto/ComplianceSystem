/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Reports;

import Db.dbConn;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.xwpf.usermodel.BreakType;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
/**
 *
 * @author GNyabuto
 */
public class visit_report extends HttpServlet {
HttpSession session;
String visit_id;
String id,visit_date,review_start_date,review_end_date,area_of_observation,observation,implication,control_measure,recommendation,responsibility,timeline,implementation_status,timestamp;
String fullname,email,phone,local_currency,us_dollar,obligation_end_date,id_code,fco,partner_name,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,project_name;
String counties;
int new_,areas_counter,observations_counter;
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
           session = request.getSession();
           dbConn conn = new dbConn();
           JSONArray jarray = new JSONArray();
            //Blank Document
        XWPFDocument document = new XWPFDocument(); 
           
        
//        visit_id = request.getParameter("visit_id");
        visit_id="1";
        counties = "";
        areas_counter=observations_counter=0;
        String get_basic_info = "SELECT visit.id AS visit_id, user.fullname AS fullname,user.email AS email, user.phone AS phone, "
                + "obligation.local_currency AS local_currency,obligation.us_dollar AS us_dollar,"
                + "obligation.end_date AS end_date,partner.id_code AS id_code,partner.fco AS fco, partner.lip_name AS partner_name," +
                "partner.start_date AS start_date, partner.end_date AS end_date, partner.total_budget AS total_budget,partner.currency AS currency," +
                "partner.project_monitor AS project_monitor,partner.finance_monitor AS finance_monitor,project.name AS project_name " +
                "FROM visit " +
                "LEFT JOIN user ON visit.user_id=user.id " +
                "LEFT JOIN obligation ON visit.obligation_id=obligation.id " +
                "LEFT JOIN partner ON obligation.partner_id = partner.id " +
                "LEFT JOIN project ON partner.project_id=project.id " +
                "WHERE visit.id=?";
        conn.pst = conn.conn.prepareStatement(get_basic_info);
        conn.pst.setString(1, visit_id);
        conn.rs = conn.pst.executeQuery();
        while(conn.rs.next()){
        fullname = conn.rs.getString("fullname");
        email = conn.rs.getString("email");
        phone = conn.rs.getString("phone");
        local_currency = conn.rs.getString("local_currency");
        us_dollar = conn.rs.getString("us_dollar");
        obligation_end_date = conn.rs.getString("end_date");
        id_code = conn.rs.getString("id_code");
        fco = conn.rs.getString("fco");
        partner_name = conn.rs.getString("partner_name");
        start_date = conn.rs.getString("start_date");
        end_date = conn.rs.getString("end_date");
        total_budget = conn.rs.getString("total_budget");
        currency = conn.rs.getString("currency");
        project_monitor = conn.rs.getString("project_monitor");
        finance_monitor = conn.rs.getString("finance_monitor");
        project_name = conn.rs.getString("project_name");    
        }
        
        String getcounties = "SELECT county.county AS county FROM partner_county LEFT JOIN county on partner_county.county_id=county.id ORDER by county";
        conn.rs = conn.st.executeQuery(getcounties);
        while(conn.rs.next()){
            counties+=conn.rs.getString(1)+", ";
        }
        
        if(!counties.equals("")){
            counties = removeLast(counties, 2);
        }
        // output the headers page
         XWPFParagraph general_info = document.createParagraph();
         general_info.setAlignment(ParagraphAlignment.CENTER);
         general_info.setSpacingBetween(2);
         XWPFRun run = general_info.createRun();
         run.setBold(true);
         run.setFontSize(18);
         run.setFontFamily("cambria");
         run.setText("FAMILY HEALTH INTERNATIONAL");
         run.addCarriageReturn();
         run.setText(project_name);
         run.addCarriageReturn();
         run.setText("Funder: USAID");
         run.addCarriageReturn();
         run.setText("Sub-Awardee Compliance Review Report");
         run.addCarriageReturn();
         run.setText("Recipient's Name: "+partner_name);
         run.addCarriageReturn();
         run.setText("FCO/ID No: "+fco);
         XWPFParagraph general_info2 = document.createParagraph();
         general_info2.setAlignment(ParagraphAlignment.LEFT);
         general_info2.setSpacingBetween(2.3);
         XWPFRun run2 = general_info2.createRun();
         run2.setBold(true);
         run2.setFontSize(15);
         run2.setFontFamily("cambria");
         
         run2.setText("Sub-Grantee Contact Personnel: "+finance_monitor);
         run2.addCarriageReturn();
         run2.setText("Title: Finance and Administration Manager");
         run2.addCarriageReturn();
         if(local_currency==null){
         run2.setText("Obligated Budget: $"+us_dollar);
         }
         else{
         run2.setText("Obligated Budget: Ksh"+local_currency);    
         }
         run2.addCarriageReturn();
         run2.setText("S. Award Start and End Dates: "+start_date+" to "+end_date);
         run2.addCarriageReturn();
         run2.setText("Implementation Area: "+counties);
         run2.addCarriageReturn();
         
        
        String get_details = "SELECT IFNULL(visit.id,'') AS id,IFNULL(visit.date,'') AS visit_date,IFNULL(visit.review_start_date,'') AS review_start_date,"
            + "IFNULL(visit.review_end_date,'') AS review_end_date, IFNULL(area.name,'') AS area_of_observation, " +
            "IFNULL(visit_details.observation,'') AS observation,IFNULL(visit_details.implication,'') AS implication, IFNULL(visit_details.control_measure,'') AS control_measure," +
            "IFNULL(visit_details.recommendation,'') AS  recommendation, IFNULL(visit_details.responsibility,'') AS responsibility, IFNULL(visit_details.timeline,'') AS timeline," +
            "IFNULL(visit_details.implementation_status,'') AS implementation_status,IFNULL(visit_details.timestamp,'') AS timestamp " +
            "FROM visit LEFT JOIN visit_details ON visit.id=visit_details.visit_id " +
            "LEFT JOIN area ON visit_details.area_id=area.id " +
            "WHERE visit.id=? " +
            "ORDER BY area_of_observation,timestamp";
        conn.pst = conn.conn.prepareStatement(get_details);
        conn.pst.setString(1, visit_id);
        conn.rs = conn.pst.executeQuery();
        while(conn.rs.next()){
         id = conn.rs.getString("id");
         visit_date = conn.rs.getString("visit_date");
         review_start_date = conn.rs.getString("review_start_date");
         review_end_date = conn.rs.getString("review_end_date");
         area_of_observation = conn.rs.getString("area_of_observation");
         observation = conn.rs.getString("observation");
         implication = conn.rs.getString("implication");
         control_measure = conn.rs.getString("control_measure");
         recommendation = conn.rs.getString("recommendation");
         responsibility = conn.rs.getString("responsibility");
         timeline = conn.rs.getString("timeline");
         implementation_status = conn.rs.getString("implementation_status");
         timestamp  = conn.rs.getString("timestamp"); 
            JSONObject obj = new JSONObject();
            obj.put("id", run);
            obj.put("visit_date", run);
            obj.put("review_start_date", review_start_date);
            obj.put("review_end_date", review_end_date);
            obj.put("area_of_observation", area_of_observation);
            obj.put("observation", observation);
            obj.put("implication", implication);
            obj.put("control_measure", control_measure);
            obj.put("recommendation", recommendation);
            obj.put("responsibility", responsibility);
            obj.put("timeline", timeline);
            obj.put("implementation_status", implementation_status);
            
            jarray.add(obj);
        }
        
        run2.setText("Date(s) of Visit: "+visit_date); // add from to dates here 
        run2.addCarriageReturn();
        
        run2.setText("Reviewed Period: "+review_start_date+" to "+review_end_date);
        run2.addCarriageReturn();
        run2.addCarriageReturn();
        run2.setText("FHI360 Staff Carrying out Review: "+fullname);
        
        run2.addBreak(BreakType.PAGE);
        
         XWPFParagraph info_header = document.createParagraph();
         info_header.setAlignment(ParagraphAlignment.CENTER);
         info_header.setSpacingBetween(2);
         XWPFRun run_header = info_header.createRun();
         run_header.setBold(true);
         run_header.setFontSize(15);
         run_header.setFontFamily("cambria");
         run_header.setText("Observations and Recommendations");
         
         
       for(int i=0; i<jarray.size();i++){
        JSONObject obj = (JSONObject) jarray.get(i);
         id = obj.get("id").toString();
         visit_date = obj.get("visit_date").toString();
         review_start_date = obj.get("review_start_date").toString();
         review_end_date = obj.get("review_end_date").toString();
         area_of_observation = obj.get("area_of_observation").toString();
         observation = obj.get("observation").toString();
         implication = obj.get("implication").toString();
         control_measure = obj.get("control_measure").toString();
         recommendation = obj.get("recommendation").toString();
         responsibility = obj.get("responsibility").toString();
         timeline = obj.get("timeline").toString();
         implementation_status = obj.get("implementation_status").toString();
         
         new_=0;
         if(i!=0){
          JSONObject obj_checker = (JSONObject) jarray.get(i-1); 
          String observation_area = obj_checker.get("area_of_observation").toString();
          if(!observation_area.equals(area_of_observation)){
          //creare a new header for this 
          new_=1;
          areas_counter++;
          observations_counter=1;
          }
          
         }
         else{
             areas_counter=1;
             observations_counter=1;
         }
         
         if(i==0 || new_==1){
          XWPFParagraph para_areas = document.createParagraph();
         para_areas.setAlignment(ParagraphAlignment.LEFT);
         para_areas.setSpacingBetween(2);
         XWPFRun run_areas = para_areas.createRun();
         run_areas.setBold(true);
         run_areas.setFontSize(14);
         run_areas.setFontFamily("cambria");
         run_areas.setText(areas_counter+". "+area_of_observation);
             
         }
         
         XWPFParagraph para_content = document.createParagraph();
//         para_content.setAlignment(ParagraphAlignment.LEFT);
         para_content.setSpacingBetween(2);
         
         //observation
         XWPFRun run_observation_h = para_content.createRun();
         run_observation_h.setBold(true);
         run_observation_h.setFontSize(14);
         run_observation_h.setFontFamily("cambria");
         run_observation_h.setText(areas_counter+"."+observations_counter+" Observation: ");
         
         
         XWPFRun run_observation_c = para_content.createRun();
         run_observation_c.setFontSize(12);
         run_observation_c.setFontFamily("cambria");
         run_observation_c.setText(observation);
         run_observation_c.addCarriageReturn();
         
//         implication
         XWPFRun run_implication_h = para_content.createRun();
         run_implication_h.addTab();
         run_implication_h.setBold(true);
         run_implication_h.setFontSize(14);
         run_implication_h.setFontFamily("cambria");
         run_implication_h.setText(areas_counter+"."+observations_counter+".1 Implication: ");

         
         XWPFRun run_implication_c = para_content.createRun();
         run_implication_c.setFontSize(12);
         run_implication_c.setFontFamily("cambria");
         run_implication_c.setText(implication);
         run_implication_c.addCarriageReturn();
         
         
//         recommendation
         XWPFRun run_recommendation_h = para_content.createRun();
         run_recommendation_h.addTab();
         run_recommendation_h.setBold(true);
         run_recommendation_h.setFontSize(14);
         run_recommendation_h.setFontFamily("cambria");
         run_recommendation_h.setText(areas_counter+"."+observations_counter+".2 Recommendation: ");
        
         
         XWPFRun run_recommendation_c = para_content.createRun();
         run_recommendation_c.setFontSize(12);
         run_recommendation_c.setFontFamily("cambria");
         run_recommendation_c.setText(recommendation);
         run_recommendation_c.addCarriageReturn();
         
         
       }
     
         XWPFParagraph info_header_table = document.createParagraph();
         info_header_table.setAlignment(ParagraphAlignment.CENTER);
         info_header_table.setSpacingBetween(2);
         XWPFRun run_header_table = info_header_table.createRun();
         run_header_table.addBreak(BreakType.PAGE);
         run_header_table.setBold(true);
         run_header_table.setFontSize(15);
         run_header_table.setFontFamily("cambria");
         run_header_table.setText("Corrective Action plan");
         
      XWPFTable table = document.createTable();
      
       //create first row
      XWPFTableRow tableRowOne = table.getRow(0);
      tableRowOne.getCell(0).setText("col one, row one");
      tableRowOne.addNewTableCell().setText("col two, row one");
      tableRowOne.addNewTableCell().setText("col three, row one");
		
      //create second row
      XWPFTableRow tableRowTwo = table.createRow();
      tableRowTwo.setHeight(18);
      tableRowTwo.getCell(0).setText("Control Lapse Noted");
      tableRowTwo.getCell(1).setText("Implication");
      tableRowTwo.getCell(2).setText("Required Control Measure");
      tableRowTwo.getCell(3).setText("Recommendation");
      tableRowTwo.getCell(4).setText("Responsibility, Timeline and Status");
       
       
      //Create a blank spreadsheet
//        XWPFParagraph paragraph = document.createParagraph();
//   
//        XWPFRun run = paragraph.createRun();

   
   
                 // write it as an excel attachment
ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
document.write(outByteStream);
byte [] outArray = outByteStream.toByteArray();
response.setContentType("application/ms-excel");
response.setContentLength(outArray.length);
response.setHeader("Expires:", "0"); // eliminates browser caching
response.setHeader("Content-Disposition", "attachment; filename=visit_report_generated_on__.docx");
OutputStream outStream = response.getOutputStream();
outStream.write(outArray);
outStream.flush();

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
        Logger.getLogger(visit_report.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(visit_report.class.getName()).log(Level.SEVERE, null, ex);
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
