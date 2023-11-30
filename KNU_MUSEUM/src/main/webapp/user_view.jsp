<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <title>KNU_MUSEUM_DB</title>
    <link rel="stylesheet" type="text/css" href="css/admin_login.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

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

	request.setCharacterEncoding("utf-8");

	 String UserID = (String) session.getAttribute("UserID");
	%>
	
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
 <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="img/knu_museum_logo.jpg" alt="Logo" width="30" height="24" class="d-inline-block align-text-top">
    </a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="info.html">이용안내</a>
        </li>
         <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="artifact.html">소장유물</a>
        </li>
         <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="program.html">체험프로그램</a>
        </li>
      </ul>
      <span class="navbar-text">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="user_view.jsp">마이페이지</a>
        </li>
        </ul>
      </span>
    </div>
  </div>
</nav>
<br>
<ul class="nav nav-underline justify-content-center">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="#">신청내역조회</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="#">개인정보수정</a>
  </li>
</ul>
<div class="table-responsive">
	<p>--님의 체험 프로그램 신청내역</p>
  <table class="table align-middle">   
    <thead class="table-warning">
      <tr>
        <td>체험프로그램명</td>
        <td>날짜</td>
        <td>소요시간</td>
        <td>신청인원</td>
        <td>상태</td>
        <td>신청취소</td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>...</td>
        <td>...</td>
        <td>...</td>
        <td>...</td>
        <td>...</td>
        <td><button>취소</button></td>
      </tr>
    </tbody>
  </table>
</div>
<br>
<div class="table-responsive">
	<p>--님의 단체 관람 신청내역</p>
  <table class="table align-middle">   
    <thead class="table-warning">
      <tr>
        <td>체험프로그램명</td>
        <td>날짜</td>
        <td>소요시간</td>
        <td>신청인원</td>
        <td>상태</td>
        <td>신청취소</td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>...</td>
        <td>...</td>
        <td>...</td>
        <td>...</td>
        <td>...</td>
        <td><button>취소</button></td>
      </tr>
    </tbody>
  </table>
</div>

</body>
</html>