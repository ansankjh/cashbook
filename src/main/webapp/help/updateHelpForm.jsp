<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%
	// Controller
	// 비로그인이 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");	
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateHelpForm</title>
	</head>
	<body>
		<h1>문의글수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<div>
					<table>
						<tr>
							<th>문의글수정</th>							
						</tr>
						<tr>
							<td><textarea cols="50" rows="5" name="helpMemo"><%=helpMemo%></textarea></td>
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