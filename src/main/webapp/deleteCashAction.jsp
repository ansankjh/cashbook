<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller
	// 로그인 정보 불러오기
	Member loginMemberId = (Member)session.getAttribute("loginMember");
	String memberId = loginMemberId.getMemberId();
	
	request.setCharacterEncoding("utf-8");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	/*
	System.out.println(cashNo);
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);	
	*/
	// Model 호출시 쓸 매개값
	Cash cash = new Cash();
	cash.setCashNo(cashNo);
	cash.setMemberId(memberId);
	
	// Model 호출
	CashDao cashDao = new CashDao();
	int row = cashDao.deleteCash(cash);
	if(row == 1) {
		String msg = URLEncoder.encode("삭제완료", "utf-8");	
		response.sendRedirect(request.getContextPath()+"/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
		return;
	} 
%>