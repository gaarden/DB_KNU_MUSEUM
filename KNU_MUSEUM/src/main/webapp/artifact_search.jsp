<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/artifact_search.css">
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
						aria-current="page" href="info.html">이용안내</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">유물관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">체험프로그램 관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">단체프로그램 관리</a></li>
				</ul>
				<span class="navbar-text">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="#">관리자페이지</a>
						</li>
					</ul>
				</span>
			</div>
		</div>
	</nav>
	<br>
	<ul class="nav nav-underline justify-content-center">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="admin_artifact.jsp">유물 리스트</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="artifact_add.jsp">유물 추가하기</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="artifact_search.jsp">유물 조회하기</a></li>
	</ul>

	<div class="info">
		<form class="d-flex" action="artifact_search.jsp" method="Post">
			<input class="form-control me-2" type="search" placeholder="Search"
				aria-label="Search" name="artifact_name">
			<button class="btn btn-secondary" type="submit">Search</button>
		</form>
		<br>
		<table class="table align-middle">
			<thead class="table-warning">
				<tr>
					<td>유물ID</td>
					<td>이름</td>
					<td>사진</td>
					<td>위치</td>
					<td>분류</td>
					<td>시대</td>
					<td>관리자ID</td>
				</tr>
			</thead>
<%
	String query = new String();
	ResultSet rs;
	
	request.setCharacterEncoding("utf-8");
	
	String artifactName = "";
	artifactName = request.getParameter("artifact_name");
	String searchArtifactQuery = "SELECT * FROM ARTIFACT WHERE ARTNAME LIKE '%" + artifactName + "%'";
	stmt = conn.createStatement();
	ResultSet searchList = stmt.executeQuery(searchArtifactQuery);
	out.println("<tbody>");
	while(searchList.next()){
		out.println("<tr class=\"artifact\">");
		out.println("<td>" + searchList.getString(1) + "</td>");
		out.println("<td>" + searchList.getString(2) + "</td>");
		out.println("<td>" + searchList.getString(3) + "</td>");
		out.println("<td>" + searchList.getString(4) + "</td>");
		out.println("<td>" + searchList.getString(5) + "</td>");
		out.println("<td>" + searchList.getString(6) + "</td>");
		out.println("<td>" + searchList.getString(7) + "</td>");
		out.println("</tr>");		
	}	
	conn.close();	
%>
	</table>
	</div>
<script src="js/artifact_search.js">
</script>
</body>
</html>