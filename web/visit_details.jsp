<%-- 
    Document   : visit_details
    Created on : Apr 18, 2018, 4:13:39 PM
    Author     : GNyabuto
--%>

<%@page import="java.util.Calendar"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<title>Partner's Visits Observations</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/font-awesome.min.css" rel="stylesheet">
	<link href="css/datepicker3.css" rel="stylesheet">
	<link href="css/styles.css" rel="stylesheet">
        <link href="dataTables/datatables.css" rel="stylesheet">
        <!--<link href="dataTables/Buttons-1.5.1/css/buttons.dataTables.min.css" rel="stylesheet">-->
        <link href="dataTables/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
        <link href="tables/styles.css" rel="stylesheet">
        <link href="css/components.css" rel="stylesheet" type="text/css">
	<!--Custom Font-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
       
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
                                <li class="active"><a href="visits_filter.jsp">Visits Filter</a></li>
                                <li class="active"><a href="visits.jsp">Visits</a></li>
                                <li class="active"><a href="visit_details.jsp">Visit Details</a></li>
			</ol>
		</div><!--/.row-->
                <br>
            <div>
               <button type="button" class="btn btn-success btn-raised" onclick="new_observation();" style="margin-left: 1%; margin-bottom: 1%; font-weight: 900;"><i class="icon-plus3 position-left"></i> New Observation</button>
           </div>
        <table id="data_table"  class="display cell-border row-border" style="width:100%">
       <thead>
            <tr> 
         <th> No </th>
         <th> Area of Observation</th>
         <th> Observation</th>
         <th> Implication </th>
         <th> Requisite Measure</th>
         <th>Recommendation</th>
         <th>Responsibility, Timeline &<br>Implementation Status</th>
         <th> Action</th>
        </tr>
        </thead>
        <tbody>
        
        </tbody>
        </table>
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
   
}); 

function changed(){
          var review_start_date = $("#review_start_date").val();
           var visit_date = $("#visit_date").val();
          $('#review_end_date').val("");
          $('#review_end_date').datepicker({
            format: 'yyyy-mm-dd',
            language: 'EN',
            autoclose: true,
            startDate: new Date(review_start_date),
            endDate: new Date(visit_date),
            setDate: new Date(),
            todayHighlight: true
     });
}

