<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.time.LocalDate"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/program_apply.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
</head>
<body>

	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="main.html"> <img
				src="img/knu_museum_logo.jpg" alt="Logo" width="30" height="24"
				class="d-inline-block align-text-top">
			</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="info_for_user.jsp">이용안내</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="artifact_for_user.jsp">소장유물</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="program_for_user.jsp">체험프로그램</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="program_apply.jsp">체험 프로그램 신청</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="group_apply.jsp">단체관람 신청</a></li>
				</ul>
				<span class="navbar-text">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="user_view.jsp">My
								Page</a></li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>

	<div class="box">
		<h2 style="margin-bottom: 20px;">신청에 실패했습니다.</h2>
		<a href="program_apply.jsp" style="color: #626A72"><h4
				style="margin-bottom: 20px;">다시 신청하러 가기</h4></a>
	</div>



</body>
</html>