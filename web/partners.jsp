<%-- 
    Document   : partners
    Created on : Apr 22, 2018, 4:47:01 PM
    Author     : GNyabuto
--%>

<%@page import="java.util.Calendar"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<title>Partners</title>
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
                                <li class="active"><a href="partners.jsp">Partners</a></li>
			</ol>
		</div><!--/.row-->
                <br>
            <div>
               <button type="button" class="btn btn-success btn-raised" onclick="new_partner();" style="margin-left: 1%; margin-bottom: 1%; font-weight: 900;"><i class="icon-plus3 position-left"></i> New Partner</button>
           </div>
        <table id="data_table"  class="display cell-border row-border" style="width:100%">
       <thead>
            <tr> 
         <th> No </th>
         <th> Project Name</th>
         <th> Counties of Operation</th>
         <th> LIP Name</th>
         <th> ID Code</th>
         <th> FCO</th>
         <th> Start Date</th>
         <th> End Date</th>
         <th> Budget</th>
         <th> Project Monitor</th>
         <th> Finance Monitor</th>
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
        <script type="text/javascript" src="js/select2.min.js"></script>
        
	<script>
   $(document).ready(function() {
   $("#county").select2();
}); 
    </script>
    
    <script>
   $(document).ready(function() {
        load_partners();
    });
    
    function load_partners(){
            $.ajax({
        url:'load_partners?source=0',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,id_code,fco,lip_name,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,project_name,counties,is_active,status_label,output="";
             var dataSet=[];
        var data=raw_data.data;
        for (var i=0; i<data.length;i++){
            position++;
            id=id_code=fco=lip_name=start_date=end_date=total_budget=currency=project_monitor=finance_monitor=project_name=counties=is_active=status_label="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].id_code!=null){id_code = data[i].id_code;}
            if( data[i].fco!=null){fco = data[i].fco;}
            if( data[i].lip_name!=null){lip_name = data[i].lip_name;}
            if( data[i].start_date!=null){start_date = data[i].start_date;}
            if( data[i].end_date!=null){end_date = data[i].end_date;}
            if( data[i].total_budget!=null){total_budget = data[i].total_budget;}
            if( data[i].currency!=null){currency = data[i].currency;}
            if( data[i].project_monitor!=null){project_monitor = data[i].project_monitor;}
            if( data[i].finance_monitor!=null){finance_monitor = data[i].finance_monitor;}
            if( data[i].project_name!=null){project_name = data[i].project_name;}
            if( data[i].counties!=null){counties = data[i].counties;}
            if( data[i].is_active!=null){is_active = data[i].is_active;}
            
            var output='<div class="dropdown"><a href="#" data-toggle="dropdown"><i class="glyphicon glyphicon-menu-hamburger"></i></a><ul class="dropdown-menu  dropdown-menu-right">';
                output+='<li><button class="btn btn-link" onclick=\"edit_partner('+position+');\" ><i class="position-left"></i> Edit Partner</button></li>';
                output+='<li><button class="btn btn-link" onclick=\"delete_entry('+position+');\" ><i class="position-left"></i> Delete Partner</button></li>';
                output+='<input type="hidden" name="'+position+'" value="'+id+'" id="_'+position+'">';
                output+='</ul></div>';
         if(is_active==1){
               status_label = '<span class="label label-success">Active</span> ';  
            }
            else{
                status_label = '<span class="label label-danger">Inactive</span> ';   
            }
         
            var minSet = [position,project_name,counties,lip_name,id_code,fco,start_date,end_date,currency+" "+total_budget,project_monitor,finance_monitor,status_label,output];
           
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

    
    function new_partner(){
            var dialog = bootbox.dialog({
    title: '<b>New Partner</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_project" method="post" class="form-horizontal">' +
                           
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Project <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8"  style=\"border-style: solid; border-width: 0.2px; width:52%\">' +
                                    '<select id="project" required name="project" onchange=\"load_counties(0);\" class="mdb-select colorful-select dropdown-primary" searchable="Search county.." required style="width:80%;min-height:4%">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                           
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Counties <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8"  style=\"border-style: solid; border-width: 0.2px; width:52%\">' +
                                    '<select id="county" required name="county" class="mdb-select colorful-select dropdown-primary" multiple searchable="Search county.." required style="width:80%;">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">LIP Name <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="partner" required name="partner" type="text" value="" placeholder="Enter partner name" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">ID Code <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="id_code" required name="id_code" type="text" value="" placeholder="ID Code" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">FCO <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="fco" required name="fco" type="text" value="" placeholder="Enter FCO" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Start Date <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="start_date" required name="start_date" type="text" value="" onchange="changed()" readonly placeholder="Start Date" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">End Date <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="end_date" required name="end_date" type="text" value="" placeholder="End Date" readonly class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Currency <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8"  style=\"border-style: solid; border-width: 0.2px; width:52%\">' +
                                    '<select id="currency" required name="currency" class="mdb-select colorful-select dropdown-primary" searchable="Search currency.." required style="width:80%;min-height:4%">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Budget<b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="budget" required name="budget" type="text" value="" placeholder="Budget" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Project Monitor <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="project_monitor" required name="project_monitor" type="text" value="" placeholder="Enter project monitor" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Finance Monitor<b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="finance_monitor" required name="finance_monitor" type="text" value="" placeholder="Finance Monitor" class="form-control"  style="width:80%;"/>' +
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
             var project,counties,id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor;
                project = $("#project").val();
                counties = $("#county").val();
                id_code = $("#id_code").val();
                fco = $("#fco").val();
                lip_name = $("#partner").val();
                project_id = $("#project").val();
                start_date = $("#start_date").val();
                end_date = $("#end_date").val();
                total_budget = $("#budget").val();
                currency = $("#currency").val();
                project_monitor = $("#project_monitor").val();
                finance_monitor = $("#finance_monitor").val();
                 
                if(project!="" && counties!=null && id_code!="" && fco!="" && lip_name!="" && project_id!="" && start_date!="" && end_date!="" && total_budget!="" && currency!="" && project_monitor!="" && finance_monitor!=""){
                   counties = counties.toString();
                var form_data = {"project":project,"counties":counties,"id_code":id_code,"fco":fco,"lip_name":lip_name,"project_id":project_id,"start_date":start_date,"end_date":end_date,"total_budget":total_budget,"currency":currency,"project_monitor":project_monitor,"finance_monitor":finance_monitor};
                var theme="",header="",message="";
                var url = "save_partner";
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
                                       load_partners(); 
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
    
    load_projects();
    load_currency();
    
    $('#start_date').datepicker({
            format: 'yyyy-mm-dd',
            language: 'EN',
            autoclose: true,
            setDate: new Date(),
            todayHighlight: true
     });
     
    }
    
    function load_projects(){
            $.ajax({
        url:'load_projects',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,name,is_active,output="";
             var dataSet=[];
        var data=raw_data.data;
        output = "<option value=''>Choose Project</option>";
        for (var i=0; i<data.length;i++){
            position++;
            id=name=is_active="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].name!=null){name = data[i].name;}
            if( data[i].is_active!=null){is_active = data[i].is_active;}
            if(is_active==1){
            output+="<option value='"+id+"'>"+name+"</option>";
        }
        }
        $("#project").html(output);
        $("#project").select2();
    }
});   
    }
    
    function load_currency(){
            $.ajax({
        url:'load_currency',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,name,is_active,output="";
             var dataSet=[];
        var data=raw_data.data;
//        output = "<option value=''>Choose Project</option>";
        for (var i=0; i<data.length;i++){
            position++;
            id=name=is_active="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].name!=null){name = data[i].name;}
            if( data[i].is_active!=null){is_active = data[i].is_active;}
            if(is_active==1){
            output+="<option value='"+name+"'>"+name+"</option>";
        }
        }
        $("#currency").html(output);
        $("#currency").select2();
    }
});   
    }
    
    function load_counties(num){
        
        var project_id = "";
         if(num==0){
        project_id = $("#project").val();
        }
        else if(num==1){
            project_id = $("#project_edit").val();
        }  
       $.ajax({
        url:'load_partner_county?project_id='+project_id,
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
        if(num==0){
        $("#county").html(output);
        $("#county").select2();
        }
        else if(num==1){
            $("#county_edit").html(output); 
            $("#county_edit").select2(); 
        }
    }
});
}

function changed(){
          var start_date = $("#start_date").val();
          $('#end_date').val("");
          $('#end_date').datepicker({
            format: 'yyyy-mm-dd',
            language: 'EN',
            autoclose: true,
            startDate: new Date(start_date),
            setDate: new Date(),
            todayHighlight: true
     });
}



    function delete_entry(pos){
                   var id = $("#_"+pos).val();   
       bootbox.confirm({
        title: "<b  style='text-align:center;'>Delete Partner<b>",
        message: "Are you sure you want to delete this partner?",
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
                var form_data = {"partner_id":id};
                var theme="",header="",message="";
                var url = "delete_partner";
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
                                       load_partners(); 
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
    
    function load_ind_partner(pos){
           var id = $("#_"+pos).val();
       $.ajax({
        url:'load_ind_partner?partner_id='+id,
        type:"post",
        dataType:"json",
        success:function(raw_data){
         var id,id_code,fco,lip_name,start_date,end_date,total_budget,currency,project_monitor,finance_monitor,is_active,counties,project;
         var data = raw_data.data;
             
             id=id_code=fco=lip_name=start_date=end_date=total_budget=currency=project_monitor=finance_monitor=is_active=counties=project="";
             if( data.id!=null){id = data.id;}
             if( data.id_code!=null){id_code = data.id_code;}
             if( data.fco!=null){fco = data.fco;}
             if( data.lip_name!=null){lip_name = data.lip_name;}
             if( data.start_date!=null){start_date = data.start_date;}
             if( data.end_date!=null){end_date = data.end_date;}
             if( data.total_budget!=null){total_budget = data.total_budget;}
             if( data.currency!=null){currency = data.currency;}
             if( data.project_monitor!=null){project_monitor = data.project_monitor;}
             if( data.finance_monitor!=null){finance_monitor = data.finance_monitor;}
             if( data.is_active!=null){is_active = data.is_active;}
             if( data.counties!=null){counties = data.counties;}
             if( data.projects!=null){project = data.projects;}
         // ouput

         $("#partner_edit").val(lip_name);
         $("#project_edit").html(project);
         $("#project_edit").select2();
         $("#county_edit").html(counties);
         $("#county_edit").select2();
         $("#id_code_edit").val(id_code);
         $("#fco_edit").val(fco);
         $("#start_date_edit").val(start_date);
         $("#end_date_edit").val(end_date);
         $("#budget_edit").val(total_budget);
         $("#currency_edit").html(currency);
         $("#currency_edit").select2();
         $("#project_monitor_edit").val(project_monitor);
         $("#finance_monitor_edit").val(finance_monitor);

        }
  });   
    }
    
    function edit_partner(pos){
     var id = $("#_"+pos).val();        
            var dialog = bootbox.dialog({
    title: '<b>New Partner</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_project" method="post" class="form-horizontal">' +
                           
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Project <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8"  style=\"border-style: solid; border-width: 0.2px; width:52%\">' +
                                    '<select id="project_edit" required name="project" onchange=\"load_counties(1);\" class="mdb-select colorful-select dropdown-primary" searchable="Search county.." required style="width:80%;min-height:4%">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                           
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Counties <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8"  style=\"border-style: solid; border-width: 0.2px; width:52%\">' +
                                    '<select id="county_edit" required name="county" class="mdb-select colorful-select dropdown-primary" multiple searchable="Search county.." required style="width:80%;">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">LIP Name <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="partner_edit" required name="partner" type="text" value="" placeholder="Enter partner name" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">ID Code <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="id_code_edit" required name="id_code" type="text" value="" placeholder="ID Code" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">FCO <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="fco_edit" required name="fco" type="text" value="" placeholder="Enter FCO" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Start Date <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="start_date_edit" required name="start_date" type="text" value="" onchange="changed()" readonly placeholder="Start Date" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">End Date <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="end_date_edit" required name="end_date" type="text" value="" placeholder="End Date" readonly class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                             '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Currency <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8"  style=\"border-style: solid; border-width: 0.2px; width:52%\">' +
                                    '<select id="currency_edit" required name="currency" class="mdb-select colorful-select dropdown-primary" searchable="Search currency.." required style="width:80%;min-height:4%">'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Budget<b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="budget_edit" required name="budget" type="text" value="" placeholder="Budget" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Project Monitor <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="project_monitor_edit" required name="project_monitor" type="text" value="" placeholder="Enter project monitor" class="form-control"  style="width:80%;"/>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Finance Monitor<b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="finance_monitor_edit" required name="finance_monitor" type="text" value="" placeholder="Finance Monitor" class="form-control"  style="width:80%;"/>' +
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
             var project,counties,id_code,fco,lip_name,project_id,start_date,end_date,total_budget,currency,project_monitor,finance_monitor;
                project = $("#project_edit").val();
                counties = $("#county_edit").val();
                id_code = $("#id_code_edit").val();
                fco = $("#fco_edit").val();
                lip_name = $("#partner_edit").val();
                project_id = $("#project_edit").val();
                start_date = $("#start_date_edit").val();
                end_date = $("#end_date_edit").val();
                total_budget = $("#budget_edit").val();
                currency = $("#currency_edit").val();
                project_monitor = $("#project_monitor_edit").val();
                finance_monitor = $("#finance_monitor_edit").val();
                 
                if(id!="" && project!="" && counties!=null && id_code!="" && fco!="" && lip_name!="" && project_id!="" && start_date!="" && end_date!="" && total_budget!="" && currency!="" && project_monitor!="" && finance_monitor!=""){
                   counties = counties.toString();
                var form_data = {"partner_id":id,"project":project,"counties":counties,"id_code":id_code,"fco":fco,"lip_name":lip_name,"project_id":project_id,"start_date":start_date,"end_date":end_date,"total_budget":total_budget,"currency":currency,"project_monitor":project_monitor,"finance_monitor":finance_monitor};
                var theme="",header="",message="";
                var url = "update_partner";
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
                                       load_partners(); 
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
    
    $('#start_date').datepicker({
            format: 'yyyy-mm-dd',
            language: 'EN',
            autoclose: true,
            setDate: new Date(),
            todayHighlight: true
     });
    
    load_ind_partner(pos);
    }
    </script>
</body>
</html>