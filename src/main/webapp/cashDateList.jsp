<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller
	
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	
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
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/insertCashAction.jsp" method="post">
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
	<table border="1">
		<tr>
			<th>categoryKind</th>
			<th>categoryName</th>
			<th>cashPrice</th>
			<th>cashMemo</th>
			<th>수정</th> <!-- @/cash/deleteCash.jsp?cashNo=를 넘겨준다 -->
			<th>삭제</th> <!-- @/cash/updateCash.jsp?cashNo=를 넘겨준다 -->
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("categoryKind")%></td>
					<td><%=m.get("categoryName")%></td>
					<td><%=m.get("cashPrice")%></td>
					<td><%=m.get("cashMemo")%></td>
					<td><a href="">수정</a></td>
					<td><a href="">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>