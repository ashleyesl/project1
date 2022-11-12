<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="openAPI.Location" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>위치 히스토리 목록</h1>
		<a href="./main.jsp">홈</a> |
		<a href="./history.jsp">위치 히스토리 목록</a> |
		<a href="./load-wifi.jsp">Open API 와이파이 정보 가져오기</a>
		
		<br>
		<br>
		
		<style>
			table {
				border-collapse: collapse;
				width: 100%;
			}
			th, td {
				border: 1px solid lightgray;
				padding: 8px;
			}
			
			th {
				background-color: lightgreen;
				text-color: white;
				text-align: center;
			}
			td {
				text-align: left;
				
			}
			tr:nth-child(odd) {
				background-color: #ddd;
			}
		
			
		</style>
		<table>
		<tr>
			<th style="width:5%">ID</th>
			<th style="width:25%">X좌표</th>
			<th style="width:25%">Y좌표</th>
			<th style="width:35%">조회일자</th>
			<th style="width:10%">비고</th>
		</tr>
		
		<%
		ArrayList<Location> locationList = new ArrayList<Location>();
		
		if(session.getAttribute("Location") != null) {
			System.out.println("널 아님");
			locationList = (ArrayList<Location>) session.getAttribute("Location"); //session에서 object로 저장됨
			
			for (Location l : locationList) {
	%>
		<tr>
		    <td><%=l.getId() %></td>
		    <td><%=l.getLat() %></td>
		    <td><%=l.getLnt() %></td>
		    <td><%=l.getSearchDate() %></td>
		    
		    
		    <td><button>삭제</button></td>
	    </tr>
	    
	    <%		
			}
				}
			else {
	
	%>
	<tr>
		<td colspan="5"></td>
	</tr>
	<%
		}
			
	%>	    
		
		
	</table>
	
	
	
</body>
</html>