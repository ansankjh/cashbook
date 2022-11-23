<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	// 로그인 안되어있으면 못들어오게
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>비밀번호 수정</h1>
	<div>
		<form action="<%=request.getContextPath()%>/updateMemberAction.jsp">
			<div>
				<table>
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td>
							<input type="text" name="memberName" value="<%=memberName%>" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>기존 비밀번호</td>
						<td>
							<input type="password" name="memberPw">
						</td>
					</tr>
					<tr>
						<td>수정할 비밀번호</td>
						<td>
							<input type="password" name="memberPw2">
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