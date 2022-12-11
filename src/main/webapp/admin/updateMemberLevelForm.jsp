<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String msg = request.getParameter("msg");
	// System.out.println(memberNo);
	
	// 모델 호출 매개값
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	// Model
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMember(memberNo);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
			    background-image: url(assets/img/a1.jpg);
			    background-size: cover;			    
			}
			.po1 {
				position : relative;
				top : 150px;				
			}
			.po_bt {
				position : relative;
				bottom : 10px;
			}
		</style>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>updateMemberLevelForm</title>
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
			<h1 class="po1" align="center" style="color:white">회원등급수정</h1>
			<%
				if(msg != null) {
			%>
					<span style="color:white"><%=msg%></span>
			<%
				}
			%>
			<form action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp" method="post">
				<input type="hidden" name="memberNo" value="<%=memberNo%>">
				<div align="center" style="margin-top:200px;">
					<table class="table table-bordered" style="width:350px; color:white;">			
						<%
							for(Member m : list) {
						%>
								<tr>
									<td>아이디</td>						
									<td>
										<input type="text" name="memberId" value="<%=m.getMemberId()%>">
									</td>
								</tr>
								<tr>
									<td>회원등급</td>
									<td>
										<input type="text" name="memberLevel" value="<%=m.getMemberLevel()%>">
									</td>
								</tr>								
						<%
							}
						%>						
					</table>
				</div>
				<div class="po_bt" align="center">
					<button type="submit">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>
