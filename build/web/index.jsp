<%-- 
    Document   : index
    Created on : Apr 12, 2018, 4:09:28 PM
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
        margin-top: 10%;
    }
    .header{
        padding-top: 8%;
    } 
    .panel-body{
        padding-bottom: 7%;
    } 
    body{
        max-width: 90%;
    }
    .header-img{
        max-width: 90%;
    }
</style>
 
</head>
<body>
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
                            
                            <div class="text-center header">
                                <div class="title">Compliance System</div>
                                <br>
                                <div class="icon-object border-slate-300 text-slate-300"><img class='header-img' style="height: 50px;" src="images/hsdsa/hsdsa-full.png"></div>
                                <h4 style="font-weight: bolder;" class="content-group">Login to your account </h4>
							</div>
                            
				<!--<div class="panel-heading">Log in</div>-->
				<div class="panel-body">
                                    <form role="form" method="post" action="login">
                                        <fieldset>
                                            <div class="form-group">
                                                    <input class="form-control" placeholder="E-mail" name="email" type="email" autofocus="">
                                            </div>
                                            <div class="form-group">
                                                    <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                            </div>
                                            <div class="form-group">
                                                    <input class="form-control btn-info" placeholder="Password" name="password" type="submit" value=" Login">
                                            </div>
                                        </fieldset>
					</form>
				</div>
			</div>
		</div><!-- /.col-->
	</div><!-- /.row -->	
	

<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
