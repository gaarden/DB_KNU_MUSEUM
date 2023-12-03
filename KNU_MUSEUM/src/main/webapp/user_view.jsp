<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.*, java.sql.*"%>
<%@ page import="common.Person"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KNU_MUSEUM_DB</title>
    <link rel="stylesheet" type="text/css" href="css/user_view.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
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
    //+"?useUnicode=true&characterEncoding=UTF-8"

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs;
    Statement stmt = null;

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
                        <li class="nav-item"><a class="nav-link" href="user_view.jsp">My Page</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="main.html">로그아웃</a></li>
                    </ul>
                </span>
        </div>
    </div>
</nav>
<br>
<ul class="nav nav-underline justify-content-center">
    <li class="nav-item"><a class="nav-link active"
                            aria-current="page" href="user_view.jsp">신청내역조회</a></li>
    <li class="nav-item"><a class="nav-link active"
                            aria-current="page" href="user_modify_info.jsp">개인정보수정</a></li>
</ul>
<form action="cancel_apply.jsp" method="Post">
    <div class="table-responsive">
        <p><%=UserID%>님의 체험 프로그램 신청내역
        </p>

        <%
            stmt = conn.createStatement();
            String sql1 = "SELECT ML.Title, TO_CHAR(MA.MAppDate, 'YYYY-MM-DD'), MA.MAppTime, MA.ApplyNum, MA.Status, MA.ApplyID "
                    + "FROM MUSEUM_PROGRAM_LIST ML, MUSEUM_PROGRAM_APPLICATION MA " + "WHERE MA.CuserID='" + UserID + "' "
                    + "AND MA.CeduID = ML.EduID order by TO_CHAR(MA.MAppDate, 'YYYY-MM-DD') desc";
            rs = stmt.executeQuery(sql1);
        %>

        <table class="table align-middle">
            <thead class="table-warning">
            <tr>
                <td>체험프로그램명</td>
                <td>날짜</td>
                <td>시작시간</td>
                <td>신청인원</td>
                <td>상태</td>
                <td>신청취소</td>
            </tr>
            </thead>
            <tbody>
            <%
                LocalDate currentDate = LocalDate.now();
                if (!rs.next()) {
            %>
            <tr>
                <td colspan="6" align="center">신청 내역이 없습니다.</td>
            </tr>
            <%
                } else {
                    do {
                        LocalDate appDate = LocalDate.parse(rs.getString(2));
            %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%>시</td>
                <td><%=rs.getString(4)%>명</td>
                <td>
                    <%
                        if (rs.getString(5).equals("0")) {
                            out.println("대기");
                        } else {
                            out.println("승인");
                        }
                    %>
                </td>
                <td>
                    <%
                        // Compare the application date with the current date
                        if (appDate.isAfter(currentDate)) {
                    %>
                    <button name="cancelID" value="<%=rs.getString(6)%>">취소</button>
                    </td>
            </tr>
            <%
                }
                    } while (rs.next());
                    rs.close();
                    stmt.close();
                }
            %>
            </tbody>
        </table>
    </div>
    <br>
    <div class="table-responsive">
        <p><%=UserID%>님의 단체 관람 신청내역
        </p>

        <%
            stmt = conn.createStatement();
            String sql2 = "SELECT TO_CHAR(GAppDate, 'YYYY-MM-DD'), GAppTime, ApplyNum, Status, GroupTourID "
                    + "FROM GROUP_TOUR_APPLICATION " + "WHERE CuserID='" + UserID + "' order by GAppDate desc";
            rs = stmt.executeQuery(sql2);
        %>


        <table class="table align-middle">
            <thead class="table-warning">
            <tr>
                <td>날짜</td>
                <td>시작시간</td>
                <td>신청인원</td>
                <td>상태</td>
                <td>신청취소</td>
            </tr>
            </thead>
            <tbody>
            <%
                if (!rs.next()) {
            %>
            <tr>
                <td colspan="6" align="center">신청 내역이 없습니다.</td>
            </tr>
            <%
                } else {
                    do {
                        LocalDate appDate = LocalDate.parse(rs.getString(1));
            %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%>시</td>
                <td><%=rs.getString(3)%>명</td>
                <td>
                    <%
                        if (rs.getString(4).equals("0")) {
                            out.println("대기");
                        } else {
                            out.println("승인");
                        }
                    %>
                </td>
                <td>
                    <%
                        // Compare the application date with the current date
                        if (appDate.isAfter(currentDate)) {
                    %>
                    <button name="cancelID" value="<%=rs.getString(5)%>">취소</button>
                    </td>
            </tr>
            <%
                }
                    } while (rs.next());
                    rs.close();
                    stmt.close();
                }
            %>
            </tbody>
        </table>
    </div>
</form>

</body>
</html>
