<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="openAPI.Location" %>
<%@ page import="openAPI.ApiExplorer" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	ApiExplorer m = ApiExplorer.getInstance();
	
	int num = m.getLocation();
	
	response.sendRedirect("/load-wifi.jsp?num=" + num);

%>