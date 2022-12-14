<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "dao.*" %>
<%@ page import= "vo.*" %>
<%@ page import= "java.util.*" %>
<%
	String msg  = request.getParameter("msg");
	// C
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int cnt = noticeDao.selectNoticeCount();
	// System.out.println(cnt);
	int lastPage = cnt / rowPerPage;
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>loginForm</title>
		<!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
	</head>
	<body>
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
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></li>                       
                    </ul>
                </div>
            </div>
        </nav>        
        <section class="page-section" id="contact">
			<!-- 공지(5개)목록 페이징 -->
			<div class="container">
				<div class="text-center">
					<h1 class="section-heading text-uppercase">로그인</h1>
				</div>
				<%
					if(msg != null) {
				%>
						<span style="color:red;"><%=msg%></span>
				<%
					}
				%>					
				<br>
				<br>
				<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post" id="contactForm" data-sb-form-api-token="API_TOKEN">
					<div class="row align-items-stretch mb-5">
						<div class="col-md-6">
							<div class="form-group">
								<input style="width:400px;" id="id" type="text" placeholder="Your Id *" data-sb-validations="required" name="memberId" onkeyup="fnEnterKey();">
							</div>
							<div class="form-group">
								<input style="width:400px;" id="pw" type="password" placeholder="Your Password *" data-sb-validations="required,email" name="memberPw">
							</div>
						</div>
						<div class="col-md-6">
							<div class="container form-group form-group-textarea mb-md-0">
								<table class="table text-warning" style="width:700px;">
									<tr>
										<th>공지내용</th>
										<th>날짜</th>
									</tr>
									<%
										for(Notice n : list) {
										
									%>
											<tr>
												<td><%=n.getNoticeMemo()%></td>
												<td><%=n.getCreatedate()%></td>
											</tr>
									<%
										}
									%>
								</table>
								<div>
									<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
									<%
										if(currentPage > 1) {
									%>
											<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
									<span class="text-info"><%=currentPage%></span>
									<%	
										}
									
										if(currentPage < lastPage) {
									%>
											<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>
									<%
										}
									%>				
									<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
								</div>
							</div>
						</div>
						<div>
							<button class="btn btn-primary btn-xl text-uppercase" type="button" id="submitButton">로그인</button>
						</div>						
					</div>
				</form>
			</div>
		</section>	
		<script>
			let submitButton = document.querySelector('#submitButton');
			
			submitButton.addEventListener('click', function(){
				// console.log()는 주로 디버깅할때 쓴다.
				console.log('submitButton click!')
					
				// 아이디 폼 유효성 검사
				let id = document.querySelector('#id');
				if(id.value == '') {
					alert('아이디를 입력하세요.');
					id.focus(); // 브라우저의 커서를 id태그로 이동
					return;
				}
				
				// 비밀번호 폼 유효성 검사
				let pw = document.querySelector('#pw');
				if(pw.value == '') {
					alert('비밀번호를 입력하세요.');
					pw.focus(); // 브라우저의 커서를 id태그로 이동
					return;
				}
				
				let contactForm = document.querySelector('#contactForm');
				contactForm.submit();
			});
		</script>	
	</body>
</html>