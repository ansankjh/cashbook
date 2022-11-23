<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = request.getParameter("msg");
	String msg2 = request.getParameter("msg2");
	String msg3 = request.getParameter("msg3");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
						<%
							if(msg3 != null) {
						%>
								<%=msg3%>
						<%
							}
						%>
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
						<%
							if(msg2 != null) {
						%>
								<%=msg2%>
						<%
							}
						%>
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
</body>
</html>