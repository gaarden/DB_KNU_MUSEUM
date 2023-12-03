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
<link rel="stylesheet" type="text/css" href="css/program_apply.css?ver=1.1">
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
	ResultSet rs = null;

	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	String UserID = (String) session.getAttribute("UserID");
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
	<form action="program_apply_complete.jsp" method="Post">
		<div class="box">
			<h2>현재 진행중 혹은 진행 예정 프로그램</h2>
			<%
			String query;
			request.setCharacterEncoding("utf-8");

			LocalDate currentDate = LocalDate.now();
			query = "SELECT EduID, Title, TO_CHAR(StartDate, 'YYYY-MM-DD') AS StartDate, TO_CHAR(EndDate, 'YYYY-MM-DD') AS EndDate, PTime, LimitNum "
					+ "FROM MUSEUM_PROGRAM_LIST WHERE EndDate > TO_DATE(?, 'YYYY-MM-DD') order by startdate";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, currentDate.toString());
			rs = pstmt.executeQuery();

			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();

			while (rs.next()) {
				out.println("<div class=\"element\">");
				out.println("<br>");
				String title = rs.getString(2);
				title = title.replace("<", "&lt;").replace(">", "&gt;");
				out.println("<h4>" + title + "</h4>");
				out.println("<p>* 진행 기간: " + rs.getString(3) + "~" + rs.getString(4) + "</p>");
				out.println("<p>* 소요 시간: " + rs.getString(5) + "시간</p>");
				out.println("<p>* 제한 인원: " + rs.getString(6) + "명</p>");
				out.println("<input type=\"radio\" name=\"program\" value=\"" + rs.getString(1) + "\" " + "data-start-date=\""
				+ rs.getString(3) + "\" data-end-date=\"" + rs.getString(4) + "\">");
				out.println("<br>");
				out.println("<br>");
				out.println("</div>");
			}

			rs.close();
			pstmt.close();

			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, currentDate.toString());
			rs = pstmt.executeQuery();
			%>

			<div class="date-container">
				<label for="selectedDate">날짜 및 시간:</label> <input type="date"
					id="selectedDate" name="selectedDate" style="margin: 10px;">
				<input type="radio" name="time" value="9">오전 9시 <input
					type="radio" name="time" value="14">오후 2시
			</div>

			<div class="date-container">
				<label for="selectedDate">신청 인원:</label> <input type="text"
					name="num" style="width: 50px;"> <label for="selectedDate">명</label>
			</div>

			<script>
				var programRadios = document
						.querySelectorAll('input[name="program"]');
				var dateInput = document.getElementById('selectedDate');

				function updateDateRange() {
					var selectedProgram = document
							.querySelector('input[name="program"]:checked');
					if (selectedProgram) {
						var selectedEduID = selectedProgram
								.getAttribute('value');
						var startDate = selectedProgram
								.getAttribute('data-start-date');
						var endDate = selectedProgram
								.getAttribute('data-end-date');
						var currentDate = new Date();

						// Check if the start date is in the past or future
						if (new Date(startDate) <= currentDate) {
							// Start date is in the past or today
							var tomorrow = new Date();
							tomorrow.setDate(tomorrow.getDate() + 1);
							var tomorrowFormatted = formatDate(tomorrow);

							dateInput.setAttribute('min', tomorrowFormatted);
							dateInput.setAttribute('max', endDate);
						} else {
							// Start date is in the future
							dateInput.setAttribute('min', startDate);
							dateInput.setAttribute('max', endDate);
						}
					}
				}

				function formatDate(date) {
					var day = date.getDate();
					var month = date.getMonth() + 1;
					var year = date.getFullYear();

					if (day < 10) {
						day = '0' + day;
					}

					if (month < 10) {
						month = '0' + month;
					}

					return year + '-' + month + '-' + day;
				}

				programRadios.forEach(function(radio) {
					radio.addEventListener('change', updateDateRange);
				});
			</script>

			<input type="submit" value="신청하기" />

		</div>
	</form>

	<%
	rs.close();
	pstmt.close();
	%>


</body>
</html>