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
<link rel="stylesheet" type="text/css" href="css/program.css">
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
	

	
	request.setCharacterEncoding("utf-8");
	int updateResult = 0;
	
	try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, pass);

        String UserID = (String) session.getAttribute("UserID");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String PNumber = request.getParameter("PNumber");

        String query = "UPDATE USERS SET Password = '"+password+"', Name = '"+ name + "' , Email = '"+email+ "' , PNumber = '"+PNumber+"' WHERE UserID = '"+UserID+"'";
        pstmt = conn.prepareStatement(query);
   

        updateResult = pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
	
	
	
	
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
                        <li class="nav-item"><a class="nav-link" href="user_view.jsp">My Page</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
                    </ul>
                </span>
        </div>
    </div>
</nav>


    <div class="box">
    <%
        if (updateResult > 0) {
    %>
    <p class="success-message">개인정보가 성공적으로 수정되었습니다.</p>
    <%
        } else {
    %>
    <p class="error-message">개인정보 수정에 실패했습니다. 다시 시도해주세요.</p>
    <%
        }
    %>
    <a href="user_view.jsp" style="color:#626A72">신청내역조회로 돌아가기</a>
</div>

</body>
</html>