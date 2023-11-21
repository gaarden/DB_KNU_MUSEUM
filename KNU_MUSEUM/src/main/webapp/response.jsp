<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>COMP322: Introduction to Databases</title>
</head>
<body>
<% 
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "Company";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	String query = new String();
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
%>

<h2>Lab #9: Repeating Lab #5-3 via JSP</h2>
<h4>------ Q1 Result --------</h4>

<%
//Q1
	query = "Select E.Fname, E.Lname, E.Salary from Employee E, Project P, Works_on W"
			+ " Where P.Pnumber = W.Pno and W.Essn = E.Ssn and P.Pname LIKE '"+ request.getParameter("Project1") 
			+ "' and E.Dno = " + request.getParameter("Dnum") + " and E.Salary >= " + request.getParameter("Salary");
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getFloat(3) + "</td>");
		out.println("</tr>");		
	}
	out.println("</table>");
%>
<h4>------ Q2 Result --------</h4>
<%
//Q2
	query = "Select D.Dname, E.Ssn, E.Fname, E.Lname from Employee E, Department D " +
 			"Where E.Dno = D.Dnumber and E.Super_ssn = '" + request.getParameter("SSN1") +"' and E.Address LIKE '%" + request.getParameter("address") +"%'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("</tr>");		
	}
	out.println("</table>");
%>
<h4>------ Q3 Result --------</h4>
<%
//Q3
	query = "Select E.Fname, E.Lname, W.Hours from Employee E, Project P, Works_on W " +
 			"Where E.Ssn = W.Essn and P.Pnumber = W.Pno and P.Pname = '" + request.getParameter("Project3") +"' and W.Hours >=" + request.getParameter("hour3");
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getInt(3) + "</td>");
		out.println("</tr>");		
	}
	out.println("</table>");
%>
<h4>------ Q4 Result --------</h4>
<%
//Q4
	query = "Select DISTINCT D.Dname, E.Fname, E.Lname from Employee E, Project P, Works_on W, Department D " +
 			"Where E.Ssn = W.Essn and P.Pnumber = W.Pno and P.Dnum = D.Dnumber and P.Pname LIKE '%" + request.getParameter("Project4") +"%' and W.Hours >=" + request.getParameter("hour4");
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("</tr>");		
	}
	out.println("</table>");
%>
<h4>------ Q5 Result --------</h4>
<%
//Q5
	query = "Select D.Dname, E.Lname, E.Fname, DE.Dependent_name from Dependent DE, Employee E, Department D " +
 			"Where E.Dno = D.Dnumber and E.Ssn = DE.Essn and DE.Relationship = 'Spouse' and E.Super_ssn = " + request.getParameter("SSN5");
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("</tr>");		
	}
	out.println("</table>");
%>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>
</body>
</html>