<%-- 
    Document   : reports_filter
    Created on : Apr 30, 2018, 10:57:05 AM
    Author     : GNyabuto
--%>

<%@page import="java.util.Calendar"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<title>Visit Report</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/font-awesome.min.css" rel="stylesheet">
	<!--<link href="css/datepicker3.css" rel="stylesheet">-->
	<link href="css/styles.css" rel="stylesheet">
        <link href="dataTables/datatables.css" rel="stylesheet">
        <!--<link href="dataTables/Buttons-1.5.1/css/buttons.dataTables.min.css" rel="stylesheet">-->
        <link href="dataTables/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
        <link href="tables/styles.css" rel="stylesheet">
        <link href="css/components.css" rel="stylesheet" type="text/css">
	<!--Custom Font-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
       <style>
           select{
               height:120px;
           }
           </style>
</head>
<body>
    <div class="topmenu"><!--  start of top menu here --->
	<%@include file="topmenu.jsp"%>	 
    </div> <!--end of top menu -->
    
    <div class="sidebar"> <!-- start of side bar -->
        <%@include file="sidebar.jsp"%>	
    </div> <!-- end of sidebar -->

    <div class="content-data"> <!-- start of contents body -->	
       <div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="#">
					<em class="fa fa-home"></em>
				</a></li>
				 <li class="active"><a href="visits_filter.jsp">Visit Report</a></li>
			</ol>
		</div><!--/.row-->
                <br>
            <div>
              
                <div class="row">
                    <div class="col-lg-10">
                        <form id="" method="post" action="visit_report" class="form-horizontal">
                            
           <div class="form-group"> 
            <label class="col-md-4 control-label">Project <b style="color:red">*</b> : </label> 
            <div class="col-md-8" style="border-style: solid; border-width: 0.2px;"> 
                <select id="project" required name="project" class="form-control" required style="width:60%; height: 6%;">
                 <option value =''>Choose Project</option>
                </select> 
            </div> 
        </div>
                
           <div class="form-group"> 
            <label class="col-md-4 control-label">Implementing Partner <b style="color:red">*</b> : </label> 
            <div class="col-md-8"  style="border-style: solid; border-width: 0.2px;"> 
                <select id="partner" required name="partner" class="form-control" required  style="width:60%; height: 6%;">
                    <option value =''>Choose Implementing Partner</option>
                </select> 
            </div> 
        </div>
                
           <div class="form-group"> 
            <label class="col-md-4 control-label">Review Period <b style="color:red">*</b> : </label> 
            <div class="col-md-8"  style="border-style: solid; border-width: 0.2px;"> 
                <select id="visit_id" required name="visit_id" class="form-control" required  style="width:60%; height: 6%;">
                    <option value =''>Choose Period</option>
                </select> 
            </div> 
        </div>
                            
           <div class="form-group">  
            <div class="col-md-8"> 
                <input type="submit" required value="Generate Report" class="form-control btn btn-group-lg btn-primary" required  style="margin-left:60%; width: 20%; height: 6%;">
            </div> 
        </div>
           
                             </form>
                    </div>
                    </div>
            
            </div>
      
	</div>	<!--/.main-->

        </div>
	 <!-- end of contents body -->
        
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
        <script src="js/bootbox.min.js"></script>
	<script src="js/chart.min.js"></script>
	<script src="js/chart-data.js"></script>
	<script src="js/easypiechart.js"></script>
	<script src="js/easypiechart-data.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/custom.js"></script>
	
        <script src="dataTables/datatables.min.js"></script>
        <script src="dataTables/pdfmake-0.1.32/pdfmake.min.js"></script>
        <script src="dataTables/Buttons-1.5.1/js/dataTables.buttons.min.js"></script>
        <script src="dataTables/Buttons-1.5.1/js/buttons.flash.min.js"></script>
        <script src="dataTables/pdfmake-0.1.32/vfs_fonts.js"></script>
        <script src="dataTables/JSZip-2.5.0/jszip.min.js"></script>
        <script src="dataTables/Buttons-1.5.1/js/buttons.html5.min.js"></script>
        <script src="dataTables/Buttons-1.5.1/js/buttons.print.min.js"></script>
        <script type="text/javascript" src="js/notifications/jgrowl.min.js"></script>
        <script type="text/javascript" src="js/select2.min.js"></script>
        
	<script>
   $(document).ready(function() {
       $("#project").change(function(){
        load_partners();   
       });
       $("#partner").change(function(){
        load_visits();   
       });
        $("#partner").select2();
        $("#visit_id").select2();
       
} ); 
    </script>
    
    <script>
   $(document).ready(function() {
        load_projects();
    });
    
  function load_projects(){
      $.ajax({
        url:'load_projects',
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,name,is_active,is_selected;
         var data = raw_data.data;
         var output="";
         output += "<option value =''>Choose Project</option>"; 
         for(var i=0;i<data.length;i++){
            id=name=is_active=is_selected="";
             if( data[i].id!=null){id = data[i].id;}
             if( data[i].name!=null){name = data[i].name;}
             if( data[i].is_active!=null){is_active = data[i].is_active;}
             if( data[i].is_selected!=null){is_selected = data[i].is_selected;}
             
             if(is_active==1){
              output += "<option value ="+id+" "+is_selected+">"+name+"</option>";   
             }
         }
         // ouput
         $("#project").html(output);
         $("#project").select2();
        }
  });
  }
  
  function load_partners(){
      var project_id = $("#project").val();
           $.ajax({
        url:'load_partners?project_id='+project_id,
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,lip_name,is_active,is_selected,start_date,end_date;
         var data = raw_data.data;
         var output="";
         output += "<option value =''>Choose Implementing Partner</option>"; 
         for(var i=0;i<data.length;i++){
            id=lip_name=is_active=is_selected=start_date=end_date="";
             if( data[i].id!=null){id = data[i].id;}
             if( data[i].lip_name!=null){lip_name = data[i].lip_name;}
             if( data[i].is_active!=null){is_active = data[i].is_active;}
             if( data[i].is_selected!=null){is_selected = data[i].is_selected;}
             if( data[i].start_date!=null){start_date = data[i].start_date;}
             if( data[i].end_date!=null){end_date = data[i].end_date;}
             
             if(is_active==1){
              output += "<option value ="+id+" "+is_selected+">"+lip_name+" ["+start_date+" - "+end_date+"] </option>";   
             }
         }
         // ouput
         $("#partner").html(output);
         $("#partner").select2();
        }
  });   
  }
  
  function load_visits(){
      var partner_id = $("#partner").val();
           $.ajax({
        url:'review_details?partner_id='+partner_id,
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,review_start_date,review_end_date,visit_start_date,visit_end_date,fullname,email,phone,obligation_end_date,no_observations;
         var data = raw_data.data;
         var output="";
         output += "<option value =''>Choose Review Period</option>"; 
         for(var i=0;i<data.length;i++){
            id=review_start_date=review_end_date=visit_start_date=visit_end_date=fullname=email=phone=obligation_end_date=no_observations="";
             if( data[i].id!=null){id = data[i].id;}
             if( data[i].review_start_date!=null){review_start_date = data[i].review_start_date;}
             if( data[i].review_end_date!=null){review_end_date = data[i].review_end_date;}
             if( data[i].visit_start_date!=null){visit_start_date = data[i].visit_start_date;}
             if( data[i].visit_end_date!=null){visit_end_date = data[i].visit_end_date;}
             if( data[i].fullname!=null){fullname = data[i].fullname;}
             if( data[i].email!=null){email = data[i].email;}
             if( data[i].phone!=null){phone = data[i].phone;}
             if( data[i].obligation_end_date!=null){obligation_end_date = data[i].obligation_end_date;}
             if( data[i].no_observations!=null){no_observations = data[i].no_observations;}
             
              output += "<option value ="+id+">"+review_start_date+" to "+review_end_date+" ["+no_observations+" Observations]</option>";   
            
         }
         // ouput
         $("#visit_id").html(output);
         $("#visit_id").select2();
        }
  });  
  }
    </script>
</body>
</html>