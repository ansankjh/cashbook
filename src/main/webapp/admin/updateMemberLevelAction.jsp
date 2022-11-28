<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberId = request.getParameter("memberId");
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));

	// 모델 호출 매개값
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberId(memberId);
	member.setMemberLevel(memberLevel);
	
	
	// Model
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(member);
	if(row == 1) {
		String msg = URLEncoder.encode("등급변경 완료","utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?msg="+msg);
	}
%>