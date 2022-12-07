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
			.center {
				text-align : center;
				font-size : 30pt;
				font-weight : bold;
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
				<h1 style="color:blue;">회원가입</h1>
			</div>
			<%
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>					
			<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post" id="contactForm" data-sb-form-api-token="API_TOKEN">	
				<div>
					<div>
						<div class="form-group" align="center">						
							<input style="width:400px;" id="name" type="text" placeholder="아이디를 입력해주세요." data-sb-validations="required" name="memberId">					
						</div>	
						<div class="form-group" align="center">		
							<input style="width:400px;" id="name" type="password" placeholder="비밀번호를 입력해주세요." data-sb-validations="required" name="memberPw">
						</div>
						<div class="form-group" align="center">	
							<input style="width:400px;" id="name" type="password" placeholder="비밀번호를 한번 더 입력해주세요." data-sb-validations="required" name="memberPw2">
						</div>		
						<div class="form-group" align="center">					
							<input style="width:400px;" id="name" type="text" placeholder="이름을 입력해주세요." data-sb-validations="required" name="memberName">
						</div>				
					</div>	
				</div>		
				<div class="form-group center">
					<button style="width:400px; height:70px;" type="submit">회원가입</button>
				</div>
			</form>			
		</section>
	</body>
</html>