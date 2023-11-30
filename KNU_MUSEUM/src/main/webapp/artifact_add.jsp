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
	PreparedStatement pstmt;
	ResultSet rs;
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
						aria-current="page" href="info.html">이용안내</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">유물관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">체험프로그램 관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">단체프로그램 관리</a></li>
				</ul>
				<span class="navbar-text">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="#">관리자페이지</a>
						</li>
					</ul>
				</span>
			</div>
		</div>
	</nav>
	<br>
	<div class="info">
		<form action="artifact_add.jsp" method="Post">
			<h4>유물 이름</h4>
			<div class="input-group mb-3">
				<input name="artifact_name" type="text" class="form-control"
					placeholder="유물이름" aria-label="Username"
					aria-describedby="basic-addon1">
			</div>
			
			<h4>유물의 사진을 업로드해주세요.</h4>
			<div class="mb-3">
  			<input class="form-control" type="file" id="formFile" name="artifact_picture">
			</div>

			<h4>유물 분류</h4>
			<div class="input-group mb-3">
				<input name="artifact_class" type="text" class="form-control"
					placeholder="유물분류" aria-label="Recipient's username"
					aria-describedby="basic-addon2">
			</div>

			<h4>전시실 선택</h4>
			<select name="location" class="form-select" aria-label="Default select example">
				<option value="0" selected>전체</option>
				<option value="제1전시실">제1전시실</option>
				<option value="제2전시실">제2전시실</option>
				<option value="제3전시실">제3전시실</option>
				<option value="제4전시실">제4전시실</option>
				<option value="제5전시실">제5전시실</option>
			</select> <br>
			<h4>시대 선택</h4>
			<select name="era" class="form-select" aria-label="Default select example">
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
			<br>
			<button type="submit" class="btn btn-secondary" value="submit">제출</button>
		</form>
	</div>
</body>
</html>