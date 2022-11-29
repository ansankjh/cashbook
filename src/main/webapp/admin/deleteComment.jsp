<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	// System.out.println(commentNo);
	// 모델 호출시 매개값
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	
	// Model
	CommentDao commentDao = new CommentDao();
	int delete = commentDao.deleteComment(comment);
	
	if(delete == 1) {
		String msg = URLEncoder.encode("삭제완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp?msg="+msg);
	}
%>