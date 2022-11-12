<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="openAPI.Location" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<% 
	
	ArrayList<Location> locationList = new ArrayList<Location>();
	
	String sql_url = "jdbc:mariadb://192.168.64.2:3306/wifi_db";
	String dbUserId = "wifi_user";
	String dbPassword = "zerobase";
	
	Class.forName("org.mariadb.jdbc.Driver");

	Connection connection = null; //데이터베이스 연결 유지해주는 객체
	PreparedStatement preparedStatement = null; //sql문작성을위해서 (ex. using ?) , sql문의 상태
	ResultSet rs = null; //반환되는값을 저장해주는 객체

	connection = DriverManager.getConnection(sql_url, dbUserId, dbPassword);

	try{
		String query = " select * from history; ";
		
		preparedStatement = connection.prepareStatement(query);
		rs = preparedStatement.executeQuery();
		
		while (rs.next()) {
			Location l = new Location();
			l.setId(rs.getInt(1));
			l.setLat(rs.getString(2));
			l.setLnt(rs.getString(3));
			l.setSearchDate(rs.getString(4));
			
			
			locationList.add(l);
		}
	} catch (SQLException ex){
		System.out.println("Update 실패<br>");
		System.out.println("Error: " + ex.getMessage());
	} finally{
		if(preparedStatement != null)
			preparedStatement.close();
		if(connection != null)
			connection.close();
	}
	

	session.setAttribute("Location", locationList);
	
	response.sendRedirect("/history.jsp");
	
	
	%>
		



</body>
</html>


