<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import ="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	
	String cashMemo = request.getParameter("cashMemo");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	long cashPrice = 0;
	
	if(request.getParameter("cashPrice") == null || request.getParameter("cashMemo") == null || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")) {
		cashPrice = 0;
		String msg = URLEncoder.encode("빈칸이 있습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
	
	if(!request.getParameter("cashPrice").equals("")) {
		cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	}
	
	// Model 불러올 매개값
	Cash cash  = new Cash();
	cash.setMemberId(memberId);
	cash.setCategoryNo(categoryNo);
	cash.setCashDate(cashDate);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	
	// M
	// 쿼리문 저장
	CashDao cashDao = new CashDao();	
	int insertCash  = cashDao.insertCash(cash);
	
	if(insertCash == 1) {
		String msg = URLEncoder.encode("입력 성공", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
	} 	

%>