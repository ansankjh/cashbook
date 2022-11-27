<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo = request.getParameter("noticeMemo");
	
	// null이나 공백 들어오는걸 방지
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeMemo") == null
		|| request.getParameter("noticeNo").equals("") || request.getParameter("noticeMemo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/updateNoticeForm.jsp");
		return;
	}
		
	/*
	System.out.println(noticeNo);
	System.out.println(noticeMemo);
	*/
	// 모델 호출 매개값
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeMemo(noticeMemo);
	
	// Model
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.updateNotice(notice);
	
	if(row == 1) {
		String msg = URLEncoder.encode("수정완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?msg="+msg);
	}
%>