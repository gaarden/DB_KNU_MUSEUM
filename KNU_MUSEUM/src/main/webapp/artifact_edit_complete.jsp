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
	request.setCharacterEncoding("utf-8");

	String AdminID = (String) session.getAttribute("AdminID");
	
	String ArtifactID = request.getParameter("ArtifactID");
	
	String Artname = request.getParameter("artifact_name");
	String Image = request.getParameter("artifact_picture");
	String Location = request.getParameter("artifact_location");
	String Class = request.getParameter("artifact_class");
	String Era = request.getParameter("artifact_era");
	
	String MadminID = request.getParameter("MadminID");
	
	String nArtname = request.getParameter("nartifact_name");
	String nImage = request.getParameter("nartifact_picture");
	String nLocation = request.getParameter("nartifact_location");
	String nClass = request.getParameter("nartifact_class");
	String nEra = request.getParameter("nartifact_era");
	String nMadminID = "";
	
	if (nLocation == null) {
		nMadminID = "admin662";
	} else if (nLocation.equals("제2전시실")) {
		nMadminID = "admin168";
	} else if (nLocation.equals("제3전시실")) {
		nMadminID = "admin239";
	} else if (nLocation.equals("제4전시실")) {
		nMadminID = "admin131";
	} else if (nLocation.equals("제5전시실")) {
		nMadminID = "admin870";
	} else {
		nMadminID = "admin662";
	}
	%>

	<%
	String sql = "UPDATE ARTIFACT SET Artname = ?, Image = ?, Location = ?, Class = ?, Era = ?, MadminID = ? WHERE ArtifactID = ?";
	PreparedStatement updateArtifact = conn.prepareStatement(sql);

	try {
		if (nArtname != null && !nArtname.isEmpty()) {
			updateArtifact.setString(1, nArtname);
			updateArtifact.setString(2, nImage);
			updateArtifact.setString(3, nLocation);
			updateArtifact.setString(4, nClass);
			updateArtifact.setString(5, nEra);
			updateArtifact.setString(6, nMadminID);
			updateArtifact.setString(7, ArtifactID);

			// Execute the update
			int res = updateArtifact.executeUpdate();

 			if (res > 0) {
	            response.sendRedirect("admin_artifact.jsp");
	        } else {
	            // Handle the case where the update was not successful
	            out.println("Update failed.");
	        }
		}
	} catch (SQLException e) {
		// Handle SQL exception (print or log the details)
		e.printStackTrace();
	} finally {
		// Close resources in a finally block
		try {
			if (updateArtifact != null) {
		updateArtifact.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>
	%>

</body>
</html>