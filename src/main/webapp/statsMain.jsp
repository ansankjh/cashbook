<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller
	// 비로그인시 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	//session정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int year = 0;
	// year가 안넘어오면 오늘 날짜의 year나오게한다
	// 이걸로는 올해년도 밖에 못받아온다.
	if(request.getParameter("year") == null) {
		Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}
	
	
	StatsDao statsDao = new StatsDao();	
	ArrayList<HashMap<String, Object>> list = statsDao.selectSumAvgByYear(loginMember.getMemberId());
	// 페이징에 사용할 최소년도와 최대년도
	// 페이징을 이용해 위의 year가 null이 아니면 요청한값을 받아온다.
	ArrayList<HashMap<String, Object>> list2 = statsDao.selectSumAvgByMonth(loginMember.getMemberId(), year);
	HashMap<String, Object> m2 = statsDao.selectMaxMinYear();
	int minYear = (Integer)(m2.get("minYear"));
	int maxYear = (Integer)(m2.get("maxYear"));
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
				background-image: url(assets/img/camera.jpg);
				background-size : cover;
			}			
			.po0 {
				position : relative;
				top : 100px;
			}
			.po1 {
				position : relative;
				top : 250px;
			}
			.po_table1 {
				position : relative;
				top : 150px;
			}
			.po_table2 {
				position : relative;
				top : 300px;
			}
			.po_page {
				position : relative;
				bottom : 250px;
			}
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>statsMain</title>
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
		<div>
			<h1 class="po0" style="color:white" align="center">년도별 총 수입/지출 리스트</h1>
			<div>
				<table class="table table-bordered po_table1" align="center" style="width:1000px;">
					<tr style="color:white;">
						<th>년</th>
						<th>수입카운트</th>
						<th>수입합계</th>
						<th>수입평균</th>
						<th>지출카운트</th>
						<th>지출합계</th>
						<th>지출평균</th>
					</tr>
					<%
						for(HashMap<String, Object> m : list) {
					%>
							<tr>
								<td style="color:white;"><%=m.get("year")%></td>
								<td style="color:white;"><%=m.get("iCnt")%></td>
								<td style="color:blue;">+<%=m.get("iSum")%></td>
								<td style="color:blue;">+<%=m.get("iAvg")%></td>
								<td style="color:white;"><%=m.get("eCnt")%></td>
								<td style="color:red;">-<%=m.get("eSum")%></td>
								<td style="color:red;">-<%=m.get("eAvg")%></td>
							</tr>
					<%
						}
					%>
				</table>
			</div>
			<h1 class="po1" style="color:white" align="center"><%=year%>년 월별 총 수입/지출 리스트</h1>
			<div>
				<table class="table table-bordered po_table2" align="center" style="width:1000px;">
					<tr style="color:white;">
						<th>월</th>
						<th>수입카운트</th>
						<th>수입합계</th>
						<th>수입평균</th>
						<th>지출카운트</th>
						<th>지출합계</th>
						<th>지출평균</th>
					</tr>
					<%
						for(HashMap<String, Object> map : list2) {
					%>
							<tr>
								<td style="color:white;"><%=map.get("month")%></td>
								<td style="color:white;"><%=map.get("iCnt")%></td>
								<td style="color:blue;">+<%=map.get("iSum")%></td>
								<td style="color:blue;">+<%=map.get("iAvg")%></td>
								<td style="color:white;"><%=map.get("eCnt")%></td>
								<td style="color:red;">-<%=map.get("eSum")%></td>
								<td style="color:red;">-<%=map.get("eAvg")%></td>
							</tr>
					<%
						}
					%>
				</table>
				<div class="po_page" align="center" style="text-decoration : none;">
				<!-- 페이징 -->
				<%
					if(year > minYear) {
				%>
						<a href="<%=request.getContextPath()%>/statsMain.jsp?year=<%=year-1%>">이전년도</a>
				<%
					}
				
					if(year < maxYear) {
				%>
						<a href="<%=request.getContextPath()%>/statsMain.jsp?year=<%=year+1%>">다음년도</a>
				<%
					}
				%>
				</div>
			</div>
		</div>
	</body>
</html>