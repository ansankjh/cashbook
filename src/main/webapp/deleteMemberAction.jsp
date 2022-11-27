<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String memberPw = request.getParameter("memberPw");
	
	// 비밀번호가 null이나 공백으로 넘어오면 form 페이지로넘어갈
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
		String msg = URLEncoder.encode("비밀번호를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	// Model 불러올 매개값
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberName(memberName);
	member.setMemberPw(memberPw);
	
	// Model
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMember(member);
	
	if(row == 1) {
		session.invalidate(); // session에 저장된 값 초기화
		String msg = URLEncoder.encode("그동안 이용해주셔서 감사합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	} else {
		String msg = URLEncoder.encode("비밀번호 오류", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
	}
%>