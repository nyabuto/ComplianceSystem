<%-- 
    Document   : user_profile
    Created on : Apr 23, 2018, 6:29:48 PM
    Author     : GNyabuto
--%>

<%@page import="java.util.Calendar"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<title>Users Profile</title>
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
                            <li><a href="user_profile.jsp">
					<em class="fa fa-home"></em>
				</a></li>
				<li class="active">User Profile </li>
			</ol>
		</div><!--/.row-->
                <br>
        <div class="row"> 
                    <div class="col-md-12"> 
                        <form id="" method="post" action="update_user" class="form-horizontal"> 
                           
                              <div class="form-group"> 
                                <label class="col-md-4 control-label">Full Name <b style=\"color:red\">*</b> : </label> 
                                <div class="col-md-8"> 
                                    <input id="fullname" required name="fullname" type="text" value="" placeholder="Enter fullname" class="form-control" style="width:60%;"> 
                                </div> 
                            </div> 
                            
                            
                              <div class="form-group"> 
                                <label class="col-md-4 control-label">Email <b style=\"color:red\">*</b> : </label> 
                                <div class="col-md-8"> 
                                    <input id="email" required name="email" type="text" value="" placeholder="Enter Email" readonly class="form-control"  style="width:60%;"> 
                                </div> 
                            </div> 
                            
                           
                              <div class="form-group"> 
                                <label class="col-md-4 control-label">Phone Number <b style=\"color:red\">*</b> : </label> 
                                <div class="col-md-8"> 
                                    <input id="phone" required name="phone" type="text" value="" placeholder="Enter Phone" class="form-control"  style="width:60%;"> 
                                </div> 
                            </div> 
                            
                           
                              <div class="form-group"> 
                                <label class="col-md-4 control-label">Gender <b style=\"color:red\">*</b> : </label> 
                                <div class="col-md-8"> 
                                    <select id="gender" required name="gender" class="form-control" required  style="width:60%;">
                                    <option value=\"f\">Female</option>
                                    <option value=\"m\">Male</option>
                                    </select> 
                                </div> 
                            </div> 
                            
                            
                              <div class="form-group"> 
                                <label class="col-md-4 control-label">Enter Password <b style=\"color:red\">*</b> : </label> 
                                <div class="col-md-8"> 
                                    <input id="pass1" required name="pass1" type="password" value="" placeholder="Enter Password"  oninput="checkPasswords()" class="form-control"  style="width:60%;"> 
                                </div> 
                            </div> 
                            
                           
                              <div class="form-group"> 
                                <label class="col-md-4 control-label">Repeat Password <b style=\"color:red\">*</b> : </label> 
                                <div class="col-md-8"> 
                                    <input id="pass2" required name="pass2" type="password" value="" placeholder="Repeat Password"  oninput="checkPasswords()" class="form-control"  style="width:60%;"> 
                                </div> 
                            </div> 
                            
                            
                              <div class="form-group"> 
                                <label class="col-md-4 control-label"></label> 
                                <div class="col-md-8"> 
                                 <input id="" required name="" type="submit" value="Update Profile" placeholder="Repeat Password" class="form-control btn btn-info"  style=" margin-left:20%; width:20%;"> 
                                </div> 
                            </div> 
                            
                         </form> 
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
            <script type="text/javascript">
    
            function checkPasswords() {
                var password = document.getElementById('pass1');
                var conf_password = document.getElementById('pass2');

                if (password.value != conf_password.value) {
                    conf_password.setCustomValidity('Passwords do not match');
                } else {
                    conf_password.setCustomValidity('');
                }
                
          
        
            }
    
    </script>
	<script>
   $(document).ready(function() {
} ); 
    </script>
    
    <%if(session.getAttribute("message")!=null && session.getAttribute("code")!=null){
    String message = session.getAttribute("message").toString();
    String code =  session.getAttribute("code").toString();
    String theme="";
    if(code.equals("1")){
     theme="bg-success" ;  
    }
    else{
     theme="bg-danger";   
    }
    %>
     <script type="text/javascript">
     $.jGrowl('<%=message%>', {
        position: 'top-center',
        header: 'info',
        theme: '<%=theme%>'
     });
    </script>
    <% 
        session.removeAttribute("message");
        session.removeAttribute("code");}
    %>
    
    <script>
   $(document).ready(function() {
        load_users();
    });
    
    function load_users(){
            $.ajax({
        url:'load_profile',
        type:"post",
        dataType:"json",
        success:function(raw_data){
            var position=0,id,fullname,email,phone,level,level_label,status,status_label,gender,gender_label,output="";
             var dataSet=[];
        var data=raw_data.data;
            position++;
            id=fullname=email=phone=level=level_label=status=status_label=gender=gender_label="";
            if( data.fullname!=null){fullname = data.fullname;}
            if( data.email!=null){email = data.email;}
            if( data.phone!=null){phone = data.phone;}
            if( data.level!=null){level = data.level;}
            if( data.status!=null){status = data.status;}
            if( data.gender!=null){gender = data.gender;}
            
            if(gender=="m"){
               gender_label = '<option value="f">Female</option> '; 
               gender_label += '<option value="m" selected>Male</option> '; 
            }
            else if(gender=="f"){
             gender_label = '<option value="f" selected>Female</option> '; 
             gender_label += '<option value="m">Male</option> '; 
            }
            else{
             gender_label = '<option value="">Select Gender</option> '; 
             gender_label += '<option value="f">Female</option> '; 
             gender_label += '<option value="m">Male</option> ';     
            }
            $("#fullname").val(fullname);
            $("#email").val(email);
            $("#phone").val(phone);
            $("#gender").html(gender_label);

    }
    });
    }

    </script>
</body>
</html>