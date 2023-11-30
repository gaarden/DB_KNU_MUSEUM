<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/artifact_edit.css">
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
	<ul class="nav nav-underline justify-content-center">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="admin_artifact.jsp">유물 리스트</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="artifact_add.jsp">유물 추가하기</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="artifact_edit.jsp">유물 편집하기</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="artifact_delete.jsp">유물 삭제하기</a></li>
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="artifact_search.jsp">유물 조회하기</a></li>
	</ul>

	<div class="info">
		<form action="artifact_add.jsp" method="Post">
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">유물이름</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="colFormLabel"
						placeholder="유물이름" name="artifact_name">
				</div>
			</div>
			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">유물사진</label>
				<div class="col-sm-10">
					<input class="form-control" type="file" id="formFile"
						name="artifact_picture">
				</div>
			</div>

			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">유물분류</label>
				<div class="col-sm-10">
					<input name="artifact_class" type="text" class="form-control"
						placeholder="유물분류" aria-label="Recipient's username"
						aria-describedby="basic-addon2">
				</div>
			</div>

			<div class="row mb-3">
				<label for="colFormLabel" class="col-sm-2 col-form-label">전시실</label>
				<div class="col-sm-10">
					<select name="artifact_location" class="form-select"
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
					<select name="artifact_era" class="form-select"
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
			<button type="submit" class="btn btn-secondary" value="Submit">제출</button>
		</form>
	</div>
<%
	String query = new String();
	PreparedStatement pstmt;
	ResultSet rs;
	query = "select Count(1) from Artifact";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	request.setCharacterEncoding("utf-8");
	int row = 0;
	if(rs.next())
		row = rs.getInt(1);
	String cnt = Integer.toString(row+1);
	String aID = "A" + cnt;
	String aName = request.getParameter("artifact_name");
	String aPicture = request.getParameter("artifact_picture");
	String aClass = request.getParameter("artifact_class");
	String aLocation = request.getParameter("artifact_location");
	String aEra = request.getParameter("artifact_era");
	String MadminID;
	if (aLocation == null) {
		MadminID = "admin662";
	} else if (aLocation.equals("제2전시실")) {
		MadminID = "admin168";
	} else if (aLocation.equals("제3전시실")) {
		MadminID = "admin239";
	} else if (aLocation.equals("제4전시실")) {
		MadminID = "admin131";
	} else if (aLocation.equals("제5전시실")) {
		MadminID = "admin870";
	} else {
		MadminID = "admin662";
	}
	query = "Insert Into Artifact Values ('"  + aID + "' ,'" + aName + "', '" + aPicture + "' , '" + aClass + "' , '" + aLocation + "' , '" + aEra + "' , '" + MadminID + "')";
	out.println(query);
	//insert가 계속 안됨 -> 해결 필요!!
%>

<%
	rs.close();
	pstmt.close();
	conn.close();
%>
</body>
</html>