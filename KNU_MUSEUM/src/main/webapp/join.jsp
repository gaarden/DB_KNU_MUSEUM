<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Result</title>
<link rel="stylesheet" type="text/css" href="css/join.css">
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
	String strSID = "orcl"; // 데이터베이스 SID
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
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
						aria-current="page" href="info.html">이용안내</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="artifact.jsp">소장유물</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="program.jsp">체험프로그램</a></li>
				</ul>
				<span class="navbar-text">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="login.html">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="join.html">회원가입</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>

	<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt = null;
	ResultSet rs;

	int loginState = 0;

	try {

		String id = request.getParameter("id");

		String query1 = "SELECT COUNT(*) AS UserCount FROM USERS WHERE UserID = '" + id + "'";

		//pstmt.setString(1, inputId);
		//pstmt.setString(2, inputPassword);

		pstmt = conn.prepareStatement(query1);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			loginState = rs.getInt(1);
		}
	%>
	<br>
	<div class="form-container">

		<%
		if (loginState == 1) {
		%>
		<p>동일한 아이디가 존재합니다.</p>
		<div style="text-align:center">
		<a href="http://localhost:8080/KNU_MUSEUM/join.html" style="color:#6C757D">회원가입</a> 
		</div>
		<%
		} else {

		// 삽입 쿼리 작성 (실제 데이터베이스 스키마에 맞게 수정 필요)
		String query = "INSERT INTO USERS VALUES ('" + request.getParameter("id") + "', '" + request.getParameter("password")
				+ "', '" + request.getParameter("name") + "', '" + request.getParameter("email") + "', '"
				+ request.getParameter("phoneNumber") + "')";

		pstmt = conn.prepareStatement(query);

		int result = pstmt.executeUpdate();

		if (result > 0) {
		%>

		<p>회원가입이 성공적으로 완료되었습니다.</p>
		<div style="text-align:center">
		<a href="login.html" style="color:#6C757D">로그인 페이지로 이동</a>
		</div>

		<%
		} else {
		%>

		<p>회원가입 중 오류가 발생했습니다.</p>

		<div style="text-align:center">
		<a href="http://localhost:8080/KNU_MUSEUM/join.html" style="color:#6C757D">회원가입</a> 
		</div>
		<%
		}

		}

		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		try {
		if (pstmt != null)
		pstmt.close();
		if (conn != null)
		conn.close();
		} catch (SQLException e) {
		e.printStackTrace();
		}
		}
		%>


	</div>
	
</body>
</html>