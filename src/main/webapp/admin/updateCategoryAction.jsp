<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryName") == null
		|| request.getParameter("categoryNo").equals("") || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/updateCateogryForm.jsp");
		return;
	}
	// System.out.println(categoryNo);
	// System.out.println(categoryName);
	
	// 모델 호출할 매개값
	Category category = new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryName(categoryName);
	
	// Model
	CategoryDao categoryDao = new CategoryDao();
	int updateCategory = categoryDao.updateCategoryName(category);
	
	if(updateCategory == 1) {
		String msg = URLEncoder.encode("수정완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp?msg="+msg);
	}
%>



