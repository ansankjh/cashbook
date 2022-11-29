<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	// System.out.println(helpNo);
	
	// Model
	HelpDao helpDao = new HelpDao();
	int delete = helpDao.deleteHelp(helpNo);
	
	if(delete == 1) {
		String msg = URLEncoder.encode("삭제성공", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp?msg="+msg);
		return;
	}
%>