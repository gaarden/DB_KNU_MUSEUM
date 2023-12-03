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
	<%
	String serverIP = "localhost";
	//String strSID = "xe";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	Statement stmt = null;

	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();

	request.setCharacterEncoding("utf-8");

	String UserID = (String) session.getAttribute("UserID");

	String CeduID = request.getParameter("program");
	String ApplyNum = request.getParameter("num");
	String MAppDate = request.getParameter("selectedDate");
	String MAppTimeS = request.getParameter("time");
	String CuserID = UserID;
	String title = "";

	// CeduID 설정
	if (request.getSession().getAttribute("selectedEduID") != null) {
		CeduID = (String) request.getSession().getAttribute("selectedEduID");
	}

	// ApplyID 설정
	String maxApplyIDQuery = "SELECT MAX(TO_NUMBER(SUBSTR(ApplyID, 6))) AS MaxApplyID FROM MUSEUM_PROGRAM_APPLICATION";
	ResultSet maxApplyIDResultSet = stmt.executeQuery(maxApplyIDQuery);
	maxApplyIDResultSet.next();
	int maxApplyIDNumber = maxApplyIDResultSet.getInt(1);
	int newApplyIDNumber = maxApplyIDNumber + 1;
	String newApplyID = "apply" + newApplyIDNumber;
	maxApplyIDResultSet.close();

	// 해당 프로그램에 맞는 CadminID 가져오기
	String sql2 = "SELECT MadminID FROM MUSEUM_PROGRAM_LIST WHERE EduID = ?";
	PreparedStatement pstmt3 = conn.prepareStatement(sql2);
	pstmt3.setString(1, CeduID);
	ResultSet adminIDResultSet = pstmt3.executeQuery();
	String CadminID = null;
	if (adminIDResultSet.next()) {
		CadminID = adminIDResultSet.getString(1);
	} else {
		// Handle the case when no matching EduID is found
		out.println("No matching EduID found in the museum_program_list table.");
	}
	pstmt3.close();
	adminIDResultSet.close();

	String sql = "INSERT INTO MUSEUM_PROGRAM_APPLICATION (ApplyID, ApplyNum, MAppDate, MAppTime, Status, CeduID, CuserID, CadminID) VALUES (?, ?, TO_DATE(?, 'YYYY.MM.DD'), ?, ?, ?, ?, ?)";
	PreparedStatement pstmt2 = conn.prepareStatement(sql);
	pstmt2.setString(1, newApplyID);
	pstmt2.setInt(2, Integer.parseInt(ApplyNum));
	pstmt2.setString(3, MAppDate);
	pstmt2.setInt(4, Integer.parseInt(MAppTimeS));
	pstmt2.setInt(5, 0); // Status = 0
	pstmt2.setString(6, CeduID);
	pstmt2.setString(7, CuserID);
	pstmt2.setString(8, CadminID);

	int res = pstmt2.executeUpdate();
	pstmt2.close();

	String sql1 = "select title from museum_program_list where eduid = ?";
	PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	pstmt1.setString(1, CeduID);
	ResultSet rs1 = pstmt1.executeQuery();
	if (rs1.next()) {
		title = rs1.getString(1);
	} else {
		out.println("No matching title found in the museum_program_list table.");
	}
	pstmt1.close();
	rs1.close();
	%>

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
		<h2 style="margin-bottom: 20px;">신청이 완료되었습니다.</h2>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">프로그램 제목</th>
					<th scope="col">신청 날짜</th>
					<th scope="col">신청 시간</th>
					<th scope="col">신청 인원</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=title%></td>
					<td><%=MAppDate%></td>
					<td><%=MAppTimeS%></td>
					<td><%=ApplyNum%></td>
				</tr>
			</tbody>
		</table>
		<a href="user_view.jsp"><h4 style="margin-bottom: 20px;">
				신청내역 확인하기</h4></a>
	</div>



</body>
</html>