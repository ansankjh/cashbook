<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	// 로그인 안되어있으면 못들어오게
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 로그인 정보 불러오기
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
		<title>updateMemberPwForm</title>
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
				<h1 style="color:yellow;">비밀번호</h1>
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
			<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post" id="contactForm" data-sb-form-api-token="API_TOKEN">	
				<div>
					<div>
						<div class="form-group" align="center">						
							<input style="width:400px;" id="id" type="text" value="<%=memberId%>" data-sb-validations="required" name="memberId" readonly="readonly">					
						</div>	
						<div class="form-group" align="center">		
							<input style="width:400px;" id="pw" type="password" placeholder="기존 비밀번호를 입력해주세요." data-sb-validations="required" name="memberPw">
						</div>
						<div class="form-group" align="center">	
							<input style="width:400px;" id="pwConfirm" type="password" placeholder="변경하실 비밀번호를 입력해주세요." data-sb-validations="required" name="memberPw2">
						</div>										
					</div>	
				</div>		
				<div class="form-group center">
					<button style="width:400px; height:70px;" type="button" id="updatePwBtn">수정</button>
				</div>
				<div class="form-group">
					<a class="btn btn-light" style="width:400px; height:70px; font-size:30pt;" href="<%=request.getContextPath()%>/cash/cashList.jsp">취소</a>
				</div>
			</form>			
		</section>
		<br>
		<script>
			let updatePwBtn = document.querySelector('#updatePwBtn');
			
			updatePwBtn.addEventListener('click', function(){
				// console.log()는 주로 디버깅할때 쓴다.
				console.log('updatePwBtn click!');
				
				// 비밀번호 폼 유효성 검사
				let pw = document.querySelector('#pw');
				let pwConfirm = document.querySelector('#pwConfirm');
				if(pw.value == pwConfirm.value && pw.value != '' && pwConfirm.value != '') {
					alert('이전 비밀번호와 일치합니다.');
					pw.focus(); // 브라우저의 커서를 id태그로 이동
					return;
				} else if(pw.value == '') {
					alert('기존 비밀번호를 입력해주세요.');
					pw.focus(); // 브라우저의 커서를 id태그로 이동
					return;
				} else if(pwConfirm.value == '') {
					alert('변경할 비밀번호를 입력해주세요.');
					pw.focus(); // 브라우저의 커서를 id태그로 이동
					return;
				}

				
				
				let contactForm = document.querySelector('#contactForm');
				contactForm.submit();
			});
		</script>
	</body>
</html>