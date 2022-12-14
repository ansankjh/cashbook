<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import= "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String msg = request.getParameter("msg");
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();	
	
	// 최근공지 5개, 최근멤버 5명
	
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
				position : relative;
				top : 130px;
			}
			.po2 {
				position : relative;
				bottom : -170px;
				right : -1170px;
			}
			.po3 {
				position : relative;
				top : 150px;
			}
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>categoryList</title>
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
                    	<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
                    </ul>
                </div>
            </div>
        </nav>	
	
		<div class="container">
			<!-- categoryList contents -->		
			<h1 class="po" style="color:white" align="center">카테고리 목록</h1>
			<%
				if(msg != null) {
			%>
					<div class="po3" align="center" style="color:yellow; font-size:30px;">
						<%=msg%>
					</div>
			<%
				}
			%>
			<a class="btn btn-warning po2" href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
			<div align="center" style="margin-top:180px;">
				<table class="table table-bordered" style="width:1300px; color:white;">
					<tr style="background-color:black;">
						<th>번호</th>
						<th>수입/지출</th>
						<th>이름</th>
						<th>마지막 수정 날짜</th>
						<th>생성날짜</th>
						<th>수정</th>
						<th>삭제</th>	
					</tr>			
					<%
						for(Category c : categoryList) {
					%>
							<tr>
								<td><%=c.getCategoryNo()%></td>
								<td><%=c.getCategoryKind() %></td>
								<td><%=c.getCategoryName()%></td>
								<td><%=c.getUpdatedate()%></td>
								<td><%=c.getCreatedate()%></td>
								<td><a class="btn btn-info" href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
								<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
							</tr>
					<%
						}
					%>			
				</table>
			</div>
		</div>
	</body>
</html>