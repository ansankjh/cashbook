<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller
	// 비로그인시 접근불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 세션 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = request.getParameter("msg");
	// request 년 + 월
	int year = 0;
	int month = 0;
	
	// 년,월에 null이 들어오면 오늘 날짜 저장
	if((request.getParameter("year") == null) || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 일경우
		if(month == -1) {
			month = 11;
			year -= 1;
		}
		if(month == 12) {
			month = 0;
			year += 1;
		}
	}
	
	// 출력하고자 하는 년,월과 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일(일 1, 월 2, 화 3, ... 토 7)
	// begin blank개수는 firstDay - 1
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다 --> totalTd
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list  = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);

	
	// View : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
			    background-image: url(assets/img/header-bg.jpg);
			    background-size: cover;
			}
			table {
				margin-top : 50px;
				width : 1200px;
				height : 500px;
			}						
		</style>
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>cashList</title>
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
                <a class="navbar-brand " href="#page-top"><%=loginMember.getMemberName()%>(등급:<%=loginMember.getMemberLevel()%>)님 접속</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                    	<li class="nav-item"></li>
                    	<jsp:include page="/inc/menu.jsp"></jsp:include>    
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/updateMemberForm.jsp">정보수정</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호수정</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>						                
                    </ul>
                </div>
            </div>
        </nav>		
		
		<div align="center" style="margin-top:150px;">
			<h2 class="text-warning">				
								
			</h2>
			<h1 class="text-warning">
				<a class="text-danger" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a>
				<%=year%>년 <%=month+1%>월 <%=loginMember.getMemberName()%>님의 가계부달력
				<a class="text-info" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a>
			</h1>			
		</div>
		
		
		<div class="container">
			<!-- 달력 -->			
			<table class="table table-bordered" align="center">
				<tr class="bg-light opacity-50" align="center" style="height:20px;">
					<th class="text-danger">일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th class="text-info">토</th>
				</tr>
				<tr>
					<%
						for(int i=1; i<=totalTd; i++) {
					%>
							<td>
					<%
								int date = i-beginBlank;
								if(date > 0 && date <= lastDate) {
					%>
									<div>
	 									<a style="text-decoration:none" href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">									
											<%=date%>
										</a>
									</div>
									<div>
										<% 
											// substring(8) index가 8인 위치를 포함한 문자열을 리턴 ex) 2022-11-22 -> 22 리턴
											// 그렇게 뽑아낸 cashDate의 날짜와 실제 달력의 날짜가 같으면 밑에 값 출력 
											for(HashMap<String, Object> m : list) {
												String cashDate = (String)(m.get("cashDate"));
												if(Integer.parseInt(cashDate.substring(8)) == date) {
										%>
													<span style="color:Brown; font-weight:bold;">
													[<%=(String)(m.get("categoryKind"))%>]
													<%=(String)(m.get("categoryName"))%>
													&nbsp;
													<%=(Long)(m.get("cashPrice"))%>원
													<br></span>											
										<%
												}
											}
										%>							
									</div>
					<%				
								}
					%>
							</td>
					<%
							
							if(i%7 == 0 && i != totalTd) {
					%>
								</tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
					<%			
							}
						}
					%>
				</tr>
			</table>
		</div>	
		<div>		
			<%
				if(msg != null) {
			%>
					<%=msg%>
			<%
				}
			%>
		</div>		
		<!-- Bootstrap core JS-->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
		<!-- Core theme JS-->
		<script src="js/scripts.js"></script>
		<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
		<!-- * *                               SB Forms JS                               * *-->
		<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
		<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
		<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	</body>
</html>