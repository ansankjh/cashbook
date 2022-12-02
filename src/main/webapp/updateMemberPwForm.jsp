<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	// 로그인 안되어있으면 못들어오게
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 로그인 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberPwForm</title>
	</head>
	<body>
		<h1>비밀번호 수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp">
				<div>
					<table>
						<tr>
							<td>아이디</td>
							<td>
								<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
							</td>
						</tr>					
						<tr>
							<td>기존 비밀번호</td>
							<td>
								<input type="password" name="memberPw">
							</td>
						</tr>
						<tr>
							<td>새로운 비밀번호</td>
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