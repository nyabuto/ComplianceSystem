<%-- 
    Document   : visits
    Created on : Apr 17, 2018, 5:20:46 PM
    Author     : GNyabuto
--%>

<%@page import="java.util.Calendar"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<title>LIP Visits</title>
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
				<li class="active">Visits Management Module</li>
			</ol>
		</div><!--/.row-->
                <br>
            <div>
               <button type="button" class="btn btn-success btn-raised" onclick="new_visit();" style="margin-left: 1%; margin-bottom: 1%; font-weight: 900;"><i class="icon-plus3 position-left"></i> New Visit</button>
           </div>
        <table id="data_table"  class="display cell-border row-border" style="width:100%">
       <thead>
            <tr> 
         <th> No </th>
         <th> Officer Name </th>
         <th> Officer phone </th>
         <th> Officer Email </th>
         <th> Project Name </th>
         <th>LIP Name</th>
         <th> Visit Date </th>
         <th> Review Start Date </th>
         <th> Review End Date </th>
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

function changed(){
          var review_start_date = $("#review_start_date").val();
          $('#review_end_date').val("");
          $('#review_end_date').datepicker({
            format: 'yyyy-mm-dd',
            language: 'EN',
            autoclose: true,
            startDate: new Date(review_start_date),
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
        load_visits();
    });
    
    function load_visits(){
            $.ajax({
        url:'load_visits',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,fullname,email,phone,lip_name,project_name,review_start_date,review_end_date,visit_date,output="";
             var dataSet=[];
        var data=raw_data.data;
        for (var i=0; i<data.length;i++){
            position++;
            id=fullname=email=phone=lip_name=project_name=review_start_date=review_end_date=visit_date="";
            if( data[i].id!=null){id = data[i].id;}
            if( data[i].fullname!=null){fullname = data[i].fullname;}
            if( data[i].email!=null){email = data[i].email;}
            if( data[i].phone!=null){phone = data[i].phone;}
            if( data[i].lip_name!=null){lip_name = data[i].lip_name;}
            if( data[i].project_name!=null){project_name = data[i].project_name;}
            if( data[i].review_start_date!=null){review_start_date = data[i].review_start_date;}
            if( data[i].review_end_date!=null){review_end_date = data[i].review_end_date;}
            if( data[i].visit_date!=null){visit_date = data[i].visit_date;}
            
            var output='<div class="dropdown"><a href="#" data-toggle="dropdown"><i class="glyphicon glyphicon-menu-hamburger"></i></a><ul class="dropdown-menu">';
                output+='<li><button class="btn btn-link" onclick=\"edit('+position+');\" ><i class="position-left"></i> Edit</button></li>';
                output+='<li><button class="btn btn-link" onclick=\"deleter('+position+');\" ><i class="position-left"></i> Delete</button></li>';
                output+='<input type="hidden" name="'+position+'" value="'+id+'" id="_'+position+'">';
                output+='</ul></div>';
         
            var minSet = [position,fullname,phone,email,project_name,lip_name,visit_date,review_start_date,review_end_date,output];
           
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
    
    
    function new_visit(){
            var dialog = bootbox.dialog({
    title: '<b>New Visit</b>',
    message: '<div class="row">' +
                    '<div class="col-md-12">' +
                        '<form id="new_user" method="post" class="form-horizontal">' +
                           
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Visit Date <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="visit_date" required name="visit_date" type="text" value="" onChange="visit_changed();" placeholder="Enter Visit Date" readonly class="form-control" style="width:80%;">' +
                                '</div>' +
                            '</div>' +
                            
                            
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Review Start Date <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="review_start_date" required name="review_start_date" onChange="changed();" type="text" value="" placeholder="Enter Review Start Date" readonly class="form-control"  style="width:80%;">' +
                                '</div>' +
                            '</div>' +
                            
                           
                              '<div class="form-group">' +
                                '<label class="col-md-4 control-label">Review End Date <b style=\"color:red\">*</b> : </label>' +
                                '<div class="col-md-8">' +
                                    '<input id="review_end_date" required name="review_end_date" type="text" value="" placeholder="Enter Review End Date" readonly class="form-control"  style="width:80%;">' +
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
     $('#visit_date').datepicker({
            format: 'yyyy-mm-dd',
            language: 'EN',
            autoclose: true,
            endDate: new Date(),
            setDate: new Date(),
            todayHighlight: true
     });
//     
//     $('#review_start_date').datepicker({
//            format: 'yyyy-mm-dd',
//            language: 'EN',
//            autoclose: true,
//            endDate: new Date(),
//            setDate: new Date(),
//            todayHighlight: true
//     });
//     
//     
//          $('#review_end_date').datepicker({
//            format: 'yyyy-mm-dd',
//            language: 'EN',
//            autoclose: true,
//            startDate: new Date(),
//            setDate: new Date(),
//            todayHighlight: true
//     });
     
    }
    </script>
</body>
</html>
