<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String msg = request.getParameter("msg");
	// System.out.println(categoryNo);
	
	Category category  = new Category();
	category.setCategoryNo(categoryNo);
	
	// Model
	CategoryDao categoryDao = new CategoryDao();
	Category ct = categoryDao.selectCategory(categoryNo);
%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCategoryForm</title>
	</head>
	<body>
		<h1>카테고리수정</h1>
		<%
			if(msg != null) {
		%>
				<%=msg%>
		<%
			}
		%>
		<div>
			<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
				<div>
					<table>
						<tr>
							<td>번호</td>
							<td>
								<input type="text" name="categoryNo" value="<%=categoryNo%>" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td>
								<input type="text" name="categoryName" value="<%=ct.getCategoryName()%>">
							</td>
						</tr>
						<tr>
							<td>업데이트 날짜</td>
							<td></td>
						</tr>
					</table>
				</div>
				<div>
					<button type="submit">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>