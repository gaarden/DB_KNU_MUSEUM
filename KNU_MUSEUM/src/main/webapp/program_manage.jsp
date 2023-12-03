<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/admin_artifact.css">

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
	
	<div class="table-responsive">
		<p><%=AdminID %>님이 담당하는 체험 프로그램</p>
		<table class="table align-middle">
			<thead class="table-warning">
				<tr>
					<td>프로그램 ID</td>
					<td>프로그램 이름</td>
					<td>시작 날짜</td>
					<td>종료 날짜</td>
					<td>소요 시간</td>
					<td>프로그램 정원</td>
					<td>관리자ID</td>
					<td></td>
					<td></td>
				</tr>
			</thead>
			<%
			String query = new String();
			PreparedStatement pstmt;
			ResultSet rs;
			query = "Select EduID, Title, TO_CHAR(StartDate, 'yyyy-mm-dd') AS StartDate, TO_CHAR(EndDate, 'yyyy-mm-dd') AS EndDate, PTime, LimitNum, MadminID From MUSEUM_PROGRAM_LIST where MadminID='"+AdminID+"' order by StartDate desc";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			out.println("<tbody>");
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + (rs.getString(1) != null ? rs.getString(1) : "") + "</td>");
				out.println("<td>" + (rs.getString(2) != null ? rs.getString(2) : "") + "</td>");
				out.println("<td>" + (rs.getString(3) != null ? rs.getString(3) : "") + "</td>");
				out.println("<td>" + (rs.getString(4) != null ? rs.getString(4) : "") + "</td>");
				out.println("<td>" + (rs.getString(5) != null ? rs.getString(5) : "") + "</td>");
				out.println("<td>" + (rs.getString(6) != null ? rs.getString(6) : "") + "</td>");
				out.println("<td>" + (rs.getString(7) != null ? rs.getString(7) : "") + "</td>");
				out.println("<td><button onclick='location.href=\"program_edit.jsp?EduID=" + rs.getString(1) + "\"'>편집</button></td>");
                out.println("<td><button onclick='location.href=\"program_delete.jsp?EduID=" + rs.getString(1) + "\"'>삭제</button></td>");		
				out.println("</tr>");
			}
			%>
		</table>
		<br>
		<p>전체 체험 프로그램 리스트</p>
		<table class="table align-middle">
			<thead class="table-warning">
				<tr>
					<td>프로그램 ID</td>
					<td>프로그램 이름</td>
					<td>시작 날짜</td>
					<td>종료 날짜</td>
					<td>소요 시간</td>
					<td>프로그램 정원</td>
					<td>관리자ID</td>
				
				</tr>
			</thead>
			<%
			String query2 = new String();
			PreparedStatement pstmt2;
			ResultSet rs2;
			query2 = "Select EduID, Title, TO_CHAR(StartDate, 'yyyy-mm-dd') AS StartDate, TO_CHAR(EndDate, 'yyyy-mm-dd') AS EndDate, PTime, LimitNum, MadminID From MUSEUM_PROGRAM_LIST order by StartDate desc";
			pstmt2 = conn.prepareStatement(query2);
			rs2 = pstmt2.executeQuery();
			out.println("<tbody>");
			while (rs2.next()) {
				out.println("<tr>");
				out.println("<td>" + (rs2.getString(1) != null ? rs2.getString(1) : "") + "</td>");
				out.println("<td style=\"width: 500px;\">" + (rs2.getString(2) != null ? rs2.getString(2) : "") + "</td>");
				out.println("<td>" + (rs2.getString(3) != null ? rs2.getString(3) : "") + "</td>");
				out.println("<td>" + (rs2.getString(4) != null ? rs2.getString(4) : "") + "</td>");
				out.println("<td>" + (rs2.getString(5) != null ? rs2.getString(5) : "") + "</td>");
				out.println("<td>" + (rs2.getString(6) != null ? rs2.getString(6) : "") + "</td>");
				out.println("<td>" + (rs2.getString(7) != null ? rs2.getString(7) : "") + "</td>");
			
				out.println("</tr>");
			}
			%>
		</table>
		
	</div>
	<br>
	<%
	rs.close();
	pstmt.close();
	
	rs2.close();
	pstmt2.close();
	conn.close();
	%>
	


</body>
</html>