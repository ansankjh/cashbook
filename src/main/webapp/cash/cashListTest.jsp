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
		<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Agency - Start Bootstrap Theme</title>
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
                <a class="navbar-brand" href="#page-top"><img src="assets/img/navbar-logo.svg" alt="..." /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                        <div>
							<jsp:include page="/inc/menu.jsp"></jsp:include>
						</div>
                    </ul>
                </div>
            </div>
        </nav>
		
		<header class="masthead">
			<div>
				<%=loginMember.getMemberName()%>님 반갑습니다.<a href="<%=request.getContextPath()%>/logout.jsp">[로그아웃]</a>	
			</div>	
			<div>
				<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a>
				<%=year%>년 <%=month+1%> 월
				<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a>
			</div>
			<div class="container">
				<!-- 달력 -->
				<table class="table text-warning" style="width:1000px;" align="center">
					<tr>
						<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
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
		 									<a href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">									
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
														[<%=(String)(m.get("categoryKind"))%>]
														<%=(String)(m.get("categoryName"))%>
														&nbsp;
														<%=(Long)(m.get("cashPrice"))%>원
														<br>												
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
					if(loginMember.getMemberLevel() > 0) {
				%>
						<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
				<%	
					}				
				%>
				<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">정보수정</a>
				<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호수정</a>
				<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
				<%
					if(msg != null) {
				%>
						<%=msg%>
				<%
					}
				%>
			</div>
		</header>
	</body>
</html>