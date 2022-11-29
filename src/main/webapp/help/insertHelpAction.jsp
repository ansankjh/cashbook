<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String helpMemo = request.getParameter("helpMemo");
	
	// 제목이나 내용이 빈칸이면 메시지 출력
	if(request.getParameter("helpMemo") == null	|| request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("내용을 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp?msg="+msg);
		return;
	}
	
	// 모델 호출시 매개값
	Help help = new Help();
	help.setMemberId(memberId);
	help.setHelpMemo(helpMemo);
	
	// Model
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelp(help);
	
	if(row == 1) {
		String msg = URLEncoder.encode("문의완료", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp?msg="+msg);
	}
%>
