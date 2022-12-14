<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import= "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");

	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// System.out.println(loginMember);
	
	// 페이징 작업
	// 현재 페이지 받아오기 	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// rowPerPage 최근 공지 5개
	int rowPerPage = 5;
	// beginRow 리스트의 시작위치
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	// 공지 목록
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	// 멤버 목록
	ArrayList<Member> memberList = noticeDao.selectMember();
	// 페이징에 쓰일 총 행의 수 & 마지막 페이지
	int cnt = noticeDao.selectNoticeCount();
	// System.out.println(cnt);
	int lastPage = cnt / rowPerPage;
	// System.out.println(lastPage);	
	
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<style>			
			body {
			    background-image: url(assets/img/camera.jpg);
			    background-size: cover;
			}
			tr, td, th {
				text-align : center;
				vertical-align : middle;
			}
			.po0 {
				position : relative;
				top : 160px;
			}
			.po1 {
				position : absolute;
				top : 300px;
				left : 250px;
			}
			.po2 {
				position : absolute;
				top : 300px;
				right : 250px;
			}
			.po3 {
				position : relative; 
				top : 180px;
				left : 115px;
			}
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>adminMain</title>
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
                    	<jsp:include page="/inc/menu.jsp"></jsp:include>    
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/updateMemberForm.jsp">정보수정</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호수정</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>						                
                    </ul>
                </div>
            </div>
        </nav>       		
		<div class="container">
			<h1 class="po0" style="color:white;" align="center">관리자 페이지</h1>
			<!-- adminMain content&페이징 -->
			<div>
				<table class="table table-bordered po1" style="width:500px;">
					<tr class="align-middle bg-dark text-warning" align="center">
						<th>공지내용</th>
						<th style="width:200px;">날짜</th>
					</tr>
					<!-- 공지내용 및 날짜 -->
					<%
						for(Notice n : list) {
					%>
							<tr class="align-middle bg-white">
								<td><%=n.getNoticeMemo()%></td>
								<td><%=n.getCreatedate()%></td>
							</tr>
					<%
						}
					%>
				</table>
				<table class="table table-bordered po2" style="width:500px;">
					<tr class="align-middle bg-dark text-warning" align="center">
						<th>아이디</th>
						<th>등급</th>
					</tr>
					<%
						for(Member m : memberList) {
					%>
							<tr class="align-middle bg-white">
								<td><%=m.getMemberId()%></td>
								<td><%=m.getMemberLevel()%></td>
							</tr>
					<%
						}
					%>
				</table>
			</div>
			<!-- 페이징 -->
			<div class="po3">
				<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=<%=currentPage-1%>"><img src="assets/img/previous.png" style="width:50px;"></a>
				<span style="font-size:30px;"><%=currentPage%></span>
				<%
					}
				
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=<%=currentPage+1%>"><img src="assets/img/next.png" style="width:50px;"></a>
				<%
					}
				%>				
				<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
		</div>		
	</body>
</html>