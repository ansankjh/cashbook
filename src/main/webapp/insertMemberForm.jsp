<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
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
		<title>insertMemberForm</title>
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
				<h1 style="color:yellow;">회원가입</h1>
			</div>
			<%
				if(msg != null) {
			%>
					<div aling="center" style="color:red;">
						<%=msg%>
					</div>
			<%
				}
			%>					
			<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post" id="contactForm" data-sb-form-api-token="API_TOKEN">	
				<div>
					<div>
						<div class="form-group" align="center">						
							<input style="width:400px;" id="id" type="text" placeholder="아이디를 입력해주세요." data-sb-validations="required" name="memberId">					
						</div>	
						<div class="form-group" align="center">		
							<input style="width:400px;" id="memberPw" type="password" placeholder="비밀번호를 입력해주세요." data-sb-validations="required" name="memberPw">
						</div>
						<div class="form-group" align="center">	
							<input style="width:400px;" id="memberPw2" type="password" placeholder="비밀번호를 한번 더 입력해주세요." data-sb-validations="required" name="memberPw2">
						</div>		
						<div class="form-group" align="center">					
							<input style="width:400px;" id="name" type="text" placeholder="이름을 입력해주세요." data-sb-validations="required" name="memberName">
						</div>				
					</div>	
				</div>		
				<div class="form-group center">
					<button style="width:400px; height:70px;" type="button" id="insertBtn">회원가입</button>
				</div>
				<div class="form-group">
					<a class="btn btn-light" style="width:400px; height:70px; font-size:30pt;" href="<%=request.getContextPath()%>/cash/cashList.jsp">취소</a>
				</div>
			</form>			
		</section>
		<br>
		<script>
			let insertBtn = document.querySelector('#insertBtn');
			
			insertBtn.addEventListener('click', function(){
				// console.log()는 주로 디버깅할때 쓴다.
				console.log('insertBtn click!');
				
				// 아이디 폼 유효성 검사
				let id = document.querySelector('#id');
				if(id.value == '') {
					alert('아이디를 입력해주세요.');
					id.focus();
					return;
				}
				
				// 비밀번호 폼 유효성 검사
				let memberPw = document.querySelector('#memberPw');
				let memberPw2 = document.querySelector('#memberPw2');
				if(memberPw.value != memberPw2.value && memberPw.value != '' && memberPw2.value != '') {
					alert('비밀번호를 확인해주세요.');
					memberPw.focus();
					return;
				} else if(memberPw.value == '') {
					alert('비밀번호를 입력해주세요.');
					memberPw.focus();
					return;
				} else if(memberPw2.value == '') {
					alert('비밀번호를 한번 더 입력해주세요.');
					memberPw.focus();
					return;
				}
				
				
				// 닉네임 폼 유효성 검사
				let name = document.querySelector('#name');
				if(name.value == '') {
					alert('닉네임을 입력해주세요.');
					name.focus();
					return;
				}
				
				
				
				let contactForm = document.querySelector('#contactForm');
				contactForm.submit();
			});
		</script>
	</body>
</html>