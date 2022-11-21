<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 1) Controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	// System.out.println(memberId);
	// System.out.println(memberPw);
	Member paramMember = new Member(); // 모델 호출시 매개값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// M호출
	MemberDao memberDao = new MemberDao();	
	Member resultMember  = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp";	
	if(resultMember != null) {
		// 로그인 성공시
		session.setAttribute("loginMember", resultMember); // session안에 로그인 ID와 이름이 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>