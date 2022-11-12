<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="openAPI.Location" %>
<%@ page import="openAPI.LocationRepository" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String LAT = request.getParameter("lat");
	String LNT = request.getParameter("lnt");
	
	System.out.println("LAT: " + LAT);
	System.out.println("LNT: " + LNT);
	
	LocationRepository locationRepository = LocationRepository.getInstance();
	
	locationRepository.insertLocation(LAT, LNT);
	
	response.sendRedirect("/main.jsp?lat=" + LAT + "&lnt=" + LNT);

%>