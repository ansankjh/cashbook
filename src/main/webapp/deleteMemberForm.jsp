<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import=  "vo.*" %>
<%
	// 비로그인이면 당연히 회원탈퇴 페이지 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 로그인정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
	String msg = request.getParameter("msg");
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deleteMemberForm</title>
	</head>
	<body>
		<h1>회원탈퇴</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
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
							<td>비밀번호</td>
							<td>
								<input type="password" name="memberPw">
							</td>
						</tr>
					</table>
				</div>
				<div>
					<button type="submit">회원탈퇴</button>
				</div>
			</form>
		</div>
	</body>
</html>