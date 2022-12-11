<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%
	// Controller
	// 비로그인이 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");	
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
	<head>
		<style>			
			body {
			    background-image: url(assets/img/header-bg.jpg);
			    background-size: cover;			    
			}
			.font {
				color : white;
				text-align : center;
			}
			.position1 {
				position: relative;
				top : 210px;
			}
		</style>	
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>updateHelpForm</title>
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
		<h1 class="font position1" align="center">문의글수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div class="container">
			<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<div align="center" style="margin-top:250px;">
					<table>
						<tr>
							<td><textarea cols="50" rows="10" name="helpMemo"><%=helpMemo%></textarea></td>
						</tr>
					</table>				
				</div>
				<div align="center">
					<button style="width:100px;" type="submit">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>