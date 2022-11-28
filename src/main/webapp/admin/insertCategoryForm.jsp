<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>카테고리추가</h1>
	<div>
		<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
			<div>	
				<table border="1">				
						<tr>
							<td>categoryKind</td>
							<td>
								<input type="radio" name="categoryKind" value="수입">수입
								<input type="radio" name="categoryKind" value="지출">	지출
							</td>
						</tr>
						<tr>
							<td>categoryName</td>
							<td>
								<input type="text" name="categoryName">
							</td>						
						</tr>
						<tr>
							<td>updatedate</td>
							<td></td>
						</tr>
						<tr>
							<td>createdate</td>
							<td></td>
						</tr>							
				</table>	
			</div>
			<div>
				<button type="submit">카테고리추가</button>
			</div>	
		</form>
	</div>
</body>
</html>