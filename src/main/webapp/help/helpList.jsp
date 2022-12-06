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
	int cnt = helpDao.helpCount();
	int lastPage = cnt / rowPerPage;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>helpList</title>
	</head>
	<body>
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>	
		<h1>고객센터</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<table border="1">
				<tr>
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
						<tr>
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
										<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>&helpMemo=<%=m.get("helpMemo")%>">수정</a>
								<%
									}
								%>
							</td>
							<td>
								<%
									if(m.get("commentMemo") == null) {
								%>
										<a href="<%=request.getContextPath()%>/help/deleteHelp.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>
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
		<div>
		<!-- 페이징 -->
			<a href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%=currentPage%>
			<%
				}
			
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/help/helpList.jsp?currentPage=<%=lastPage%>">마지막</a>
		
		
		</div>
		<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의하기</a>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp">뒤로</a>
	</body>
</html>