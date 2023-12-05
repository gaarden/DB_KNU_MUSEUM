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

	String EduID = request.getParameter("EduID");

	String Title = request.getParameter("program_name");
	String StartDate = request.getParameter("program_start");
	String EndDate = request.getParameter("program_end");
	String PTime = request.getParameter("program_time");
	String LimitNum = request.getParameter("program_limit");

	String MadminID = request.getParameter("MadminID");

	String nTitle = request.getParameter("nprogram_name");
	String nStartDate = request.getParameter("nprogram_start");
	String nEndDate = request.getParameter("nprogram_end");
	String nPTime = request.getParameter("nprogram_time");
	String nLimitNum = request.getParameter("nprogram_limit");
	%>

	<%
	String sql = "UPDATE Museum_Program_List SET Title = ?, StartDate = TO_DATE(?, 'YYYY.MM.DD'), EndDate = TO_DATE(?, 'YYYY.MM.DD'), PTime = ?, LimitNum = ? WHERE EduID = ?";
	PreparedStatement updateMuseumProgram = conn.prepareStatement(sql);

	try {
		conn.setAutoCommit(false);
		
		if (nTitle != null && !nTitle.isEmpty()) {

			updateMuseumProgram.setString(1, nTitle);
			updateMuseumProgram.setString(2, nStartDate);
			updateMuseumProgram.setString(3, nEndDate);
			updateMuseumProgram.setInt(4, Integer.parseInt(nPTime));
			updateMuseumProgram.setInt(5, Integer.parseInt(nLimitNum));
			updateMuseumProgram.setString(6, EduID);

			// Execute the update
			int res = updateMuseumProgram.executeUpdate();

			if (res > 0) {
				conn.commit();
				response.sendRedirect("program_manage.jsp");
			} else {
				// Handle the case where the update was not successful
				out.println("Update failed.");
			}
		}
	} catch (SQLException e) {
		// Handle SQL exception (print or log the details)
		e.printStackTrace();
		conn.rollback();
	} finally {
		// Close resources in a finally block
		try {
			if (updateMuseumProgram != null) {
		updateMuseumProgram.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>

</body>
</html>