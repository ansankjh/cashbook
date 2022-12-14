<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	String msg = request.getParameter("msg");
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	// 관리자 아니면 못들어온다
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));		
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	// Model
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpListAll(beginRow, rowPerPage);
	int cnt = helpDao.helpCount();
	// System.out.println(cnt);
	int lastPage = cnt / rowPerPage;
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
			.po {
				position : relative;
				top : 150px;
			}
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>helpListAll</title>
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
        
		<div class="conatiner">
			<h1 class="po" style="color:white" align="center">고객센터 문의목록</h1>
			<%
				if(msg !=null) {
			%>
					<%=msg%>
			<%
				}
			%>
			<div align="center" style="margin-top:220px;">
				<table class="table table-bordered" style="width:1300px; color:white;">
					<tr style="background-color:black;">	
						<th>번호</th>
						<th>문의내용</th>
						<th>회원ID</th>
						<th>문의날짜</th>
						<th>답변내용</th>
						<th>답변날짜</th>
						<th>답변추가 / 수정 / 삭제</th>
					</tr>
					<%
						for(HashMap<String, Object> m : list) {
					%>
							<tr>
								<td><%=m.get("helpNo")%></td>
								<td><%=m.get("helpMemo")%></td>
								<td><%=m.get("memberId")%></td>
								<td><%=m.get("helpCreatedate")%></td>
								<td><%=m.get("commentMemo")%></td>
								<td><%=m.get("commentCreatedate")%></td>
								<td>
									<%
										if(m.get("commentNo") == null) {
									%>
											<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">
												답변입력
											</a>
									<%
										} else {
									%>
											<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
											/
											<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
									<%
										} 
									%>
								</td>
							</tr>
					<%
						}				
					%>
				</table>
			</div>
			<div align="center">
			<!-- 페이징 -->
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>"><img src="assets/img/previous.png" style="width:50px;"></a>
				<span style="font-size:30px;"><%=currentPage%></span>
				<%
					}
				
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>"><img src="assets/img/next.png" style="width:50px;"></a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
		</div>
	</body>
</html>