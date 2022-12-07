<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw"); // 기존비번
	String memberPw2 = request.getParameter("memberPw2"); // 수정할 비밀번호
	
	// 비밀번호가 null이나 공백이 들어오면 출력할 메시지
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw2") == null
		|| request.getParameter("memberPw").equals("") || request.getParameter("memberPw2").equals("")) {
		String msg = URLEncoder.encode("공백이 있습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	/*
	System.out.println(memberId);
	System.out.println(memberPw);
	System.out.println(memberPw2);
	*/
	
	// Model 불러올 매개값
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberPw2(memberPw2);

	
	// 모델 호출
	MemberDao memberDao = new MemberDao();
	if(memberDao.memberPwCk(member)) {
		String msg = URLEncoder.encode("기존 비밀번호와 같습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
	int row = memberDao.pwUpMember(member);
	if(row == 1) {
		String msg = URLEncoder.encode("비밀번호 변경 완료", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	} else {
		String msg = URLEncoder.encode("비밀번호 오류", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
	}	
%>