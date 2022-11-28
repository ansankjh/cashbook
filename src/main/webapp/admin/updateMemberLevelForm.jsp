<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String msg = request.getParameter("msg");
	// System.out.println(memberNo);
	
	// 모델 호출 매개값
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	// Model
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMember(memberNo);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>회원등급수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp" method="post">
				<input type="hidden" name="memberNo" value="<%=memberNo%>">
				<div>
					<table>						
						<%
							for(Member m : list) {
						%>
								<tr>
									<td>아이디</td>						
									<td>
										<input type="text" name="memberId" value="<%=m.getMemberId()%>">
									</td>
								</tr>
								<tr>
									<td>회원등급</td>
									<td>
										<input type="text" name="memberLevel" value="<%=m.getMemberLevel()%>">
									</td>
								</tr>								
						<%
							}
						%>						
					</table>
				</div>
				<div>
					<button type="submit">등급수정</button>
				</div>
			</form>
		</div>
	</body>
</html>
