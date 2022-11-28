<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "java.net.*" %>
<%
	// Controller 
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	// System.out.println(categoryNo);
	
	
	// Model
	CategoryDao categoryDao = new CategoryDao();
	int deleteCategory = categoryDao.deleteCategory(categoryNo);
	
	if(deleteCategory == 1) {
		String msg = URLEncoder.encode("삭제완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp?msg="+msg);
	}
%>