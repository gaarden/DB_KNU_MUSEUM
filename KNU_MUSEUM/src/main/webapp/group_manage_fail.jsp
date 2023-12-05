<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*,java.util.*"%>
<%@ page import="common.Person"%>
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
	String strSID = "orcl";
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	conn.setAutoCommit(false);

	request.setCharacterEncoding("utf-8");

	PreparedStatement pstmt = null;
	ResultSet rs;
	Statement stmt = null;

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
						<li class="nav-item"><%=AdminID%>님이 관리중입니다.</li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>

	<div class="box">
		<h2 style="margin-bottom: 20px;">신청자가 단체관람을 취소하여 승인에 실패했습니다.</h2>
		<a href="group_apply_manage.jsp" style="color: #626A72"><h4
				style="margin-bottom: 20px;">관리 페이지로 가기</h4></a>
	</div>


</body>
</html>