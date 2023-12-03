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

<style>
.box {
	background-color: white;
	background-position: center;
	margin: 50px;
	border-radius: 15px;
	overflow: hidden;
	text-align: center;
}
</style>

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
						aria-current="page" href="info.html">이용안내</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="admin_artifact.jsp">유물관리</a></li>
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
	
	<%
	String serverIP = "localhost";
	//String strSID = "xe";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	PreparedStatement pstmtDeleteDesc = null;
	PreparedStatement pstmtDeleteArtifact = null;

	String AdminID = (String) session.getAttribute("AdminID");
	String artifactID = request.getParameter("ArtifactID");

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		// Delete from DESCRIPTION table first
		String deleteDescQuery = "DELETE FROM DESCRIPTION WHERE HartifactID=?";
		pstmtDeleteDesc = conn.prepareStatement(deleteDescQuery);
		pstmtDeleteDesc.setString(1, artifactID);
		pstmtDeleteDesc.executeUpdate();

		// Now, delete from ARTIFACT table
		String deleteArtifactQuery = "DELETE FROM ARTIFACT WHERE ArtifactID=?";
		pstmtDeleteArtifact = conn.prepareStatement(deleteArtifactQuery);
		pstmtDeleteArtifact.setString(1, artifactID);
		int rowsAffected = pstmtDeleteArtifact.executeUpdate();
		
		out.println("<div class=\"box\">");
		// Display a message based on the delete result
		if (rowsAffected > 0) {
            response.sendRedirect("admin_artifact.jsp");
        } else {
            // Handle the case where the update was not successful
            out.println("Delete failed.");
        }
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (pstmtDeleteDesc != null)
		pstmtDeleteDesc.close();
			if (pstmtDeleteArtifact != null)
		pstmtDeleteArtifact.close();
			if (conn != null)
		conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>
	
</body>