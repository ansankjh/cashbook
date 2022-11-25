<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	/* 값 넘어오는지 디버깅
	System.out.println(categoryNo);
	System.out.println(categoryName);
	System.out.println(cashPrice);
	System.out.println(cashMemo);
	*/
%>