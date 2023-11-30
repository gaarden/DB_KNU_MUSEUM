<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/artifact.css">
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
						aria-current="page" href="#">체험프로그램</a></li>
				</ul>
				<span class="navbar-text">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="#">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="#">회원가입</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>
	
	<div class="artifact">
		<form action="artifact.jsp" method="Post">
		<h3>조건 검색</h3>
		<h4>전시실 선택</h4>
		<select name="location">
			<option value="0" selected>전체</option>
			<option value="제1전시실">제1전시실</option>
			<option value="제2전시실">제2전시실</option>
			<option value="제3전시실">제3전시실</option>
			<option value="제4전시실">제4전시실</option>
			<option value="제5전시실">제5전시실</option>
		</select>
		<h4>시대 선택</h4>
		<select name="era">
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
		<input type="submit" value="검색" />
		</form>
		
	</div>

	<div class="artifact">
		<%
		String query;
		request.setCharacterEncoding("utf-8");
		
		if ("0".equals(request.getParameter("location")) | request.getParameter("location") == null) {
			if ("0".equals(request.getParameter("era")) | request.getParameter("era") == null){
				query = "select * from artifact A left join description D on A.ArtifactID = D.HartifactID order by ArtifactID";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				out.println("<h3>박물관 내 모든 유물을 조회하였습니다.</h3>");
			}
			else {
				query = "select * from artifact A left join description D on A.ArtifactID = D.HartifactID where era = " + "'" + request.getParameter("era") + "' order by ArtifactID";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				out.println("<h3>박물관 내 유물 중 시대가 " + request.getParameter("era") + "인 유물을 조회했습니다.</h3>");
			}
		}
		else {
			if ("0".equals(request.getParameter("era")) | request.getParameter("era") == null) {
				query = "select * from artifact A left join description D on A.ArtifactID = D.HartifactID where location = " + "'" + request.getParameter("location") + "' order by ArtifactID";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				out.println("<h3>박물관 내 유물 중 위치가 " + request.getParameter("location") + "인 유물을 조회했습니다.</h3>");
			}
			else {
				query = "select * from artifact A left join description D on A.ArtifactID = D.HartifactID where location = " + "'" + request.getParameter("location") + "' and "
						+ "era = " + "'" + request.getParameter("era") + "' order by ArtifactID";
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				out.println("<h3>박물관 내 유물 중 위치가 " + request.getParameter("location") + "이고, 시대가 " + request.getParameter("era") + "인 유물을 조회했습니다.</h3>");
			}
		}
		
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		
		while (rs.next()) {
			out.println("<div class=\"element\">");
			out.println("<br>");
			out.println("<h4>" + rs.getString(2) + "</h4>");
			out.println("<p style=\"margin: 20px;\">유물 설명: " + rs.getString(11) + "</p>");
			out.println("<img src=\"Artifact_image/" + rs.getString(3) + ".png\" style=\"width:300px; margin-top:20px; margin-bottom:20px;\">");
			out.println("<p>* 유물 위치: " +  request.getParameter("location") + "</p>");
		    out.println("<p>* 유물 시대: " +  request.getParameter("era") + "</p>");
		    out.println("<br>");
			out.println("</div>");
		}
		
		rs.close();
		pstmt.close();
		%>
	</div>
</body>
</html>