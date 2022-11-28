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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>	
	<div>
		<!-- noticeList contents -->
		<h1>공지</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지입력</a>
		<table>
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
	<div>
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