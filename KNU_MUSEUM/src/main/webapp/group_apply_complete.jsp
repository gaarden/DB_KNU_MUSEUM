<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.time.LocalDate, java.util.ArrayList, java.util.List, java.util.Random"%>
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

	String GAppDate = request.getParameter("selectedDate");
	String GAppTime = request.getParameter("time");
	String ApplyNum = request.getParameter("num");
	String CuserID = UserID;
	String CadminID;
	// grouptourID 설정
	String maxGroupTourIDQuery = "SELECT MAX(TO_NUMBER(SUBSTR(GroupTourID, 10))) AS MaxGroupTourID FROM GROUP_TOUR_APPLICATION";
	ResultSet maxGroupTourIDResultSet = stmt.executeQuery(maxGroupTourIDQuery);
	maxGroupTourIDResultSet.next();
	int maxGroupTourIDNumber = maxGroupTourIDResultSet.getInt(1);
	int newGroupTourIDNumber = maxGroupTourIDNumber + 1;
	String newGroupTourID = "grouptour" + newGroupTourIDNumber;
	maxGroupTourIDResultSet.close();

	// 랜덤으로 adminID 가져오기
	String adminIDQuery = "SELECT AdminID FROM ADMIN";
	ResultSet CadminIDResultSet = stmt.executeQuery(adminIDQuery);
	List<String> adminIDList = new ArrayList<>();
	while (CadminIDResultSet.next()) {
		adminIDList.add(CadminIDResultSet.getString(1));
	}
	Random random = new Random();
	CadminID = adminIDList.get(random.nextInt(adminIDList.size()));
	CadminIDResultSet.close();
	String sql = "INSERT INTO GROUP_TOUR_APPLICATION (GroupTourID, GAppDate, GAppTime, ApplyNum, Status, CuserID, CadminID) VALUES (?, TO_DATE(?, 'YYYY.MM.DD'), ?, ?, ?, ?, ?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, newGroupTourID);
	pstmt.setString(2, GAppDate);
	pstmt.setInt(3, Integer.parseInt(GAppTime));
	pstmt.setInt(4, Integer.parseInt(ApplyNum));
	pstmt.setInt(5, 0); // Status = 0
	pstmt.setString(6, CuserID);
	pstmt.setString(7, CadminID);
	
	int res = pstmt.executeUpdate();
	
	pstmt.close();
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
					<th scope="col">신청 날짜</th>
					<th scope="col">신청 시간</th>
					<th scope="col">신청 인원</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=GAppDate%></td>
					<td><%=GAppTime%></td>
					<td><%=ApplyNum%></td>
				</tr>
			</tbody>
		</table>
	</div>



</body>
</html>