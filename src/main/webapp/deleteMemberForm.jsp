<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import=  "vo.*" %>
<%
	// 비로그인이면 당연히 회원탈퇴 페이지 접근 불가
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 로그인정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
	String msg = request.getParameter("msg");
	
%>

<!DOCTYPE html>
<html>
	<head>
		<style>
			div {
				text-align : center;
			}
			.center {
				text-align : center;
				font-size : 30pt;
				font-weight : bold;
			}	
		</style>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>deleteMemberForm</title>
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
	<body>
		<section class="page-section" id="contact">
			<div>
				<h1 style="color:yellow;">회원탈퇴</h1>
			</div>
			<%
				if(msg != null) {
			%>
					<div align="center" style="color:red;">
						<%=msg%>
					</div>
			<%
				}
			%>					
			<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post" id="contactForm" data-sb-form-api-token="API_TOKEN">	
				<div>
					<div>
						<div class="form-group" align="center">						
							<input style="width:400px;" id="id" type="text" data-sb-validations="required" name="memberId" value="<%=memberId%>" readonly="readonly">					
						</div>	
						<div class="form-group" align="center">		
							<input style="width:400px;" id="name" type="text" data-sb-validations="required" name="memberName" value="<%=memberName%>" readonly="readonly">
						</div>
						<div class="form-group" align="center">	
							<input style="width:400px;" id="pw" type="password" placeholder="비밀번호를 입력해주세요." data-sb-validations="required" name="memberPw">
						</div>													
					</div>	
				</div>		
				<div class="form-group center">
					<button style="width:400px; height:70px;" type="button" id="deleteBtn">회원탈퇴</button>
				</div>
				<div class="form-group">
					<a class="btn btn-light" style="width:400px; height:70px; font-size:30pt;" href="<%=request.getContextPath()%>/cash/cashList.jsp">취소</a>
				</div>
			</form>			
		</section>
		<script>
			let deleteBtn = document.querySelector('#deleteBtn');
			
			deleteBtn.addEventListener('click', function(){
				// console.log()는 주로 디버깅할때 쓴다.
				console.log('deleteBtn click!')
					
				// 아이디 폼 유효성 검사
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