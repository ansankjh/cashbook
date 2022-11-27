<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "dao.*" %>
<%@ page import= "vo.*" %>
<%@ page import= "java.util.*" %>
<%
	String msg  = request.getParameter("msg");
	// C
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int cnt = noticeDao.selectNoticeCount();
	// System.out.println(cnt);
	int lastPage = cnt / rowPerPage;
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
	</head>
	<body>
		<!-- 공지(5개)목록 페이징 -->
		<div>
			<table>
				<tr>
					<th>공지내용</th>
					<th>날짜</th>
				</tr>
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
			<div>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%=currentPage%>
				<%	
					}
					
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>				
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
		</div>
		<h1>로그인</h1>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
			</table>
			<div>
				<button type="submit">로그인</button>
			</div>
			<div>
				<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
			</div>
		</form>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
	</body>
</html>
