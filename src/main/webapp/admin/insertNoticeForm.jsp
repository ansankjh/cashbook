<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	// 회원정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 회원정보가 null이거나 등급이 낮으면 로그인화면으로
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
			    background-image: url(assets/img/a1.jpg);
			    background-size: cover;			    
			}
			.po {
				position : absolute;
				top : -50px;
				left : 715px;
			}
		</style>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>insertNoticeForm</title>
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
		<div class="container">
			<h1 class="po" align="center" style="color:white">공지입력</h1>
			<%
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>
			<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
				<div align="center" style="margin-top:200px;">
					<div>
						<textarea cols="40" rows="10" name="noticeMemo" placeholder="공지사항을 입력해주세요."></textarea>
					</div>
				</div>
				<div align="center">
					<button type="submit">공지입력</button>
				</div>
			</form>
		</div>
	</body>
</html>