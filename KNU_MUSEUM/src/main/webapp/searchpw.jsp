<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
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
	String strSID = "orcl";
	String portNum = "1521";
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	request.setCharacterEncoding("utf-8");
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
						aria-current="page" href="program.html">체험프로그램</a></li>
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
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		// Retrieve user ID based on provided information
		String query = "SELECT Password FROM USERS WHERE UserID='" + request.getParameter("id") + "' AND Name ='"
		+ request.getParameter("name") + "' AND Email = '" + request.getParameter("email") + "' AND PNumber = '"
		+ request.getParameter("PNumber") + "'";
		pstmt = conn.prepareStatement(query);

		rs = pstmt.executeQuery();

		if (rs.next()) {
			// User found, display the ID
	%>
	<div class="form-container">
		<p>비밀번호 찾기 성공!</p>
		<p>
			회원님의 비밀번호는:
			<%=rs.getString(1)%></p>
		<a href="login.html">로그인 페이지로 이동</a> 
	</div>
	<%
	} else {
	// User not found
	%>
	<div class="form-container">
		<p>입력한 정보와 일치하는 회원이 없습니다.</p>

		<a href="join.html">회원가입 </a> | <a href="searchid.html">아이디 찾기</a> | <a
			href="searchpw.html">비밀번호 찾기</a>
	</div>
	<%
	}
	} catch (Exception e) {
	e.printStackTrace();
	} finally {
	try {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	} catch (SQLException e) {
	e.printStackTrace();
	}
	}
	%>

</body>
</html>
