<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() == 0) {
%>
	<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
		<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">홈</a></li>
		<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">고객센터</a></li>
	</ul>
<%
	} else if(loginMember.getMemberLevel() == 1) {
%>
	<div class="collapse navbar-collapse" id="navbarResponsive">
		<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">홈</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">고객센터</a></li>
		</ul>
	</div>
<%
	}
%>
