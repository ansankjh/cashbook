<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import= "java.net.*" %>
<%
	// Controller
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/noticeList.jsp");
		return;
	}
	
	// 모델 호출 매개값
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	
	// Model
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.deleteNotice(notice);
	
	if(row == 1) {
		String msg = URLEncoder.encode("삭제완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?msg="+msg);
	}
	

%>