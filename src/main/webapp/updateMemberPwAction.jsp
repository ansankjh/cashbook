<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%
	// C
	
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String memberPw = request.getParameter("memberPw");
	String memberPw2 = request.getParameter("memberPw2");
	
	// 모델 호출시 매개값
	Member pwMember = new Member();
	pwMember.setMemberId(memberId);
	pwMember.setMemberName(memberName);
	pwMember.setMemberPw(memberPw);
	
	
	
%>