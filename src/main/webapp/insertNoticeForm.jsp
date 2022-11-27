<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	// 회원정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 회원정보가 null이거나 등급이 낮으면 로그인화면으로
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertNoticeForm</title>
	</head>
	<body>
		<h1>공지입력</h1>
		<div>
			<form action="<%=request.getContextPath()%>/insertNoticeAction.jsp" method="post">
				<div>
					<table>
						<tr>
							<td>공지내용</td>
							<td>
								<textarea cols="30" rows="5" name="noticeMemo"></textarea>
							</td>
						</tr>
						<tr>
							<td>입력날짜</td>
							<td></td>
						</tr>
					</table>
				</div>
				<div>
					<button type="submit">공지입력</button>
				</div>
			</form>
		</div>
	</body>
</html>