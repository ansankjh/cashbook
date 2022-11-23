<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
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
</body>
</html>
