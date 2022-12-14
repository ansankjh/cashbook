<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	// 비로그인이면 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String msg = request.getParameter("msg");
	// 페이징
	int currentPage= 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId, beginRow, rowPerPage);
	int cnt = helpDao.helpCountByMember(memberId);
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
			.font {
				color : white;				
			}
			.rect2 {
			    position : relative;
    			top : 100px;
   			}	
   			.rect3 {
				position : relative;
				top : 70px;
				left : 310px;
   			}
   			.rect4 {
				position : relative;
				top : 150px;
   			}	   			
   			
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>helpList</title>
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
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp" style="font-size:30px;">뒤로</a></li>
                    </ul>
                </div>
            </div>
        </nav>
      
		<h1 class="font rect2" align="center">고객센터</h1>
		<%
			if(msg != null) {
		%>
				<div class="rect4" align="center" style="color:yellow; font-size:30px;">
					<%=msg%>
				</div>
		<%
			}
		%>
		<div>
			<a class="rect3" href="<%=request.getContextPath()%>/help/insertHelpForm.jsp"><img src="assets/img/question.jpg" style="width:100px;"></a>
		</div>
		 <div class="container">
			<div align="center">
				<table class="table table-bordered font" style="margin-top:80px;">
					<tr class="bg-warning font rec" style="text-align:center;">
						<th>번호</th>
						<th>문의사항</th>
						<th>문의날짜</th>
						<th>답변</th>
						<th>답변날짜</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					<%
						for(HashMap<String, Object> m : list) {
					%>
							<tr class="font" style="text-align:center; vertical-align:middle;">
								<td><%=m.get("helpNo")%></td>
								<td><%=m.get("helpMemo")%></td>
								<td><%=m.get("helpCreatedate") %></td>				
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											답변전
									<%
										} else {
									%>
											<%=m.get("commentMemo")%>
									<%
										}
									%>								
								</td>
								<td>
									<%
										if(m.get("commentCreateDate") == null) {
									%>
											답변전
									<%
										} else {
									%>
											<%=m.get("commentCreateDate")%>
									<%
										}
									%>											
								</td>
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											<a class="btn btn-info" href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>&helpMemo=<%=m.get("helpMemo")%>">수정</a>
									<%
										}
									%>
								</td>
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											<a class="btn btn-danger" href="<%=request.getContextPath()%>/help/deleteHelp.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>
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
				<a class="btn btn-info" href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=<%=currentPage-1%>"><img src="assets/img/previous.png" style="width:50px;"></a>
				<span style="font-size:30px;"><%=currentPage%></span>
				<%
					}
				
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=<%=currentPage+1%>"><img src="assets/img/next.png" style="width:50px;"></a>
				<%
					}
				%>
				<a class="btn btn-info" href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
		</div>
	</body>
</html>