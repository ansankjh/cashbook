<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	/*
	System.out.println(helpNo);
	System.out.println(helpMemo);
	*/
	if(request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("내용을 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?msg="+msg+"&helpNo="+helpNo+"&helpMemo="+"");
		return;
	}
	
	// 모델 불러올 매개값
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setHelpMemo(helpMemo);
	// 모델호출
	HelpDao helpDao = new HelpDao();
	int updateHelp = helpDao.updateHelp(help);
	
	if(updateHelp == 1) {
		String msg = URLEncoder.encode("문의사항이 수정됐습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp?msg="+msg);
	}
%>