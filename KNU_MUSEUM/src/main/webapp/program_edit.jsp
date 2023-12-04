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
						<li class="nav-item"><a class="nav-link" href="#"><%=AdminID%>님이 관리중입니다.</a></li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>
	<br>
	<ul class="nav nav-underline justify-content-center">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="program_manage.jsp">프로그램 목록</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="program_add.jsp">프로그램 추가하기</a></li>
	</ul>
	<div class="info">
		<form action="program_edit_complete.jsp" method="Post">
			<%
			// Get the ArtifactID from the request parameter
			String EduID = request.getParameter("EduID");

			// Declare variables to store retrieved details
			String Title = "";
			String StartDate = "";
			String EndDate = "";
			String PTime = "";
			String LimitNum = "";
			String MadminID = "";

			// Check if ArtifactID is not null
			if (EduID != null && !EduID.isEmpty()) {
				try {
					// Prepare SQL statement to retrieve details for the given ArtifactID
					String query = "SELECT Title, TO_CHAR(StartDate, 'yyyy-mm-dd'), TO_CHAR(EndDate, 'yyyy-mm-dd'), PTime, LimitNum, MadminID FROM Museum_Program_List WHERE EduID = ?";
					PreparedStatement pstmt = conn.prepareStatement(query);
					pstmt.setString(1, EduID);

					// Execute the query
					ResultSet rs = pstmt.executeQuery();

					// Check if the result set has a row
					if (rs.next()) {
				// Retrieve details
				Title = rs.getString(1);
				StartDate = rs.getString(2);
				EndDate = rs.getString(3);
				PTime = rs.getString(4);
				LimitNum = rs.getString(5);
				MadminID = rs.getString(6);
					}

					// Close resources
					rs.close();
					pstmt.close();
				} catch (Exception e) {
					// Handle exceptions
					e.printStackTrace();
				}
			} else {
				// Handle the case where ArtifactID is null or empty
				out.println("EduID is not specified.");
			}
			%>
			<h2 style="margin-bottom: 20px;">기존 정보</h2>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램 제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="프로그램 제목" name="program_name" value="<%=Title%>"
						readonly>
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램 시작 날짜</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="프로그램 시작 날짜" name="program_start" value="<%=StartDate%>"
						readonly>
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램 종료 날짜</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="프로그램 종료 날짜" name="program_end" value="<%=EndDate%>"
						readonly>
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">진행 시간</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="진행 시간" name="program_time" value="<%=PTime%>"
						readonly>
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">제한 인원</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="제한 인원" name="program_limit" value="<%=LimitNum%>" readonly>
				</div>
			</div>

			<hr class="my-4">

			<h2 style="margin-bottom: 20px;">수정 정보</h2>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램 제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="프로그램 제목" name="nprogram_name" value="<%=Title %>">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램 시작 날짜</label>
				<div class="col-sm-10">
					<input class="form-control" type="date" id="nprogram_start" value="<%=StartDate%>"
						name="nprogram_start">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">프로그램 종료 날짜</label>
				<div class="col-sm-10">
					<input class="form-control" type="date" id="nprogram_end" value="<%=EndDate%>"
						name="nprogram_end">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">진행 시간</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="진행 시간" name="nprogram_time" value="<%=PTime%>">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">제한 인원</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="제한 인원" name="nprogram_limit" value="<%=LimitNum%>">
				</div>
			</div>

			<input type="hidden" name="EduID" value="<%=EduID%>">
			<input type="hidden" name="MadminID" value="<%=MadminID%>">

			<button type="submit" class="btn btn-secondary" value="Submit">제출</button>
		</form>
	</div>
</body>
</html>