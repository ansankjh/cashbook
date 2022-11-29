<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller 세션 정보 가져오기
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// Map에 쓸 매개변수
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	// 연 , 일 , 월 받기
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	String msg = request.getParameter("msg");
	
	/* 넘어오는지 확인
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);
	*/
	
	// Model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	CashDao cashDao = new CashDao(); // CashDao가 가지고 있다.
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>	
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<table border="1">
			<tr>
				<th>categoryNo</th>
				<th>cashDate</th>
				<th>cashPirce</th>
				<th>cashMemo</th>				
			</tr>
			<tr>				
				<td>
					<select name="categoryNo">
						<%
							for(Category c : categoryList) {
						%>
								<option value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%>, <%=c.getCategoryName()%>
								</option>
						<%
							}
						%>
					</select>
				</td>				
				<td>
					<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
				</td>
				<td>
					<input type="text" name="cashPrice">
				</td>			
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>			
		</table>
		<button type="submit">입력</button>
	</form>
	<!--  cash 목록 출력 -->
	<h1><%=year%>년 <%=month%>월 <%=date%>일</h1>
	<table border="1">
		<tr>
			<th>categoryKind</th>
			<th>categoryName</th>
			<th>cashPrice</th>
			<th>cashMemo</th>		
			<th>수정</th> <!-- @/cash/updateCash.jsp?cashNo=를 넘겨준다 --> <!-- @/cash/deleteCash.jsp?cashNo=를 넘겨준다 -->
			<th>삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {

		%>
				<tr>
					<td><%=m.get("categoryKind")%></td>
					<td><%=m.get("categoryName")%></td>
					<td><%=m.get("cashPrice")%></td>
					<td><%=m.get("cashMemo")%></td>					
					<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp">뒤로</a>
	</div>
	<%
		if(msg != null) {
	%>
			<%=msg%>
	<%
		}
	%>
</body>
</html>