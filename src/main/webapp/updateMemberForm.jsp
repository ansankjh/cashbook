<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import ="java.net.*" %>
<%
	// 비로그인 상태이면 로그인화면으로 이동
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	
	// 로그인 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
	

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberForm</title>
	</head>
	<body>
		<h1>정보수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/updateMemberAction.jsp">
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
							<input type="text" name="memberName" value="<%=memberName%>">
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
					<button type="submit">수정</button>
				</div>
			</form>
		</div>	
	</body>
</html>