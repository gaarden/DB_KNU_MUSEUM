<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/user_modify_info.css">
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

	request.setCharacterEncoding("utf-8");

	String UserID = (String) session.getAttribute("UserID");
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
						<li class="nav-item"><a class="nav-link" href="user_view.jsp">My
								Page</a></li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>

	<ul class="nav nav-underline justify-content-center">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="user_view.jsp">신청내역조회</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="user_modify_info.jsp">개인정보수정</a></li>
	</ul>



	<%
	// Declare variables to store retrieved details
	String password = "";
	String name = "";
	String Email = "";
	String Pnumber = "";

	try {
		// Prepare SQL statement to retrieve details for the given ArtifactID
		String query = "SELECT Password, Name, Email, PNumber FROM USERS WHERE UserID = ?";

		PreparedStatement pstmt;
		ResultSet rs;

		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, UserID);

		// Execute the query
		rs = pstmt.executeQuery();

		// Check if the result set has a row
		if (rs.next()) {
			// Retrieve details
			password = rs.getString(1);
			name = rs.getString(2);
			Email = rs.getString(3);
			Pnumber = rs.getString(4);

		}

		// Close resources
		rs.close();
		pstmt.close();
	} catch (Exception e) {
		// Handle exceptions
		e.printStackTrace();
	}
	%>


	<div class="row row-cols-3">
		<div class="col"></div>
		<div class="col">
			<div class="info">


				<form class="row g-3" action="user_modified.jsp" method="post">
					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">@아이디</span> <span
							class="form-control" aria-label="Username"
							aria-describedby="basic-addon1"><%=UserID%></span>
					</div>

					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">비밀번호</span> <input
							type="password" class="form-control" name="password"
							placeholder="비밀번호" aria-label="Recipient's username"
							aria-describedby="basic-addon2" value="<%=password%>">
					</div>

					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">@이름@</span> <input
							type="text" class="form-control" name="name" placeholder="이름"
							aria-label="Recipient's username" aria-describedby="basic-addon2"
							value="<%=name%>">
					</div>

					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">@이메일</span> <input
							type="email" class="form-control" name="email" placeholder="이메일"
							aria-label="Recipient's username" aria-describedby="basic-addon2"
							value="<%=Email%>">
					</div>

					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1">전화번호</span> <input
							type="tel" class="form-control" name="PNumber" placeholder="전화번호"
							aria-label="Recipient's username" aria-describedby="basic-addon2"
							value="<%=Pnumber%>">
					</div>
					<button type="submit" class="btn btn-secondary">제출</button>
				</form>
			</div>
		</div>
	</div>

</body>
</html>