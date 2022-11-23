<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// C
	
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String memberPw = request.getParameter("memberPw");
	
	if(request.getParameter("memberId") == null || request.getParameter("memberName") == null || request.getParameter("memberPw") == null 
		|| request.getParameter("memberId").equals("") || request.getParameter("memberName").equals("") || request.getParameter("memberPw").equals("") ) {
		String msg2 = URLEncoder.encode("빈칸이 있습니다", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg2);
		return;
	}
	
	// 모델 호출시 매개값
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberName(memberName);
	paramMember.setMemberPw(memberPw);
	
	// M
	// 쿼리문 저장
	MemberDao memberDao = new MemberDao();
	int upMember = memberDao.updateMember(paramMember);
	// 쿼리문의 값이 1이 나오면 수정실패이므로 수정페이지로 메시지와 함께 돌아간다.
	// 0이 나오면 수정 성공이므로 세션 값도 새로 지정
	if(upMember == 1) {
		String msg = URLEncoder.encode("수정성공", "utf-8");
		session.setAttribute("loginMember", paramMember);
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+msg);
	} else {						
		String msg = URLEncoder.encode("수정 실패", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}

%>