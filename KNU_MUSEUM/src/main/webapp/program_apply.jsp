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
</head>
<body>
	<%
	String serverIP = "localhost";
	//String strSID = "xe";
	//String strSID = "orcl";
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
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
						aria-current="page" href="info.html">이용안내</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="artifact.jsp">소장유물</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="program.jsp">체험프로그램</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">체험프로그램 신청</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">단체관람 신청</a></li>
				</ul>
				<span class="navbar-text">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="#">My Page</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>

	<div class="box">
		<h2>현재 진행중 혹은 진행 예정 프로그램</h2>
		<%
		String query;
		request.setCharacterEncoding("utf-8");

		LocalDate currentDate = LocalDate.now();
		query = "SELECT Title, TO_CHAR(StartDate, 'YYYY-MM-DD') AS StartDate, TO_CHAR(EndDate, 'YYYY-MM-DD') AS EndDate, PTime, LimitNum "
				+ "FROM MUSEUM_PROGRAM_LIST WHERE EndDate > TO_DATE(?, 'YYYY-MM-DD') order by startdate";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, currentDate.toString());
		rs = pstmt.executeQuery();

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();

		while (rs.next()) {
			out.println("<div class=\"element\">");
			out.println("<br>");
			String title = rs.getString(1);
			title = title.replace("<", "&lt;").replace(">", "&gt;");
			out.println("<h4>" + title + "</h4>");
			out.println("<p>* 진행 기간: " + rs.getString(2) + "~" + rs.getString(3) + "</p>");
			out.println("<p>* 소요 시간: " + rs.getString(4) + "시간</p>");
			out.println("<p>* 제한 인원: " + rs.getString(5) + "명</p>");
			out.println("<input type=\"radio\" name=\"program\" value=\"" + rs.getString(1) + "\" " + "data-start-date=\""
			+ rs.getString(2) + "\" data-end-date=\"" + rs.getString(3) + "\">");
			/* out.println("<input type=\"radio\" name=\"program\" value=\"" + rs.getString(1) + "\">"); */
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
					var startDate = selectedProgram
							.getAttribute('data-start-date');
					var endDate = selectedProgram.getAttribute('data-end-date');
					dateInput.setAttribute('min', startDate);
					dateInput.setAttribute('max', endDate);
				}
			}

			programRadios.forEach(function(radio) {
				radio.addEventListener('change', updateDateRange);
			});
		</script>

		<form action="program_apply.jsp" method="Post">
			<input type="submit" value="신청하기" />
		</form>

	</div>


	<%
	rs.close();
	pstmt.close();
	%>


</body>
</html>