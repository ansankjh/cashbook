<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	// 관리자 아니면 못들어온다
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String msg = request.getParameter("msg");
	// System.out.println(helpNo);
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertCommentForm</title>
	</head>
	<body>
		<h1>답변내용</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=memberId%>">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<div>
					<table>
						<tr>
							<td>답변내용</td>
							<td>								
								<textarea cols="50" rows="5" name="commentMemo"></textarea>
							</td>
						</tr>
						<tr>
							<td>수정날짜</td>
							<td></td>
						</tr>
						<tr>
							<td>답변날짜</td>
							<td></td>
						</tr>
					</table>
				</div>
				<div>
					<button type="submit">답변</button>
				</div>		
			</form>
		</div>
	</body>
</html>