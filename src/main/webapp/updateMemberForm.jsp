<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import ="java.net.*" %>
<%
	// 세션에 로그인 값이 없다면 로그인 페이지로 이동
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	String msg2 = request.getParameter("msg2");
	
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
	<h1>정보수정</h1>
	<%
		if(msg != null) {
	%>
			<%=msg%>
	<%
		} else if(msg2 != null) {
	%>
			<%=msg2%>
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