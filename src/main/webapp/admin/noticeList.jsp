<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model : notice list
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int cnt = noticeDao.selectNoticeCount(); // << lastPage 구하는데 씀
	
	int lastPage = cnt / rowPerPage;
		
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
			.position1 {
				position : absolute;
				top : -70px;
				left : 880px;
			}
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>noticeList</title>
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
		
	
		<!-- noticeList contents -->
		<div class="position1" align="center">
			<h1 align="center" style="color:white">공지사항</h1>
			<%
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지입력</a>
		</div>
		<div align="center" style="margin-top:230px;">
			<table style="color:white;">
				<tr>
					<th>공지내용</th>
					<th>공지날짜</th> <!-- createdate -->
					<th>수정</th>
					<th>삭제</th>
				</tr>			
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a>
							</td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a>
							</td>
						</tr>
				<%
					}
				%>			
			</table>
		</div>
		<div align="center">
		<!-- 페이징 -->
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%=currentPage%>
			<%
				}
			
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</body>
</html>