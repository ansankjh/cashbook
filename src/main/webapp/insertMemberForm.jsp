<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	String msg = request.getParameter("msg");	
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			div {
				text-align : center;
			}
			table {
				margin : auto;
			}
		</style>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>insertMemberForm</title>
		<!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
	</head>
	<body>
		<section class="page-section" id="contact">
			<div>
				<h1>회원가입</h1>
			</div>
			<%
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>					
			<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post" id="contactForm" data-sb-form-api-token="API_TOKEN">	
				<div class="row align-items-stretch mb-5">
					<div class="col-md-6">
						<div class="form-group">						
							<input style="width:400px;" id="name" type="text" placeholder="Your Id *" data-sb-validations="required" name="memberId">					
						</div>	
						<div class="form-group">		
							<input style="width:400px;" id="name" type="password" placeholder="Your PassWord *" data-sb-validations="required" name="memberPw">
						</div>
						<div class="form-group">	
							<input style="width:400px;" id="name" type="password" placeholder="Your Your PassWordCheck *" data-sb-validations="required" name="memberPw2">
						</div>		
						<div class="form-group">					
							<input style="width:400px;" id="name" type="text" placeholder="Your Name *" data-sb-validations="required" name="memberName">
						</div>				
					</div>	
				</div>		
				<div>
					<button type="submit">회원가입</button>
				</div>
			</form>
			<div>
				<a href="<%=request.getContextPath()%>/loginForm.jsp">뒤로</a>
			</div>
		</section>
	</body>
</html>