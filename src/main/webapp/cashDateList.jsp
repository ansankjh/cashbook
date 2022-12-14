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
		<style>
			table {
				width : 1500px;
				height : 100px;
				text-align : center;
				border : 1;
			}
			.rect2 {
			    position: absolute;
			    top : 380px;			  
			    left: 1575px;
			}			
			body {
			    background-image: url(assets/img/camera.jpg);
			    background-size: cover;
			}
			td {
				vertical-align : middle;
			}
			.font {
				color : white;
			}
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>cashDateList</title>
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
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp" style="font-size:30px;">뒤로</a></li>
                    </ul>
                </div>
            </div>
        </nav>    
           	     
		<!--  cash 목록 출력 -->		
		<div align="center">
			<h1 class="font" style="margin-top:150px;"><%=year%>년 <%=month%>월 <%=date%>일</h1>		
			<table class="table table-bordered"  style="width:1500px; height:100px;">
				<tr class="bg-warning font">
					<th>categoryKind</th>
					<th>categoryName</th>
					<th>cashPrice</th>
					<th>cashMemo</th>		
					<th style="width:100px;">수정</th> <!-- @/cash/updateCash.jsp?cashNo=를 넘겨준다 --> <!-- @/cash/deleteCash.jsp?cashNo=를 넘겨준다 -->
					<th style="width:100px;">삭제</th>
				</tr>
				<%
					for(HashMap<String, Object> m : list) {		
				%>
						<tr class="font">
							<td><%=m.get("categoryKind")%></td>
							<td><%=m.get("categoryName")%></td>
							<td><%=m.get("cashPrice")%></td>
							<td><%=m.get("cashMemo")%></td>					
							<td><a class="btn btn-info" href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">수정</a></td>
							<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">삭제</a></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		<div>
			<!-- cash 입력 폼 -->
			<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="month" value="<%=month%>">
				<input type="hidden" name="date" value="<%=date%>">
			<div align="center">
				<table class="table table-bordered font" style="width:1500px; height:100px; margin-top:100px;">
					<tr class="bg-warning font">
						<th>categoryNo</th>
						<th>cashDate</th>
						<th>cashPirce</th>
						<th>cashMemo</th>
						<th></th>				
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
							<input type="text" name="cashPrice" placeholder="금액을 입력해주세요.">
						</td>			
						<td>
							<textarea rows="3" cols="50" name="cashMemo" placeholder="내용을 입력해주세요."></textarea>							
						</td>
						<td>
							<button class="btn-info" type="submit">입력</button>
						</td>
					</tr>			
				</table>
			</div>			
			</form>
		</div >
		<%
			if(msg != null) {
		%>
				<div align="center" style="color:blue; font-size:30px;">
					<%=msg%>
				</div>
		<%
			}
		%>	
	</body>
</html>