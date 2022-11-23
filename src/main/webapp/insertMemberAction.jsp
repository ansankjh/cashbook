<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// C
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberPw2 = request.getParameter("memberPw2");
	String memberName = request.getParameter("memberName");
	
	// 회원가입에서 빈칸 있으면 나올 메시지
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null 
		|| request.getParameter("memberId").equals("")	|| request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("")) {
		
		String msg = URLEncoder.encode("회원가입에 필요한 정보를 모두 입력해주세요", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	// pw와 pw2가 같지 않으면 나올 메시지
	if(!memberPw.equals(memberPw2)) {
		
		String msg2 = URLEncoder.encode("비밀번호가 다릅니다", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg2);
		return;
		
	}
	// insertMember에 form으로 받아온 정보를 저장
	Member insertMember = new Member(); // 모델 호출시 매개값
	insertMember.setMemberId(memberId);
	insertMember.setMemberPw(memberPw);
	insertMember.setMemberName(memberName);
	
	// M
	// insert쿼리문을 memberDao에 저장
	MemberDao memberDao = new MemberDao();	
	
	// System.out.println(memberDao);
	if(memberDao.memberCk(insertMember.getMemberId())) {
		String msg3 = URLEncoder.encode("아이디 중복", "utf-8");						
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg3);
		return;
	}
	
	int resultMember  = memberDao.insertMember(insertMember);
	
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");	
%>