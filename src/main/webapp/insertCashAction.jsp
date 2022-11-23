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
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// null이나 공백 들어오면 cashDateList.jsp로 돌아가게하기
	if(request.getParameter("memberId") == null || request.getParameter("categoryNo") == null 
		|| request.getParameter("cashDate") == null || request.getParameter("cashPrice") == null || request.getParameter("cashMemo") == null
		|| request.getParameter("memberId").equals("") || request.getParameter("categoryNo").equals("") 
		|| request.getParameter("cashDate").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")) {
		
		String msg = URLEncoder.encode("빈칸이 있습니다", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/cashDateList.jsp?msg="+msg);
		return;
	}
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