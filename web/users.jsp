<%-- 
    Document   : users
    Created on : Apr 16, 2018, 12:30:05 PM
    Author     : GNyabuto
--%>

<%@page import="java.util.Calendar"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<title>Users</title>
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
				<li class="active">User Management </li>
			</ol>
		</div><!--/.row-->
                <br>
            <div>
               <button type="button" class="btn btn-success btn-raised" onclick="new_user();" style="margin-left: 1%; margin-bottom: 1%;"><i class="icon-plus3 position-left"></i> New User</button>
           </div>
        <table id="data_table"  class="display" style="width:100%">
       <thead>
            <tr> 
         <th> No </th>
         <th> Full Name </th>
         <th> Email </th>
         <th> Phone </th>
         <th> Gender </th>
         <th> User Type </th>
         <th> Status </th>
         <th> Action </th>
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
} ); 
    </script>
    
    <script>
   $(document).ready(function() {
        load_users();
    });
    
    function load_users(){
            $.ajax({
        url:'load_users',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,fullname,email,phone,level,level_label,status,status_label,gender,gender_label,output="";
             var dataSet=[];
        var data=raw_data.data;
        for (var i=0; i<data.length;i++){
            position++;
            id=fullname=email=phone=level=level_label=status=status_label=gender=gender_label="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].fullname!=null){fullname = data[i].fullname;}
            if( data[i].email!=null){email = data[i].email;}
            if( data[i].phone!=null){phone = data[i].phone;}
            if( data[i].level!=null){level = data[i].level;}
            if( data[i].status!=null){status = data[i].status;}
            if( data[i].gender!=null){gender = data[i].gender;}
            
            if(level==1){
               level_label = '<span class="label label-success">Admin</span> ';   
            }
            else{
              level_label = '<span class="label label-warning">User</span> '; 
            }
            
            if(status==1){
               status_label = '<span class="label label-success">Active</span> ';  
            }
            else{
                status_label = '<span class="label label-danger">Inactive</span> ';   
            }
            
            if(gender=="m"){
               gender_label = '<span class="">Male</span> '; 
            }
            else if(gender=="f"){
             gender_label = '<span class="">Female</span> '; 
            }
            else{
                 gender_label = '<span class="">No Gender</span> '; 
            }
            var output='<div class="dropdown"><a href="#" data-toggle="dropdown"><i class="glyphicon glyphicon-menu-hamburger"></i></a><ul class="dropdown-menu">';
                output+='<li><button class="btn btn-link" onclick=\"remove_entry('+position+');\" ><i class="position-left"></i> Remove User</button></li>';
                output+='<input type="hidden" name="'+position+'" value="'+id+'" id="_'+position+'">';
                output+='<input type="hidden" name="'+position+'" value="'+status+'" id="status_'+position+'">';
                output+='</ul></div>';
                
            var minSet = [position,fullname,email,phone,gender_label,level_label,status_label,output];
           
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
    
    
    function new_user(){
            var dialog = bootbox.dialog({
    title: '<b>New User Registration</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_user" method="post" class="form-horizontal">' +
                           
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">FullName <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="fullname" required name="fullname" type="text" value="" placeholder="Enter fullname" class="form-control" style="width:80%;">' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Email <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="email" required name="email" type="text" value="" placeholder="Enter Email" class="form-control"  style="width:80%;">' +
                                '</div>' +
                            '</div>' +
                            
                           
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Phone Number <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="phone" required name="phone" type="text" value="" placeholder="Enter Phone" class="form-control"  style="width:80%;">' +
                                '</div>' +
                            '</div>' +
                            
                           
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Gender <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<select id="gender" required name="gender" class="form-control" required  style="width:80%;">'+
                                    '<option value=\"f\">Female</option>'+
                                    '<option value=\"m\">Male</option>'+
                                    '</select>' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Enter Password <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="pass1" required name="pass1" type="password" value="" placeholder="Enter Password" class="form-control"  style="width:80%;">' +
                                '</div>' +
                            '</div>' +
                            
                           
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Repeat Password <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="pass2" required name="pass2" type="password" value="" placeholder="Repeat Password" class="form-control"  style="width:80%;">' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">User Type <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<select id="level" required name="level" class="form-control" required  style="width:80%;">'+
                                    '<option value=\"1\">Admin</option>'+
                                    '<option value=\"2\">User</option>'+
                                    '</select>' +
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
             var fullname,email,phone,gender,pass1,pass2,level;
                fullname = $("#fullname").val();
                email = $("#email").val();
                phone = $("#phone").val();
                gender = $("#gender").val();
                pass1 = $("#pass1").val();
                pass2 = $("#pass2").val();
                level = $("#level").val();
                if(fullname!="" && email!="" && phone!="" && gender!="" && pass1!="" && level!=""){
                if(pass1==pass2){
                var form_data = {"fullname":fullname,"email":email,"phone":phone,"gender":gender,"pass1":pass1,"pass2":pass2,"level":level};
                var theme="",header="",message="";
                var url = "register";
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
                                       load_users(); 
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
                          $.jGrowl('Passwords do not match', {
                                        position: 'top-center',
                                        header: 'Error',
                                        theme: 'bg-danger'
                                   });       
                             }
                             return false;
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
    }
    
    
    
    
    function remove_entry(pos){
                   var id = $("#_"+pos).val();   
                   var status = $("#status_"+pos).val();  
                   var status_label="";
                   if(status==1){
                    status_label="De-activate Instead" ;  
                   }
                   else if(status==0){
                    status_label="Activate Instead" ;  
                   }
       var dialog = bootbox.dialog({
        title: "<b  style='text-align:center;'>Delete/Deactivate User<b>",
        message: "Are you sure you want to delete this partner?",
        buttons: {
            ok: {
                label: '<i class="fa fa-check"></i> Yes',
                className: 'btn-success'
            },
            activate: {
                label: '<i class="fa fa-check"></i> '+status_label,
                className: 'btn-warning'
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
    </script>
</body>
</html>