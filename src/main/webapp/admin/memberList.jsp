<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 현재페이지
	int currentPage = 1;
	
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	// Model 호출
	MemberDao memberDao = new MemberDao();
	// 멤버 목록 가져오는 메서드
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	// lastPage 구할때 필요한 행의수
	int cnt = memberDao.selectMemberCount();
	int lastPage = cnt / rowPerPage;
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
	</ul>
	<div>
		<!-- memberList contents -->
		<!-- 여기서는 오로지 멤버 탈퇴시키는거랑 멤버 레벨수정 있음 인서트는 없음 -->
		<h1>멤버목록</h1>
		<table border="1">
			<tr>
				<th>멤버번호</th>
				<th>멤버아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정일자</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>				
			</tr>
			<tr>
				<%
					for(Member m : list) {
				%>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
				<%
					}
				%>
				<td>
					<a href="<%=request.getContextPath()%>/updateMemberLevelForm.jsp">레벨수정</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/deleteMemberAdminForm.jsp">회원강퇴</a>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>