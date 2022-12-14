<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "vo.*" %>
<%@ page import= "java.net.*" %>
<%
	// Controller
	// session에 들어있는 resultMember값이 null이라면 로그인이 안되어 있는 상태이므로 loginForm으로 돌아가게 강제한다
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String msg = request.getParameter("msg");
	// 로그인 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	request.setCharacterEncoding("utf-8");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));	
	
	/*
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);
	System.out.println(cashNo);
	*/
	
	// Model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCash(loginMember.getMemberId(), cashNo); 
	
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
				background-image: url(assets/img/a1.jpg);
				background-size: cover;		
			}
			.font {
				color : white;
				text-align : center;
			}
			.position {
				position : absolute;
				top : -70px;
				left : 880px;
			}
		</style>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>updateCashForm</title>
		<!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
	</head>
	<body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand " href="#page-top"><%=loginMember.getMemberName()%>님(등급:<%=loginMember.getMemberLevel()%>)</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>">뒤로</a></li>
                    </ul>
                </div>
            </div>
        </nav>    
        
		<h1 class="font position">Cash 수정</h1>
		<%
			if(msg != null) {
		%>
				<div align="center" style="color:red;">
					<%=msg%>
				</div>
		<%
			}
		%>
		<div class="container">
			<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<input type="hidden" name="cashNo" value=<%=cashNo%>>
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="month" value="<%=month%>">
				<input type="hidden" name="date" value="<%=date%>">
				<div align="center" style="margin-top:280px;">
					<table class="table table-bordered font" style="width:1350px; height:100px; margin-top:100px;">
						<tr class="bg-warning font" style="vertical-align:middle;">
							<th>categoryNo</th>
							<th>cashPrice</th>
							<th>cashMemo</th>
							<th></th>
						</tr>
						<tr style="vertical-align:middle;">
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
							<%
								// 기본키가 달린 식별번호를 입력값으로 받으면 그거에 관해서만 출력
								// session에 저장된 아이디로만 받으면 아이디가 동일한 행이 모두 출력
								for(HashMap<String, Object> m : list) {
							%>									
									<td>
										<input type="text" name="cashPrice" value="<%=m.get("cashPrice")%>">
									</td>
									<td>
										<textarea rows="3" cols="50" name="cashMemo"><%=m.get("cashMemo")%></textarea>
									</td>
									<td>								
										<button style="background-color:brown;" type="submit">수정</button>		
									</td>
							<%
								}
							%>							
						</tr>
					</table>
				</div>
				
			</form>
		</div>
	</body>
</html>