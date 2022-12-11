<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	String msg = request.getParameter("msg");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	// 멤버 목록 가져오는 메서드
	ArrayList<Member> list = memberDao.selectMemberListByPage();
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
			    background-image : url(assets/img/camera.jpg);
			    background-size : cover;
			}			
			tr, td, th {
				text-align : center;
				vertical-align : middle;
			}
			.po {
				position : absolute;
				top : -80px;
				left : 715px;
			}
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>memberList</title>
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
	<body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand " href="#page-top"><%=loginMember.getMemberName()%>님(등급:<%=loginMember.getMemberLevel()%>)</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                    	<li class="nav-item"></li>
                    	<jsp:include page="/inc/menu.jsp"></jsp:include>    
                    </ul>
                </div>
            </div>
        </nav>	
	
		<div class="container">
			<!-- memberList contents -->
			<!-- 여기서는 오로지 멤버 탈퇴시키는거랑 멤버 레벨수정 있음 인서트는 없음 -->
			<h1 class="po" style="color:white">멤버목록</h1>
			<%
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>
			<div align="center" style="margin-top:220px;">
				<table class="table table-bordered" style="width:1300px; color:white;">
					<tr style="background-color:black;">
						<th>멤버번호</th>
						<th>멤버아이디</th>
						<th>레벨</th>
						<th>이름</th>
						<th>마지막수정일자</th>
						<th>생성일자</th>
						<th>레벨수정</th>
						<th>강제탈퇴</th>				
					</tr>			
					<%
						for(Member m : list) {
					%>
							<tr>
								<td><%=m.getMemberNo()%></td>
								<td><%=m.getMemberId()%></td>
								<td><%=m.getMemberLevel()%></td>
								<td><%=m.getMemberName()%></td>
								<td><%=m.getUpdatedate()%></td>
								<td><%=m.getCreatedate()%></td>
								<td><a class="btn btn-info" href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>">레벨수정</a></td>
								<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=m.getMemberNo()%>">회원강퇴</a></td>
							</tr>
					<%
						}
					%>				
					
				</table>
			</div>
		</div>		
	</body>
</html>