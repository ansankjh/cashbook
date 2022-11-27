<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import= "java.util.*" %>
<%
	// 회원 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 회원정보가 null이거나 관리자등급이 아니면 로그인화면으로 돌아가게 한다.
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String msg = request.getParameter("msg");
	// System.out.println(noticeNo);
	// Model 호출 매개값
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNotice(noticeNo); 
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateNoticeForm</title>
	</head>
	<body>
		<h1>공지수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/updateNoticeAction.jsp" method="post">
				<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
				<div>
					<table>
						<tr>
							<%
								for(Notice n : noticeList) {
							%>
									<td>공지내용</td>
									<td>
										<textarea cols="30" rows="10" name="noticeMemo"><%=n.getNoticeMemo()%></textarea>
									</td>
							<%
								}
							%>							
						</tr>
						<tr>
							
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