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
<link rel="stylesheet" type="text/css" href="css/program.css?ver=1.2">
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
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	request.setCharacterEncoding("utf-8");

	String UserID = (String) session.getAttribute("UserID");
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
						<li class="nav-item"><a class="nav-link" href="user_view.jsp">
								My Page</a></li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>

	<div class="box">
		<form action="program_for_user.jsp" method="Post">
			<input type="text" name="keyword" placeholder="검색어 입력" /> <input
				type="submit" value="검색" /> <br> <input type="radio"
				name="chk_info" value="0">전체 프로그램 조회 <input type="radio"
				name="chk_info" value="1">진행중인 프로그램만 조회
		</form>

	</div>

	<div class="box">
		<%
		String query;
		request.setCharacterEncoding("utf-8");

		if (request.getParameter("keyword") == null | "".equals(request.getParameter("keyword"))) {
			if ("0".equals(request.getParameter("chk_info")) | request.getParameter("chk_info") == null) {
				query = "select Title, TO_CHAR(StartDate, 'YYYY-MM-DD') AS StartDate, TO_CHAR(EndDate, 'YYYY-MM-DD') AS EndDate, PTime, LimitNum "
				+ "from museum_program_list order by startdate desc";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
			} else {
				LocalDate currentDate = LocalDate.now();
				query = "SELECT Title, TO_CHAR(StartDate, 'YYYY-MM-DD') AS StartDate, TO_CHAR(EndDate, 'YYYY-MM-DD') AS EndDate, PTime, LimitNum "
				+ "FROM MUSEUM_PROGRAM_LIST WHERE EndDate > TO_DATE(?, 'YYYY-MM-DD') order by startdate desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, currentDate.toString());
				rs = pstmt.executeQuery();
			}
		} else {
			if ("0".equals(request.getParameter("chk_info")) | request.getParameter("chk_info") == null) {
				query = "SELECT Title, TO_CHAR(StartDate, 'YYYY-MM-DD') AS StartDate, TO_CHAR(EndDate, 'YYYY-MM-DD') AS EndDate, PTime, LimitNum "
				+ "FROM MUSEUM_PROGRAM_LIST " + "WHERE Title LIKE '%" + request.getParameter("keyword")
				+ "%' order by startdate desc";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
			} else {
				LocalDate currentDate = LocalDate.now();
				query = "SELECT Title, TO_CHAR(StartDate, 'YYYY-MM-DD') AS StartDate, TO_CHAR(EndDate, 'YYYY-MM-DD') AS EndDate, PTime, LimitNum "
				+ "FROM MUSEUM_PROGRAM_LIST WHERE EndDate > TO_DATE(?, 'YYYY-MM-DD') and title like '%"
				+ request.getParameter("keyword") + "%' order by startdate desc";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, currentDate.toString());
				rs = pstmt.executeQuery();
			}
		}

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();

		while (rs.next()) {
			out.println("<div class=\"element\">");
			out.println("<br>");
			String title = rs.getString(1);
			title = title.replace("<", "&lt;").replace(">", "&gt;");
			out.println("<h4>" + title + "</h4>");
			out.println("<p>* 진행 기간: " + rs.getString(2) + "~" + rs.getString(3) + "</p>");
			out.println("<p>* 소요 시간: " + rs.getString(4) + "</p>");
			out.println("<p>* 제한 인원: " + rs.getString(5) + "</p>");
			out.println("<br>");
			out.println("</div>");
		}
		rs.close();
		pstmt.close();
		%>
	</div>
</body>
</html>