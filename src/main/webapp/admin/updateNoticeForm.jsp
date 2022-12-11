<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import= "java.util.*" %>
<%
	// 회원 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 회원정보가 null이거나 관리자등급이 아니면 로그인화면으로 돌아가게 한다.
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String msg = request.getParameter("msg");
	// System.out.println(noticeNo);
	// Model 호출 매개값
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNotice(noticeNo); 
	
	
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
		<title>updateNoticeForm</title>
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
			<h1 class="po" align="center" style="color:white">공지수정</h1>
			<%
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>
			<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
				<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
				<div>
					<table align="center" style="margin-top:200px;">
						<tr>
							<%
								for(Notice n : noticeList) {
							%>
									<td>
										<textarea cols="30" rows="10" name="noticeMemo"><%=n.getNoticeMemo()%></textarea>
									</td>
							<%
								}
							%>							
						</tr>
						<tr>
							
						</tr>
					</table>
				</div>
				<div align="center">
					<button type="submit">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>