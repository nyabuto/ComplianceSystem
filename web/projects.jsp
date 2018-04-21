<%-- 
    Document   : projects
    Created on : Apr 20, 2018, 12:25:09 PM
    Author     : GNyabuto
--%>

<%@page import="java.util.Calendar"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<title>Projects</title>
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
                                <li class="active"><a href="projects.jsp">Projects</a></li>
			</ol>
		</div><!--/.row-->
                <br>
            <div>
               <button type="button" class="btn btn-success btn-raised" onclick="new_project();" style="margin-left: 1%; margin-bottom: 1%; font-weight: 900;"><i class="icon-plus3 position-left"></i> New Project</button>
           </div>
        <table id="data_table"  class="display cell-border row-border" style="width:100%">
       <thead>
            <tr> 
         <th> No </th>
         <th> Project Name</th>
         <th> Counties of Operation</th>
         <th> Status</th>
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
        
	<script>
   $(document).ready(function() {
   
}); 
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
            var position=0,id,name,counties,status,status_label,output="";
             var dataSet=[];
        var data=raw_data.data;
        for (var i=0; i<data.length;i++){
            position++;
            id=name=counties=status="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].name!=null){name = data[i].name;}
            if( data[i].counties!=null){counties = data[i].counties;}
            if( data[i].is_active!=null){status = data[i].is_active;}
            
            var output='<div class="dropdown"><a href="#" data-toggle="dropdown"><i class="glyphicon glyphicon-menu-hamburger"></i></a><ul class="dropdown-menu  dropdown-menu-right">';
                output+='<li><button class="btn btn-link" onclick=\"edit_area('+position+');\" ><i class="position-left"></i> Edit Observation</button></li>';
                output+='<li><button class="btn btn-link" onclick=\"delete_entry('+position+');\" ><i class="position-left"></i> Delete Observation</button></li>';
                output+='<input type="hidden" name="'+position+'" value="'+id+'" id="_'+position+'">';
                output+='</ul></div>';
         if(status==1){
               status_label = '<span class="label label-success">Active</span> ';  
            }
            else{
                status_label = '<span class="label label-danger">Inactive</span> ';   
            }
         
            var minSet = [position,name,counties,status_label,output];
           
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

    
    function new_project(){
            var dialog = bootbox.dialog({
    title: '<b>New Project Details</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_project" method="post" class="form-horizontal">' +
                           
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Counties <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<select id="county" required name="county" class="mdb-select colorful-select dropdown-primary" multiple searchable="Search county.." required multiple style="width:80%;">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Project Name <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="project" required name="project" type="text" value="" placeholder="Enter project name" class="form-control"  style="width:80%;"/>' +
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
             var project,counties;
                project = $("#project").val();
                counties = $("#county").val();
                counties = counties.toString();
                if(project!="" && counties!=null){
                var form_data = {"project":project,"counties":counties};
                var theme="",header="",message="";
                var url = "save_project";
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
                                       load_projects(); 
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
    
    load_counties();
    }
    
    
    function load_counties(){
       $.ajax({
        url:'load_al_counties',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,county,output="";
             var dataSet=[];
        var data=raw_data.data;
        //output = "<option value=''>Choose Counties</option>";
        for (var i=0; i<data.length;i++){
            position++;
            id=county="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].county!=null){county = data[i].county;}
            output+="<option value='"+id+"'>"+county+"</option>";
        }
        $("#county").html(output);
    }
});
}
    function delete_entry(pos){
                   var id = $("#_"+pos).val();   
       bootbox.confirm({
        title: "<b  style='text-align:center;'>Delete Project<b>",
        message: "Are you sure you want to delete this project?",
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
                var form_data = {"project_id":id};
                var theme="",header="",message="";
                var url = "delete_project";
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
                                       load_projects(); 
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
    
    function load_ind_project(pos){
           var id = $("#_"+pos).val();
       $.ajax({
        url:'load_ind_project?project_id='+id,
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,project,counties,is_active;
         var data = raw_data.data;
             
             id=project=counties="";
             if( data.project!=null){project = data.project;}
             if( data.counties!=null){counties = data.counties;}
         // ouput
         $("#project_edit").val(project);
         $("#county_edit").html(counties);
        }
  });   
    }
    
    function edit_area(pos){
     var id = $("#_"+pos).val();        
            var dialog = bootbox.dialog({
    title: '<b>New Observation</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="edit_project" method="post" class="form-horizontal">' +
                           
                    '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Counties <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<select id="county_edit" required name="county" class="mdb-select colorful-select dropdown-primary" multiple searchable="Search county.." required multiple style="width:80%;">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Edit Project name <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="project_edit" required name="area" class="form-control" required placeholder="Enter Project Name"  style="width:80%;"/>'+
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
             var project,counties;
                project = $("#project_edit").val();
                counties = $("#county_edit").val();
                counties = counties.toString();
                
                if(project!="" && counties!=null){
                var form_data = {"project_id":id,"project":project,"counties":counties};
                var theme="",header="",message="";
                var url = "update_project";
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
                                       load_projects(); 
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
    
    load_ind_project(pos);
    }
    </script>
</body>
</html>