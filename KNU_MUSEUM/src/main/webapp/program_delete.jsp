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
	<%
	String serverIP = "localhost";
	//String strSID = "xe";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	PreparedStatement pstmtDeleteProgram = null;
	PreparedStatement pstmtDeleteApp = null;

	String AdminID = (String) session.getAttribute("AdminID");
	String EduID = request.getParameter("EduID");

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		
		String deleteAppQuery = "Delete from museum_program_application where ceduID = ?";
		pstmtDeleteApp = conn.prepareStatement(deleteAppQuery);
		pstmtDeleteApp.setString(1, EduID);
		pstmtDeleteApp.executeUpdate();

		String deleteProgramQuery = "DELETE FROM MUSEUM_PROGRAM_LIST WHERE EduID=?";
		pstmtDeleteProgram = conn.prepareStatement(deleteProgramQuery);
		pstmtDeleteProgram.setString(1, EduID);
		int res = pstmtDeleteProgram.executeUpdate();
		
		if (res > 0) {
            response.sendRedirect("program_manage.jsp");
        } else {
            // Handle the case where the update was not successful
            out.println("Delete failed.");
        }
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (pstmtDeleteProgram != null)
		pstmtDeleteProgram.close();
			if (conn != null)
		conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>
	
</body>