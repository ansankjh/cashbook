<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>Cash 수정</h1>
		<div>
			<form action="<%=request.getContextPath()%>/updateCashAction.jsp">
				<div>
					<table border="1">
						<tr>
							<th>categoryKind</th>
							<th>categoryName</th>
							<th>cashPrice</th>
							<th>cashMemo</th>
						</tr>
						<tr>
							<td>
								<select name="categoryNo">
									<%
										for (Category c : categoryList) {
									%>
											<option value="<%=c.getCategoryNo()%>">
												<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
											</option>
									<%
										}
									%>
								</select>
							</td>
							<td>
								<input type="text" name="categoryName">
							</td>
							<td>
								<input type="text" name="cashPrice">
							</td>
							<td>
								<textarea rows="3" cols="50" name="cashMemo"></textarea>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>