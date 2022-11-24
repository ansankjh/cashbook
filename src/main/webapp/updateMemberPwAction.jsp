<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// C	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw"); // 기존비번
	String memberPw2 = request.getParameter("memberPw2"); // 수정할 비밀번호
	
	/*
	System.out.println(memberId);
	System.out.println(memberPw);
	System.out.println(memberPw2);
	*/
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberPw2(memberPw2);

	
	// 모델 호출
	MemberDao memberDao = new MemberDao();
	int row = memberDao.pwUpMember(member);
	if(row == 1) {
		String msg = URLEncoder.encode("비밀번호 변경 완료", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	} else {
		String msg = URLEncoder.encode("기존 비밀번호가 다릅니다.", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
	}
	
	
	
	
	
	
	
	
	
%>