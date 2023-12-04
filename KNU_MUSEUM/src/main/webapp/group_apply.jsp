<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.time.LocalDate"%>
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
<%!public String getTomorrow() {
		LocalDate tomorrow = LocalDate.now().plusDays(1);
		return tomorrow.toString();
	}%>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"> <img
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
	<form action="group_apply_complete.jsp" method="Post">
		<div class="box">
			<h3>* 단체 관람 소요 시간은 90분 입니다.</h3>
			<h3>* 단체 관람은 8명 이상부터 신청 가능합니다. (최대 100명)</h3>
			<div class="date-container">
				<label for="selectedDate">날짜:</label> <input class="btn btn-outline" type="date"
					id="selectedDate" name="selectedDate" style="margin: 10px; border-color:black"
					min="<%=getTomorrow()%>">
			</div>

			<div class="date-container">
				<label for="selectedDate">관람 시작 시간:</label> <input class="btn btn-outline" type="number"
					name="time" style="width: 100px; border-color:black"> <label for="selectedDate">시</label>
			</div>
			<div class="date-container">
				<label for="selectedDate">신청 인원:</label> <input  class="btn btn-outline" type="number"
					name="num" style="width: 100px; border-color:black"> <label for="selectedDate">명</label>
			</div>

			<input class="btn" type="submit" value="신청하기"
				style="background-color: #6C757D" />

		</div>
	</form>


</body>
</html>