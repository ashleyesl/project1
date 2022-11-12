<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="openAPI.WIFI" %>
<html>
<head>
<title></title>
</head>
<body>
	<%-- <%@ include file="/dbconn.jsp" %> --%>
	<%
	
		request.setCharacterEncoding("utf-8");
	
		double lat = Double.parseDouble(request.getParameter("lat"));
		double lnt = Double.parseDouble(request.getParameter("lnt"));
		
		String url = "jdbc:mariadb://192.168.64.2:3306/wifi_db";
		String user = "wifi_user";
		String pass = "zerobase";
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
		
        connection = DriverManager.getConnection(url, user, pass);
        
        ArrayList<WIFI> wifi = new ArrayList<WIFI>();
        
		try{
			String sql = "SELECT *, (6371*ACOS(COS(RADIANS(" + lat + "))*COS(RADIANS(LAT))"
					+ "*COS(RADIANS(LNT)-RADIANS(" + lnt + "))"
					+ "+SIN(RADIANS(" + lat + "))*SIN(RADIANS(LAT)))) AS DISTANCE "
					+ "FROM wifi_info ORDER BY DISTANCE LIMIT 20";
			preparedStatement = connection.prepareStatement(sql);
			rs = preparedStatement.executeQuery();
			
			
			
			while(rs.next()){
				
				WIFI w = new WIFI();
				
				w.setWRDOFC(rs.getString(1));
				w.setSVC_SE(rs.getString(2));
				w.setREMARS3(rs.getString(3));
				w.setMGR_NO(rs.getString(4));
				w.setMAIN_NM(rs.getString(5));
				w.setINSTL_TY(rs.getString(6));
				w.setINSTL_MBY(rs.getString(7));
				w.setINSTL_FLOOR(rs.getString(8));
				w.setINOUT_DOOR(rs.getString(9));
				w.setCNSTC_YEAR(rs.getString(10));
				w.setCMCWR(rs.getString(11));
				w.setADRES2(rs.getString(12));
				w.setADRES1(rs.getString(13));
				w.setWORK_DTTM(rs.getString(14));
				w.setLNT(rs.getDouble(15));
				w.setLAT(rs.getDouble(16));
				w.setDISTANCE(rs.getDouble(17));
				
				
/* 				System.out.println(w.getLAT());
				System.out.println(w.getLNT());
				System.out.println(w.getMGR_NO());
				System.out.println(w.getDISTANCE()); */
				
				wifi.add(w);
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
		
		session.setAttribute("WIFI", wifi);
		
		response.sendRedirect("/main.jsp?lat=" + lat + "&lnt=" + lnt);
	%>
</body>
</html>