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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>		
	<div>
		<!-- adminMain content&페이징 -->
		<table>
			<tr>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<!-- 공지내용 및 날짜 -->
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%
				}
			%>			
		</table>
		<!-- 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%=currentPage%>
			<%
				}
			
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>				
			<a href="<%=request.getContextPath()%>/admin/adminMain.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</div>
</body>
</html>