function visit_changed(){
          var visit_date = $("#visit_date").val();
//          alert(visit_date);
          $('#review_start_date').val("");
          $('#review_start_date').datepicker({
            format: 'yyyy-mm-dd',
            language: 'EN',
            autoclose: true,
            endDate: new Date(visit_date),
            setDate: new Date(),
            todayHighlight: true
     });
}
    </script>
    
    <script>
   $(document).ready(function() {
        load_visits_details();
    });
    
    function load_visits_details(){
            $.ajax({
        url:'load_visit_details',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,area,observation,implication,control_measure,recommendation,responsibility,timeline,implementation_status,output="";
             var dataSet=[];
        var data=raw_data.data;
        for (var i=0; i<data.length;i++){
            position++;
            id=area=observation=implication=control_measure=recommendation=responsibility=timeline=implementation_status="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].area!=null){area = data[i].area;}
            if( data[i].observation!=null){observation = data[i].observation;}
            if( data[i].implication!=null){implication = data[i].implication;}
            if( data[i].control_measure!=null){control_measure = data[i].control_measure;}
            if( data[i].recommendation!=null){recommendation = data[i].recommendation;}
            if( data[i].responsibility!=null){responsibility = data[i].responsibility;}
            if( data[i].timeline!=null){timeline = data[i].timeline;}
            if( data[i].implementation_status!=null){implementation_status = data[i].implementation_status;}
            
            var output='<div class="dropdown"><a href="#" data-toggle="dropdown"><i class="glyphicon glyphicon-menu-hamburger"></i></a><ul class="dropdown-menu  dropdown-menu-right">';
                output+='<li><button class="btn btn-link" onclick=\"update_observation('+position+');\" ><i class="position-left"></i>Update Observation Outcome</button></li>';
                output+='<li><button class="btn btn-link" onclick=\"edit_observation('+position+');\" ><i class="position-left"></i> Edit Observation</button></li>';
                output+='<li><button class="btn btn-link" onclick=\"delete_entry('+position+');\" ><i class="position-left"></i> Delete Observation</button></li>';
                output+='<input type="hidden" name="'+position+'" value="'+id+'" id="_'+position+'">';
                output+='</ul></div>';
         var respons_timeline_status="<b><u>Responsibility:</u></b><br>"+responsibility+"<br><b><u>Timeline:</u></b><br>"+timeline+"<br><b><u>Implementation Status:</u></b><br>"+implementation_status;
            var minSet = [position,area,observation,implication,control_measure,recommendation,respons_timeline_status,output];
           
           dataSet.push(minSet);
        }
        
        var table = $('#data_table').DataTable();
        table.destroy();
        
        
        table = $('#data_table').dataTable({
            data: dataSet,
             dom: 'Bfltip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ],
            responsive: true,
            className:'',
            columnDefs: []
            
        });
        
        table.on( 'responsive-resize', function ( e, datatable, columns ) {
    var count = columns.reduce( function (a,b) {
        return b === false ? a+1 : a;
    }, 0 );
 
    console.log( count +' column(s) are hidden' );
} );
    }
    });
    }
    
    function load_areas(){
              $.ajax({
        url:'load_areas',
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,area,description,is_active,is_selected;
         var data = raw_data.data;
         var output="";
         output += "<option value =''>Choose Areas of Observation</option>"; 
         for(var i=0;i<data.length;i++){
            id=area=description=is_active=is_selected="";
             if( data[i].id!=null){id = data[i].id;}
             if( data[i].area!=null){area = data[i].area;}
             if( data[i].description!=null){description = data[i].description;}
             if( data[i].is_active!=null){is_active = data[i].is_active;}

             if(is_active==1){
              output += "<option value ="+id+" >"+area+"</option>";   
             }
         }
         // ouput
         $("#area").html(output);
        }
  });
    }
    
    function new_observation(){
            
            var dialog = bootbox.dialog({
    title: '<b>New Observation</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_observation" method="post" class="form-horizontal">' +
                           
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Area of Observation <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8" style=\"border-style: solid; border-width: 0.2px;\">' +
                                    '<select id="area" required name="area" class="form-control" required  style="width:50%;">'+
                                    '<option value="">Select an Area</option>'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Observation <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="observation" required name="observation" type="text" value="" placeholder="Enter observation" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                           
                           
                         '</form>' +
                    '</div>' +
                    '</div>',
    buttons: {
        cancel: {
            label: "Cancel",
            className: 'btn-danger',
            callback: function(){
                
            }
        },
        ok: {
            label: "Save",
            className: 'btn-success',
            callback: function(){
             //gt values here
             var area,observation;
                area = $("#area").val();
                observation = $("#observation").val();

                if(area!="" && observation!=""){
                var form_data = {"area":area,"observation":observation};
                var theme="",header="",message="";
                var url = "save_observation";
                   $.post(url,form_data , function(output) {
                                    var response = JSON.parse(output).data;
                                    var response_code=response.code;
                                   var response_message=response.message;
                                   message=response_message;
                                    if(response_code==1){
                                        theme = "bg-success";
                                        header = "Success";
                                        message = response_message;
                                        //reload data in table
                                       load_visits_details(); 
                                    }
                                    else{
                                       theme = "bg-danger";
                                        header = "Error";
                                        message = response_message;   
                                    }
                                    
                                    $.jGrowl('close');
                                    
                                  $.jGrowl(message, {
                                        position: 'top-center',
                                        header: header,
                                        theme: theme
                                   });  
                                 });
                             
                         }
                         else{
                          $.jGrowl('Enter all the required information', {
                                        position: 'top-center',
                                        header: 'Error',
                                        theme: 'bg-danger'
                                   });   
                                   return false;
                         }
            }
        }
        
    }
    
    });
    
    load_areas();
    $("#area").select2();
    }
    
    function delete_entry(pos){
                   var id = $("#_"+pos).val();   
       bootbox.confirm({
        title: "<b  style='text-align:center;'>Delete Observation<b>",
        message: "Are you sure you want to delete this observation?",
        buttons: {
            confirm: {
                label: '<i class="fa fa-check"></i> Yes'
//                className: 'btn-success'
            },
            cancel: {
                label: '<i class="fa fa-times"></i> No ',
                className: 'btn-danger'
            }
        },
        callback: function (result) {
            if(result){
                if(id!=""){
                var form_data = {"id":id};
                var theme="",header="",message="";
                var url = "delete_visit_details";
                   $.post(url,form_data , function(output) {
                                    var response = JSON.parse(output).data;
                                    var response_code=response.code;
                                   var response_message=response.message;
                                   message=response_message;
                                    if(response_code==1){
                                        theme = "bg-success";
                                        header = "Success";
                                        message = response_message;
                                        //reload data in table
                                       load_visits_details(); 
                                    }
                                    else{
                                       theme = "bg-danger";
                                        header = "Error";
                                        message = response_message;   
                                    }
                                    
                                    $.jGrowl('close');
                                    
                                  $.jGrowl(message, {
                                        position: 'top-center',
                                        header: header,
                                        theme: theme
                                   });  
                                 });
                             
                         }
                         else{
                          $.jGrowl('Missing entry to be deleted', {
                                        position: 'top-center',
                                        header: 'Error',
                                        theme: 'bg-danger'
                                   });   
                                   return false;
                         }   
            }
        }
    });
    }
    
    function load_obs(pos){
           var id = $("#_"+pos).val();   
       $.ajax({
        url:'load_ind_observation?id='+id,
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,areas,observation;
         var data = raw_data.data;
             
             id=areas=observation="";
             if( data.areas!=null){areas = data.areas;}
             if( data.observation!=null){observation = data.observation;}
         // ouput
         $("#area_edit").html(areas);
         $("#area_edit").select2();
         $("#observation_edit").val(observation);
        }
  });   
    }
    
    function edit_observation(pos){
     var details_id = $("#_"+pos).val();        
            var dialog = bootbox.dialog({
    title: '<b>Edit Observation</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_observation" method="post" class="form-horizontal">' +
                           
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Area of Observation <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8" style=\"border-style: solid; border-width: 0.2px;\">' +
                                    '<select id="area_edit" required name="area" class="form-control" required  style="width:50%;">'+
                                    '<option value="">Select an Area</option>'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Observation <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="observation_edit" required name="observation" type="text" value="" placeholder="Enter observation" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                          
                         '</form>' +
                    '</div>' +
                    '</div>',
    buttons: {
        cancel: {
            label: "Cancel",
            className: 'btn-danger',
            callback: function(){
                
            }
        },
        ok: {
            label: "Save",
            className: 'btn-success',
            callback: function(){
             //gt values here
             var area,observation;
                area = $("#area_edit").val();
                observation = $("#observation_edit").val();

                if(area!="" && observation!=""){
                var form_data = {"details_id":details_id,"area":area,"observation":observation};
                var theme="",header="",message="";
                var url = "update_observation";
                   $.post(url,form_data , function(output) {
                                    var response = JSON.parse(output).data;
                                    var response_code=response.code;
                                   var response_message=response.message;
                                   message=response_message;
                                    if(response_code==1){
                                        theme = "bg-success";
                                        header = "Success";
                                        message = response_message;
                                        //reload data in table
                                       load_visits_details(); 
                                    }
                                    else{
                                       theme = "bg-danger";
                                        header = "Error";
                                        message = response_message;   
                                    }
                                    
                                    $.jGrowl('close');
                                    
                                  $.jGrowl(message, {
                                        position: 'top-center',
                                        header: header,
                                        theme: theme
                                   });  
                                 });
                             
                         }
                         else{
                          $.jGrowl('Enter all the required information', {
                                        position: 'top-center',
                                        header: 'Error',
                                        theme: 'bg-danger'
                                   });   
                                   return false;
                         }
            }
        }
        
    }
    
    });
    
    load_obs(pos);
    }
    
    function get_details(pos){
     var details_id = $("#_"+pos).val(); 
     
     $.ajax({
        url:'load_ind_details?id='+details_id,
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,observation,implication,control_measure,recommendation,responsibility,timeline,implementation_status;
         var data = raw_data.data;
         var output="";
         output += "<option value =''>Choose Areas of Observation</option>"; 
            id=observation=implication=control_measure=responsibility=recommendation=timeline=implementation_status="";
             if( data.id!=null){id = data.id;}
             if( data.observation!=null){observation = data.observation;}
             if( data.implication!=null){implication = data.implication;}
             if( data.control_measure!=null){control_measure = data.control_measure;}
             if( data.recommendation!=null){recommendation = data.recommendation;}
             if( data.responsibility!=null){responsibility = data.responsibility;}
             if( data.timeline!=null){timeline = data.timeline;}
             if( data.implementation_status!=null){implementation_status = data.implementation_status;}

         // ouput
         $("#observation").html(observation);
         $("#implication").val(implication);
         $("#control_measure").val(control_measure);
         $("#recommendation").val(recommendation);
         $("#responsibility").val(responsibility);
         $("#timeline").val(timeline);
         $("#implementation_status").val(implementation_status);

        }
  });
  
     
    }
    
    function update_observation(pos){
        var id = $("#_"+pos).val(); 
            var dialog = bootbox.dialog({
    title: '<b>Observation Details</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_user" method="post" class="form-horizontal">' +
                          
                            
                            '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Observation <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="observation" required name="observation" type="text" value="" placeholder="Enter observation" class="form-control" readonly style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Implication <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="implication" required name="implication" type="text" value="" placeholder="Enter implication" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                           
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Requisite Measure <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="control_measure" required name="control_measure" type="text" value="" placeholder="Enter Requisite measure" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                           
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Recommendation <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="recommendation" required name="recommendation" type="text" value="" placeholder="Enter recommendation" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                           
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Responsibility <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="responsibility" required name="responsibility" type="text" value="" placeholder="Enter who is responsible" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                           
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Timeline <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="timeline" required name="timeline" type="text" value="" placeholder="Enter timelines" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                           
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Implementation Status <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<textarea id="implementation_status" required name="implementation_status" type="text" value="" placeholder="Enter the implementation status" class="form-control"  style="width:80%;"></textarea>' +
                                '</div>' +
                            '</div>' +
                            
                           
                         '</form>' +
                    '</div>' +
                    '</div>',
    buttons: {
        cancel: {
            label: "Cancel",
            className: 'btn-danger',
            callback: function(){
                
            }
        },
        ok: {
            label: "Save",
            className: 'btn-success',
            callback: function(){
             //gt values here
             var implication,control_measure,recommendation,responsibility,timeline,implementation_status;
                implication = $("#implication").val();
                control_measure = $("#control_measure").val();
                recommendation = $("#recommendation").val();
                responsibility = $("#responsibility").val();
                timeline = $("#timeline").val();
                implementation_status = $("#implementation_status").val();

                if(implication!="" || control_measure!="" || recommendation!="" || responsibility!="" || timeline!="" || implementation_status!=""){
                var form_data = {"id":id,"implication":implication,"control_measure":control_measure,"recommendation":recommendation,"responsibility":responsibility,"timeline":timeline,"implementation_status":implementation_status};
                var theme="",header="",message="";
                var url = "update_ind_details";
                   $.post(url,form_data , function(output) {
                                    var response = JSON.parse(output).data;
                                    var response_code=response.code;
                                   var response_message=response.message;
                                   message=response_message;
                                    if(response_code==1){
                                        theme = "bg-success";
                                        header = "Success";
                                        message = response_message;
                                        //reload data in table
                                       load_visits_details(); 
                                    }
                                    else{
                                       theme = "bg-danger";
                                        header = "Error";
                                        message = response_message;   
                                    }
                                    
                                    $.jGrowl('close');
                                    
                                  $.jGrowl(message, {
                                        position: 'top-center',
                                        header: header,
                                        theme: theme
                                   });  
                                 });
                             
                         }
                         else{
                          $.jGrowl('Enter al least one field', {
                                        position: 'top-center',
                                        header: 'Error',
                                        theme: 'bg-danger'
                                   });   
                                   return false;
                         }
            }
        }
    }
    }); 
    
        get_details(pos);
    }
    </script>
</body>
</html>