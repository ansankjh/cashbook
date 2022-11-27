<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	String msg = request.getParameter("msg");	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
	</head>
	<body>
		<h1>회원가입</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>	
		<div>
			<form action="<%=request.getContextPath()%>/insertMemberAction.jsp">
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
					<tr>
						<td>비밀번호 확인</td>
						<td>
							<input type="password" name="memberPw2">						
						</td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td>
							<input type="text" name="memberName">
						</td>
					</tr>
				</table>
				<div>
					<button type="submit">회원가입</button>
				</div>
			</form>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/loginForm.jsp">뒤로</a>
		</div>
	</body>
</html>