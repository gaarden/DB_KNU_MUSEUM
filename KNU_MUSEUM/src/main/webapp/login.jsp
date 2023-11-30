<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Result</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
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
	// HTML form에서 전송된 데이터 받아오기
	//String inputId = request.getParameter("id");
	//String inputPassword = request.getParameter("password");

	ResultSetMetaData rsmd;
	PreparedStatement pstmt;;
	ResultSet rs;
	// 로그인 성공 여부 체크

	request.setCharacterEncoding("utf-8");

	int loginState = 0;

	String selectedValue = request.getParameter("select");

	// 가져온 값에 따라 다른 처리 수행
	if ("user".equals(selectedValue)) {
		try {

			String query = "SELECT COUNT(*) AS UserCount FROM USERS WHERE UserID = '" + request.getParameter("id")
			+ "' AND Password = '" + request.getParameter("password") + "'";

			//pstmt.setString(1, inputId);
			//pstmt.setString(2, inputPassword);

			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();

			if (rs.next()) {
		loginState = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	} else if ("admin".equals(selectedValue)) {
		try {

			String query = "SELECT COUNT(*) AS UserCount FROM ADMIN WHERE AdminID = '" + request.getParameter("id")
			+ "' AND Password = '" + request.getParameter("password") + "'";

			//pstmt.setString(1, inputId);
			//pstmt.setString(2, inputPassword);

			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();

			if (rs.next()) {
		loginState = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	} else {
		out.println("라디오 버튼을 선택하지 않았습니다.");
	}
	%>

	<div class="form-container">
		<%
		if (loginState == 1 ) {

			if ("user".equals(selectedValue)) {
		%>

		<script>
			// JavaScript를 사용하여 리다이렉트
			window.location.href = "user_login.html";
		</script>


		<%
		} else if ("admin".equals(selectedValue)) {
		%>

		<script>
			// JavaScript를 사용하여 리다이렉트
			window.location.href = "admin_login.html";
		</script>

		<%
		}
		%>

		<%
		} else {
		%>
		<p>로그인에 실패. 아이디 또는 비밀번호를 확인해주세요.</p>
		<%
		}
		%>
		<a href="join.html">회원가입 </a> | <a href="searchid.html">아이디 찾기</a> | <a
			href="searchpw.html">비밀번호 찾기</a>
	</div>

</body>
</html>