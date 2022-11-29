<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 관리자 아니면 못들어온다
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String msg = request.getParameter("msg");
	// System.out.println(commentNo);
	
	// Model
	CommentDao commentDao = new CommentDao();
	Comment st = commentDao.selectCommentOne(commentNo);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCommentForm</title>
	</head>
	<body>
		<h1>답변수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
				<input type="hidden" name="commentNo" value="<%=commentNo%>">
				<div>
					<table>
						<tr>
							<td>답변내용</td>
							<td>								
								<textarea cols="50" rows="5" name="commentMemo"><%=st.getCommentMemo()%></textarea>
							</td>
						</tr>
						<tr>
							<td>수정날짜</td>
							<td>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<button type="submit">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>