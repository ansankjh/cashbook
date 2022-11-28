<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");	
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	if(request.getParameter("categoryKind") == null || request.getParameter("categoryName") == null
		|| request.getParameter("categoryKind").equals("") || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp");
		return;
	}
	// 모델 호출할 매개값
	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	// Model
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.insertCategory(category);
	
	if(row == 1) {
		String msg = URLEncoder.encode("추가완료","utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp?msg="+msg);
	}
	
%>