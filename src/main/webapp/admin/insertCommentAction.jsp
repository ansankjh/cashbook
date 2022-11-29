<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%@ page import = "java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String commentMemo = request.getParameter("commentMemo");
	String memberId = request.getParameter("memberId");
	
	/*
	System.out.println(helpNo);
	System.out.println(commentMemo);
	System.out.println(memberId);
	*/
	if(request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")) {
		String msg = URLEncoder.encode("내용을 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/insertCommentForm.jsp?msg="+msg+"&helpNo="+helpNo);
		return;
	}
	
	
	// 모델 호출 매개값
	Comment comment = new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	
	// 모델 호출
	CommentDao commentDao = new CommentDao();
	int insert = commentDao.insertComment(comment);
	
	if(insert == 1) {
		String msg = URLEncoder.encode("답변완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp?msg="+msg);
	}
%>