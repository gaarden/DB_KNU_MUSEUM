<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<%@ page import="java.text.SimpleDateFormat,java.util.Date"%>
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
		
			<p>대기중인 단체관람 신청서
			</p>
			<table class="table align-middle">
				<thead class="table-warning">
					<tr>
						<td>신청 ID</td>
						<td>신청자 ID</td>
						<td>신청날짜</td>
						<td>신청시간</td>
						<td>신청인원</td>
						<td>관리자ID</td>
						<td>승인</td>
						<td>반려</td>
					</tr>
				</thead>
				<%
				String query = new String();
				PreparedStatement pstmt;
				ResultSet rs;
				query = "Select A.GroupTourID, A.CuserID, TO_CHAR(A.GAppDate, 'yyyy-mm-dd') AS AppDate, A.GAppTime, A.ApplyNum, A.CadminID ,Status From GROUP_TOUR_APPLICATION A order by AppDate desc";
						
				pstmt = conn.prepareStatement(query);
				rs = pstmt.executeQuery();
				out.println("<tbody>");

				while (rs.next()) {

					String applyDateStr = rs.getString(3);
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
					Date applyDate = dateFormat.parse(applyDateStr);
					Date currentDate = new Date();

					if (applyDate.after(currentDate)) {

						if (rs.getString(7).equals("2")) {
					out.println("<tr>");
					out.println("<td>" + (rs.getString(1) != null ? rs.getString(1) : "") + "</td>");
					out.println("<td>" + (rs.getString(2) != null ? rs.getString(2) : "") + "</td>");
					out.println("<td>" + (rs.getString(3) != null ? rs.getString(3) : "") + "</td>");
					out.println("<td>" + (rs.getString(4) != null ? rs.getString(4) : "") + "시</td>");
					out.println("<td>" + (rs.getString(5) != null ? rs.getString(5) : "") + "명</td>");
					out.println("<td>" + (rs.getString(6) != null ? rs.getString(6) : "") + "</td>");
					out.println("<td><button onclick='location.href=\"group_apply_o.jsp?GroupTourID=" + rs.getString(1)
							+ "\"'>승인</button></td>");
					out.println("<td><button onclick='location.href=\"group_apply_x.jsp?GroupTourID=" + rs.getString(1)
							+ "\"'>반려</button></td>");
					out.println("</tr>");
						}

					} else {

					}

				}
				%>
			</table>

			<p>처리 완료된 단체관람 신청서 리스트</p>
			<table class="table align-middle">
				<thead class="table-warning">
					<tr>
						<td>신청 ID</td>
						<td>신청자 ID</td>
						<td>신청날짜</td>
						<td>신청시간</td>
						<td>신청인원</td>
						<td>관리자ID</td>
						<td>상태</td>
					</tr>
				</thead>
				<%
				String query2 = new String();
				PreparedStatement pstmt2;
				ResultSet rs2;
				query2 = "Select A.GroupTourID, A.CuserID, TO_CHAR(A.GAppDate, 'yyyy-mm-dd') AS AppDate, A.GAppTime, A.ApplyNum, A.CadminID, Status From GROUP_TOUR_APPLICATION A Where A.Status IN ('0', '1') order by AppDate desc";
						
						//Select A.ApplyID, A.CeduID, L.Title, A.CuserID, TO_CHAR(A.MAppDate, 'yyyy-mm-dd') AS AppDate, A.MAppTime, A.ApplyNum, A.CadminID, A.Status From MUSEUM_PROGRAM_APPLICATION A LEFT JOIN MUSEUM_PROGRAM_LIST L ON L.EduID= A.CeduID Where A.Status IN ('0', '1','2') order by AppDate desc";
				pstmt2 = conn.prepareStatement(query2);
				rs2 = pstmt2.executeQuery();

				out.println("<tbody>");
				while (rs2.next()) {
					out.println("<tr>");
					out.println("<td>" + (rs2.getString(1) != null ? rs2.getString(1) : "") + "</td>");
					out.println("<td>" + (rs2.getString(2) != null ? rs2.getString(2) : "") + "</td>");
					out.println("<td style=\"width: 500px;\">" + (rs2.getString(3) != null ? rs2.getString(3) : "") + "</td>");
					out.println("<td>" + (rs2.getString(4) != null ? rs2.getString(4) : "") + "시</td>");
					out.println("<td>" + (rs2.getString(5) != null ? rs2.getString(5) : "") + "명</td>");
					out.println("<td>" + (rs2.getString(6) != null ? rs2.getString(6) : "") + "</td>");
					

					if (rs2.getString(7).equals("1")) {
						out.println("<td>승인</td>");
					} else if (rs2.getString(7).equals("0")) {
						out.println("<td>반려</td>");
					} else if (rs2.getString(7).equals("2")) {
						out.println("<td>대기</td>");
					}

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