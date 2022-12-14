<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	// 관리자 아니면 못들어온다
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String msg = request.getParameter("msg");
	// System.out.println(helpNo);
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			body {
			    background-image: url(assets/img/a3.jpg);
			    background-size: cover;			    
			}
			.po1 {
				position : relative;
				top : 150px;				
			}
			.po_bt {
				position : relative;
				bottom : 10px;
			}
		</style>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
		<title>updateCommentForm</title>
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
						<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp" style="font-size:30px;">뒤로</a></li>
                    </ul>
                </div>
            </div>
        </nav>
		<div class="container">
			<h1 class="po1" align="center" style="color:white">답변내용</h1>
			<%
				if(msg != null) {
			%>
					<div align="center" style="color:yellow; font-size:30px;">
						<%=msg%>
					</div>
			<%
				}
			%>
			<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=memberId%>">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<div align="center" style="margin-top:200px;">
					<table class="table table-bordered" style="width:350px; color:white;">
						<tr align="center">
							<th>답변내용</th>
						</tr>
						<tr>
							<td>	
								<textarea cols="50" rows="5" name="commentMemo" placeholder="내용을 입력해주세요."></textarea>
							</td>
						</tr>						
					</table>
				</div>
				<div class="po_bt" align="center">
					<button type="submit">입력</button>
				</div>		
			</form>
		</div>
	</body>
</html>