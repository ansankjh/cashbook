<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%
	// Controller
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
	<head>
		<style>			
			body {
			    background-image: url(assets/img/pass.jpg);
			    background-size: cover;			    
			}
			.font {
				color : white;
				text-align : center;
			}
			.position1 {
				position: relative;
				top : 200px;
			}
		</style>	
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>insertHelpForm</title>
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
		<h1 class="font position1" align="center">문의하기</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div class="container">
			<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
				<div align="center" style="margin-top : 230px">
					<div class="font">
						아이디 :
					</div>
					<div>
						<input style="width:400px;" type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
					</div>				
					<div class="font">
						문의내용 :
					</div>
					<div>
						<textarea cols="40" rows="10" name="helpMemo" placeholder="문의글을 입력해주세요."></textarea>
					</div>
					
				</div>
				<div align="center">
					<button type="submit"><img src="assets/img/question.jpg" style="width:120px;"></button>
				</div>	
			</form>
		</div>
	</body>
</html>