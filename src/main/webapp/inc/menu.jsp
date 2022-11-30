<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<a style="text-decoration:none;" href="<%=request.getContextPath()%>/cash/cashList.jsp">[홈]</a>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() == 0) {
%>
		<a style="text-decoration:none;" href="<%=request.getContextPath()%>/help/helpList.jsp">[고객센터]</a>
<%
	} else if(loginMember.getMemberLevel() == 1) {
%>
		<a style="text-decoration:none;" href="<%=request.getContextPath()%>/admin/adminMain.jsp">[관리자페이지]</a>
		<a style="text-decoration:none;" href="<%=request.getContextPath()%>/admin/noticeList.jsp">[공지관리]</a>
		<a style="text-decoration:none;" href="<%=request.getContextPath()%>/admin/categoryList.jsp">[카테고리관리]</a>
		<a style="text-decoration:none;" href="<%=request.getContextPath()%>/admin/memberList.jsp">[멤버관리]</a>
		<a style="text-decoration:none;" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">[고객센터]</a>
<%
	}
%>
