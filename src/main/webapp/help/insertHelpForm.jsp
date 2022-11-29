<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%
	// Controller
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertHelpForm</title>
	</head>
	<body>
		<h1>문의하기</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
				<div>
					<table>						
						<tr>
							<td>아이디</td>
							<td>
								<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>문의내용</td>
							<td>
								<textarea cols="50" rows="5" name="helpMemo"></textarea>
							</td>
						</tr>
						<tr>
							<td>수정날짜</td>
							<td></td>
						</tr>
						<tr>
							<td>생성날짜</td>
							<td></td>
						</tr>
					</table>
				</div>
				<div>
					<button type="submit">문의하기</button>
				</div>	
			</form>
		</div>
	</body>
</html>