<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM_DB</title>
<link rel="stylesheet" type="text/css" href="css/admin_artifact.css">
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
	//+"?useUnicode=true&characterEncoding=UTF-8"

	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	request.setCharacterEncoding("utf-8");

	String UserID = (String) session.getAttribute("UserID");
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
			aria-current="page" href="admin_artifact.jsp">유물 조회하기</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="artifact_add.jsp">유물 추가하기</a></li>
	</ul>

	<div class="table-responsive">
		<form class="d-flex" action="admin_artifact.jsp" method="Post">
			<input class="form-control me-2" type="search" placeholder="Search"
				aria-label="Search" name="artifact_name">
			<button class="btn btn-secondary" type="submit">Search</button>
		</form>
		<br>
		<table class="table align-middle">
			<thead class="table-warning">
				<tr>
					<td>유물 ID</td>
					<td>이름</td>
					<td>사진</td>
					<td>위치</td>
					<td>분류</td>
					<td>시대</td>
					<td>관리자ID</td>
					<td></td>
					<td></td>
				</tr>
			</thead>
			<%
			String query = new String();
			PreparedStatement pstmt;
			ResultSet rs;
			String artifactName = "";
			artifactName = request.getParameter("artifact_name");
			if (artifactName == null || artifactName.isEmpty()) {
			    // If artifactName is empty or null, retrieve all artifacts
			    query = "SELECT Artname, Image, Location, Class, Era, MadminID, ArtifactID FROM Artifact ORDER BY ArtifactID";
			    pstmt = conn.prepareStatement(query);
			} else {
			    // If artifactName has a value, use the LIKE condition
			    query = "SELECT Artname, Image, Location, Class, Era, MadminID, ArtifactID FROM Artifact WHERE ARTNAME LIKE ? ORDER BY ArtifactID";
			    pstmt = conn.prepareStatement(query);
			    pstmt.setString(1, "%" + artifactName + "%");
			}
			rs = pstmt.executeQuery();
			out.println("<tbody>");
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + (rs.getString(7) != null ? rs.getString(7) : "") + "</td>");
				out.println("<td>" + (rs.getString(1) != null ? rs.getString(1) : "") + "</td>");
				out.println("<td>" + (rs.getString(2) != null ? rs.getString(2) : "") + "</td>");
				out.println("<td>" + (rs.getString(3) != null ? rs.getString(3) : "") + "</td>");
				out.println("<td>" + (rs.getString(4) != null ? rs.getString(4) : "") + "</td>");
				out.println("<td>" + (rs.getString(5) != null ? rs.getString(5) : "") + "</td>");
				out.println("<td>" + (rs.getString(6) != null ? rs.getString(6) : "") + "</td>");
				
				if (AdminID != null && AdminID.equals(rs.getString(6))) {
					// Display edit and delete buttons
					out.println("<td><button onclick='location.href=\"artifact_edit.jsp?ArtifactID=" + rs.getString(7) + "\"'>편집</button></td>");
                    out.println("<td><button onclick='location.href=\"artifact_delete.jsp?ArtifactID=" + rs.getString(7) + "\"'>삭제</button></td>");
				} else {
					// Display empty cells if AdminID doesn't match
					out.println("<td></td>");
					out.println("<td></td>");
				}
				
				out.println("</tr>");
			}
			%>
		</table>
	</div>
	<br>
	<%
	rs.close();
	pstmt.close();
	conn.close();
	%>
</body>
</html>