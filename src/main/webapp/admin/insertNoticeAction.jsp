<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.net.*" %>
<%@ page import= "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	String noticeMemo = request.getParameter("noticeMemo");
	// 공지입력이 null이나 공백이면 표시할 메시지
	if(request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
		String msg = URLEncoder.encode("공지내용을 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertNoticeForm.jsp?msg="+msg);
		return;
	}
	
	// Model 호출시 필요한 매개값
	Notice notice  = new Notice();
	notice.setNoticeMemo(noticeMemo);
	
	// Model
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	
	if(row == 1) {
		String msg = URLEncoder.encode("공지입력", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?msg="+msg);
		return;
	}
%>