<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/artifact_add.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
</head>
<body>
	<%
	String serverIP = "localhost";
	//String strSID = "xe";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	Connection conn = null;
	Statement stmt = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();

	request.setCharacterEncoding("utf-8");

	String AdminID = (String) session.getAttribute("AdminID");
	%>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"> <img
				src="img/knu_museum_logo.jpg" alt="Logo" width="30" height="24"
				class="d-inline-block align-text-top">
			</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="admin_artifact.jsp">유물관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="program_manage.jsp">체험프로그램 관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="program_apply_manage.jsp">체험프로그램 신청서
							관리</a></li>

					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="group_apply_manage.jsp">단체관람 신청서 관리</a></li>
				</ul>
				<span class="navbar-text">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="#"><%=AdminID%>님이
								관리중입니다.</a></li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>
	<br>
	<ul class="nav nav-underline justify-content-center">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="program_manage.jsp">체험 프로그램 조회하기</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="program_add.jsp">체험 프로그램 추가하기</a></li>
	</ul>
	<div class="info">
		<form action="program_add.jsp" method="Post" onsubmit="submitForm()">
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램
					제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="프로그램 제목" name="program_name">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램
					시작 날짜</label>
				<div class="col-sm-10">
					<input class="form-control" type="date" id="program_start"
						name="program_start">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램
					종료 날짜</label>
				<div class="col-sm-10">
					<input class="form-control" type="date" id="program_end"
						name="program_end">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">진행
					시간</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="진행 시간" name="program_time">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">제한
					인원</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="제한 인원" name="program_limit">
				</div>
			</div>
			<button type="submit" class="btn btn-secondary" value="Submit">제출</button>
		</form>
	</div>
	<script>
		function submitForm() {
			location.href = 'program_manage.jsp';
		}
	</script>

	<%
	String Title = "";
	String StartDate = "";
	String EndDate = "";
	String PTime = "";
	String LimitNum = "";
	String MadminID = "";

	Title = request.getParameter("program_name");

	if (Title != null && !Title.isEmpty()) {

		// EduID 설정
		String maxEduIDQuery = "SELECT MAX(TO_NUMBER(SUBSTR(EduID, 4))) AS MaxEduID FROM MUSEUM_PROGRAM_LIST";
		ResultSet maxEduIDResultSet = stmt.executeQuery(maxEduIDQuery);
		maxEduIDResultSet.next();
		int maxEduIDNumber = maxEduIDResultSet.getInt(1);
		int newEduIDNumber = maxEduIDNumber + 1;
		String newEduID = "Edu" + newEduIDNumber;
		maxEduIDResultSet.close();

		StartDate = request.getParameter("program_start");
		EndDate = request.getParameter("program_end");
		PTime = request.getParameter("program_time");
		LimitNum = request.getParameter("program_limit");
		MadminID = AdminID;

		String sql = "INSERT INTO MUSEUM_PROGRAM_LIST (EduID, Title, StartDate, EndDate, PTime, LimitNum, MadminID) VALUES (?, ?, TO_DATE(?, 'YYYY.MM.DD'), TO_DATE(?, 'YYYY.MM.DD'), ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, newEduID);
		pstmt.setString(2, Title);
		pstmt.setString(3, StartDate);
		pstmt.setString(4, EndDate);
		pstmt.setInt(5, Integer.parseInt(PTime));
		pstmt.setInt(6, Integer.parseInt(LimitNum));
		pstmt.setString(7, MadminID);

		int res = pstmt.executeUpdate();

		pstmt.close();
		conn.close();

		response.sendRedirect("program_manage.jsp");
	}
	%>
</body>
</html>