<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentMemo = request.getParameter("commentMemo");
	/*
	System.out.println(commentNo);
	System.out.println(commentMemo);
	*/
	if(request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")) {
		String msg = URLEncoder.encode("내용을 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/updateCommentForm.jsp?msg="+msg+"&commentNo="+commentNo);
		return;
	}
	
	// 모델 호출시 매개값
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	comment.setCommentMemo(commentMemo);
	
	// Model호출
	CommentDao commentDao = new CommentDao();
	int update = commentDao.updateComment(comment);
	
	if(update == 1) {
		String msg = URLEncoder.encode("수정완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp?msg="+msg);
	}
	
%>