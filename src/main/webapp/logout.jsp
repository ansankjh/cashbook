<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.net.*" %>
<%
	session.invalidate(); // 세션 초기화
	String msg = URLEncoder.encode("로그아웃완료", "utf-8");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
%>