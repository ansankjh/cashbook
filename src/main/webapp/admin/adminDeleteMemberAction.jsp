<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import= "java.net.*" %>
<%
	// Controller
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	System.out.println(memberNo);
	
	// 모델 호출 매개값
	Member member =  new Member();
	member.setMemberNo(memberNo);
	
	// Model
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMemberByAdmin(member);
	
	if(row == 1) {
		String msg = URLEncoder.encode("회원강퇴","utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?msg="+msg);
	}
%>