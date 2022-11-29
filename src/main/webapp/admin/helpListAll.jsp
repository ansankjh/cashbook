<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	String msg = request.getParameter("msg");
	Member loginMember = (Member)session.getAttribute("loginMember");
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
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	int cnt = helpDao.helpCount();
	// System.out.println(cnt);
	int lastPage = cnt / rowPerPage;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>helpListAll</title>
	</head>
	<body>
		<!-- header include -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>	
		<h1>고객센터 문의목록</h1>
		<%
			if(msg !=null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<table border="1">
			<tr>	
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
									<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">
										답변입력
									</a>
							<%
								} else {
							%>
									<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
									/
									<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
							<%
								} 
							%>
						</td>
					</tr>
			<%
				}				
			%>
		</table>
		<div>
		<!-- 페이징 -->
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%=currentPage%>
			<%
				}
			
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</body>
</html>