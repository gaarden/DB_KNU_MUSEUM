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
	String user = "KNU_MUSEUM";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	String query = new String();
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
%>
<%
//TEST1
	out.println("<table border=\"1\">");
	
	query = "SELECT * FROM MUSEUM_PROGRAM_APPLICATION WHERE Status = 1";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getInt(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getInt(4) + "</td>");
		out.println("<td>" + rs.getInt(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
		out.println("<td>" + rs.getString(7) + "</td>");
		out.println("<td>" + rs.getString(8) + "</td>");
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