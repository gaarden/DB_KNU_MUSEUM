<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM_DB</title>
<link rel="stylesheet" type="text/css" href="css/user_view.css">
<link rel="stylesheet" type="text/css" href="css/program.css">
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
	PreparedStatement pstmt = null;
	ResultSet rs;
	Statement stmt = null;

	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	conn.setAutoCommit(false);

	request.setCharacterEncoding("utf-8");

	String UserID = (String) session.getAttribute("UserID");
	String query = "";
	String cancelID = request.getParameter("cancelID");
	
	if (cancelID != null && !cancelID.isEmpty()) {
	    char cancelIDPrefix = cancelID.charAt(0);

	    if (cancelIDPrefix == 'a') { // Assuming 'a' corresponds to MUSEUM_PROGRAM_APPLICATION
	        query = "DELETE FROM MUSEUM_PROGRAM_APPLICATION WHERE ApplyID=?";
	    } else if (cancelIDPrefix == 'g') { // Assuming 'g' corresponds to GROUP_TOUR_APPLICATION
	        query = "DELETE FROM GROUP_TOUR_APPLICATION WHERE grouptourID=?";
	    }

	    try {
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, cancelID);
	        int res = pstmt.executeUpdate();
	        
	        if (res > 0) {
                conn.commit(); // Commit the transaction if the delete operations are successful
            }
	    } catch (SQLException e) {
	        // Handle exceptions if necessary
	        e.printStackTrace();
	        conn.rollback();
	    } finally {
	    	try {
	            if (pstmt != null) pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
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
						<li class="nav-item"><a class="nav-link" href="user_view.jsp">My Page</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>
	<br>
	<ul class="nav nav-underline justify-content-center">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="user_view.jsp">신청내역조회</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="user_modify_info.jsp">개인정보수정</a></li>
	</ul>
	
	<div class="box">
		<h2 style="margin-bottom: 20px;">신청이 취소되었습니다.</h2>
		<a href="user_view.jsp" style="color:#6C757D"><h4>My Page로 돌아가기 </h4></a>
	</div>
	

</body>
</html>
