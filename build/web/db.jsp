<%-- 
    Document   : db
    Created on : Apr 13, 2018, 8:46:26 AM
    Author     : GNyabuto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Compliance System</title>
        <link rel="shortcut icon" href="images/hsdsa/icon.png" style="height: 20px;padding: 0px; margin: 0px;"/>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/datepicker3.css" rel="stylesheet">
	<link href="css/styles.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Dancing+Script" />
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Merienda+One" />
<style>
    .title{
        font-family: Merienda One;
	font-size: 30px;
	font-style: normal;
	font-variant: normal;
	font-weight: 900;
	line-height: 26.4px;
    }    
    .row{
        margin-top: 5%;
    }
    .header{
        padding-top: 0%;
    } 
    .panel-body{
        padding-bottom: 2%;
    } 
    body{
        max-width: 90%;
    }
    .header-img{
        max-width: 90%;
    }
    table{
        margin-left: 10%;
    }
    tr.spaceUnder>td {
  padding-bottom: 8%;
}

</style>
 
</head>
<body>
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
                            
                            
                            
				<!--<div class="panel-heading">Log in</div>-->
				<div class="panel-body">
                                        <form action="dbsetup">
						<div class="panel panel-body login-form">
							<div class="text-center header">
                                <div class="title">Compliance System</div>
                                <br>
                                <div class="icon-object border-slate-300 text-slate-300"><img class='header-img' style="height: 50px;" src="images/hsdsa/hsdsa-full.png"></div>
                                <h4 style="font-weight: bolder;" class="content-group">Database setup</h4>
							</div>

							<!--<div class="form-group ">-->
                                                            <table> <tr class="form-group spaceUnder"><td><b>Host Name: </b></td> <td><input id="hostname" type=text required name="hostname" placeholder="e.g localhost:3306" value="localhost:3306" class="form-control" ></td></tr>
								
							<!--</div>-->
							<!--<div class="form-group has-feedback has-feedback-left">-->
								<tr  class="form-group spaceUnder"><td><b>Database: </b></td> <td> <input id="database"  type=text required name="database" value="compliance"  class="form-control" placeholder="comply system"></td></tr>
							<!--</div>-->
							<!--<div class="form-group has-feedback has-feedback-left">-->
								<tr  class="form-group spaceUnder"><td><b>Username: </b></td> <td> <input id="user"  type=text required name="user" class="form-control" value="root" placeholder="e.g root"  ></td></tr>
							<!--</div>-->

							<!--<div class="form-group has-feedback has-feedback-left">-->
								 <tr  class="form-group spaceUnder"><td><b>Password: </b></td> <td> <input id="password"  type=password  name="password" placeholder="Password" class="form-control"></td></tr></table>
							<!--</div>-->

<!--							<div class="form-group login-options">
								
							</div>-->

							<div class="form-group">
								<button type="submit" class="btn bg-pink-400 btn-block">Login <i class="icon-arrow-right14 position-right"></i></button>
							</div>
                                                        </div>
					</form>
				</div>
			</div>
		</div><!-- /.col-->
	</div><!-- /.row -->	
	

<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
