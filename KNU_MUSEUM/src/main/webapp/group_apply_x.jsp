<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*,java.util.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNU_MUSEUM</title>
<link rel="stylesheet" type="text/css" href="css/program.css">
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
						<li class="nav-item"><%=AdminID%>님이 관리중입니다.</li>
						<li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
					</ul>
				</span>
			</div>
		</div>
	</nav>
	
	
	<% 
        String GroupTourID = request.getParameter("GroupTourID");
     
	String query = "UPDATE GROUP_TOUR_APPLICATION SET Status = '0' WHERE GroupTourID = ?";
	PreparedStatement pstmt = null;

	try {
	    pstmt = conn.prepareStatement(query);
	    pstmt.setString(1, GroupTourID);

	    // executeUpdate 메서드를 사용하여 업데이트된 행 수를 반환
	    int rowsUpdated = pstmt.executeUpdate();

	    out.println("<div class=\"box\">");
	    if (rowsUpdated > 0) {
	        out.println("업데이트 성공");
	    } else {
	        out.println("업데이트된 행이 없음");
	    }
	    out.println("<a href=\"group_apply_manage.jsp\" style=\"color:#626A72\">관리 페이지로 돌아가기</a>");
	    out.println("</div>");
	} catch (SQLException e) {
	    e.printStackTrace();
	} finally {
	    // 리소스 해제
	    try {
	        if (pstmt != null) {
	            pstmt.close();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
    %>
    
</body>
</html>