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
 						<li class="nav-item"><a class="nav-link" href="#"><%=AdminID%>님이 관리중입니다.</a></li>
 						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
 					</ul>
 				</span>
 			</div>
 		</div>
 	</nav>
 	<br>
 	<ul class="nav nav-underline justify-content-center">
 		<li class="nav-item"><a class="nav-link active"
 			aria-current="page" href="admin_artifact.jsp">유물 조회하기</a></li>
 		<li class="nav-item"><a class="nav-link active"
 			aria-current="page" href="artifact_add.jsp">유물 추가하기</a></li>
 	</ul>
 	<div class="info">
 		<form action="artifact_edit_complete.jsp" method="Post">
 			<%
 			// Get the ArtifactID from the request parameter
 			String ArtifactID = request.getParameter("ArtifactID");

 			// Declare variables to store retrieved details
 			String Artname = "";
 			String Image = "";
 			String Location = "";
 			String Class = "";
 			String Era = "";
 			String MadminID = "";

 			// Check if ArtifactID is not null
 			if (ArtifactID != null && !ArtifactID.isEmpty()) {
 				try {
 					// Prepare SQL statement to retrieve details for the given ArtifactID
 					String query = "SELECT Artname, Image, Location, Class, Era, MadminID FROM Artifact WHERE ArtifactID = ?";
 					PreparedStatement pstmt = conn.prepareStatement(query);
 					pstmt.setString(1, ArtifactID);

 					// Execute the query
 					ResultSet rs = pstmt.executeQuery();

 					// Check if the result set has a row
 					if (rs.next()) {
 				// Retrieve details
 				Artname = rs.getString(1);
 				Image = rs.getString(2);
 				Location = rs.getString(3);
 				Class = rs.getString(4);
 				Era = rs.getString(5);
 				MadminID = rs.getString(6);
 					}

 					// Close resources
 					rs.close();
 					pstmt.close();
 				} catch (Exception e) {
 					// Handle exceptions
 					e.printStackTrace();
 				}
 			} else {
 				// Handle the case where ArtifactID is null or empty
 				out.println("ArtifactID is not specified.");
 			}
 			%>
 			<h2 style="margin-bottom: 20px;">기존 정보</h2>
 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">유물이름</label>
 				<div class="col-sm-10">
 					<input type="text" class="form-control" id="colFormLabel"
 						placeholder="유물이름" name="artifact_name" value="<%=Artname%>"
 						readonly>
 				</div>
 			</div>
 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">유물사진</label>
 				<div class="col-sm-10">
 					<input type="text" class="form-control" id="colFormLabel"
 						placeholder="유물사진" name="artifact_picture" value="<%=Image %>"
 						readonly>
 				</div>
 			</div>
 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">유물분류</label>
 				<div class="col-sm-10">
 					<input type="text" class="form-control" id="colFormLabel"
 						placeholder="유물분류" name="artifact_class" value="<%=Class%>"
 						readonly>
 				</div>
 			</div>
 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">전시실</label>
 				<div class="col-sm-10">
 					<input type="text" class="form-control" id="colFormLabel"
 						placeholder="전시실" name="artifact_location" value="<%=Location%>"
 						readonly>
 				</div>
 			</div>
 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">시대</label>
 				<div class="col-sm-10">
 					<input type="text" class="form-control" id="colFormLabel"
 						placeholder="시대" name="artifact_era" value="<%=Era%>" readonly>
 				</div>
 			</div>

 			<hr class="my-4">

 			<h2 style="margin-bottom: 20px;">수정 정보</h2>
 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">유물이름</label>
 				<div class="col-sm-10">
 					<input type="text" class="form-control" id="colFormLabel"
 						placeholder="유물이름" value="<%=Artname%>" name="nartifact_name">
 				</div>
 			</div>
 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">유물사진</label>
 				<div class="col-sm-10">
 					<input class="form-control" type="file" id="formFile"
 						name="nartifact_picture">
 				</div>
 			</div>

 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">유물분류</label>
 				<div class="col-sm-10">
 					<input name="nartifact_class" type="text" class="form-control"
 						placeholder="유물분류" aria-label="Recipient's username"
 						aria-describedby="basic-addon2">
 				</div>
 			</div>

 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">전시실</label>
 				<div class="col-sm-10">
 					<select name="nartifact_location" class="form-select"
 						aria-label="Default select example">
 						<option value=null selected>전체</option>
 						<option value="제1전시실">제1전시실</option>
 						<option value="제2전시실">제2전시실</option>
 						<option value="제3전시실">제3전시실</option>
 						<option value="제4전시실">제4전시실</option>
 						<option value="제5전시실">제5전시실</option>
 					</select>
 				</div>
 			</div>

 			<div class="row mb-3">
 				<label for="colFormLabel" class="col-sm-2 col-form-label">시대</label>
 				<div class="col-sm-10">
 					<select name="nartifact_era" class="form-select"
 						aria-label="Default select example">
 						<option value="0" selected>전체</option>
 						<option value="구석기시대">구석기시대</option>
 						<option value="신석기시대">신석기시대</option>
 						<option value="청동기시대">청동기시대</option>
 						<option value="철기시대">철기시대</option>
 						<option value="삼국시대">삼국시대</option>
 						<option value="통일신라시대">통일신라시대</option>
 						<option value="고려시대">고려시대</option>
 						<option value="조선시대">조선시대</option>
 						<option value="근현대">근현대</option>
 					</select>
 				</div>
 			</div>

 			<input type="hidden" name="ArtifactID" value="<%=ArtifactID%>">
 			<input type="hidden" name="MadminID" value="<%=MadminID%>">

 			<button type="submit" class="btn btn-secondary" value="Submit">제출</button>
 		</form>
 	</div>
 </body>
 </html>