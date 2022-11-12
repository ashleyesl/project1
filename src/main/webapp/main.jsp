<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="openAPI.WIFI" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script>
		function getLocation() {
			if (navigator.geolocation) { // GPS를 지원하면
				navigator.geolocation.getCurrentPosition(function(position) {
					/* alert(position.coords.latitude + ' ' + position.coords.longitude); */

					lat = position.coords.latitude;
					lnt = position.coords.longitude;

					console.log(lat);
					console.log(lnt);

					console.log("/process-location.jsp?lat=" + lat 
							+ "&lnt=" + lnt);

					location.href = "/process-location.jsp?lat=" + lat
							+ "&lnt=" + lnt; // 페이지 이동
							
					document.getElementById("lat").value = lat;
					document.getElementById("lnt").value = lnt;
				}, function(error) {
					console.error(error);
				}, {
					enableHighAccuracy : false,
					maximumAge : 0,
					timeout : Infinity
				});
			} else {
				alert('GPS를 지원하지 않습니다');
			}
		}

		function setLocation(lat, lnt) {

			console.log(lat);
			console.log(lnt);

			document.getElementById("lat").value = lat;
			document.getElementById("lnt").value = lnt;

		}

		/* getLocation(); */
	</script>


	<h1>와이파이 정보 구하기</h1>
	<a href="./main.jsp">홈</a> |
	<a href="./process-history.jsp">위치 히스토리 목록</a> |
	<a href="./process-getWIFI.jsp">Open API 와이파이 정보 가져오기</a>
	<br>
	<br>

	<form action="./process-main.jsp" method="post" name="search">
		LAT: <input type="text" name="lat" id="lat" />, 
		LNT: <input type="text" name="lnt" id="lnt" />
		<input type="button" onclick="getLocation();" value="내 위치 가져오기" /> 
		<input type="submit" value="근처 WIFI 정보 보기" />
	</form>


	<%
	String lat = request.getParameter("lat");
	String lnt = request.getParameter("lnt");
	System.out.println(lat + "!!!!!!!!!!!!!!!");

	if (lat == null || "null".equals(lat)) {
	%>
	<script>
		setLocation("0.0", "0.0");
	</script>
	<%
	} else {
	%>
	<script>
		setLocation(
	<%=lat%>
		,
	<%=lnt%>
		);
	</script>
	<%
	}
	%>


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


	<table border="1">
		<tr>
			<th>거리(Km)</th>
			<th>관리번호</th>
			<th>자치구</th>
			<th>와이파이명</th>
			<th>도로명주소</th>
			<th>상세주소</th>
			<th>설치위치(층)</th>
			<th>설치유형</th>
			<th>설치기관</th>
			<th>서비스구분</th>
			<th>망종류</th>
			<th>설치년도</th>
			<th>실내외구분</th>
			<th>WIFI접속환경</th>
			<th>X좌표</th>
			<th>Y좌표</th>
			<th>작업일자</th>
		</tr>
		
		
			<%
		ArrayList<WIFI> wifi = new ArrayList<WIFI>();
		
		if(session.getAttribute("WIFI") != null) {
			System.out.println("널 아님");
			wifi = (ArrayList<WIFI>) session.getAttribute("WIFI");
			
			for (WIFI w : wifi) {
	%>
	
		<tr>
		    <td><%=w.getDISTANCE() %></td>
		    <td><%=w.getMGR_NO() %></td>
		    <td><%=w.getWRDOFC() %></td>
		    <td><%=w.getMAIN_NM() %></td>
		    <td><%=w.getADRES1() %></td>
		    <td><%=w.getADRES2() %></td>
		    <td><%=w.getINSTL_FLOOR() %></td>
		    <td><%=w.getINSTL_TY() %></td>
		    <td><%=w.getINSTL_MBY() %></td>
		    <td><%=w.getSVC_SE() %></td>
		    <td><%=w.getCMCWR() %></td>
		    <td><%=w.getCNSTC_YEAR() %></td>
		    <td><%=w.getINOUT_DOOR() %></td>
		    <td><%=w.getREMARS3() %></td>
		    <td><%=w.getLAT() %></td>
		    <td><%=w.getLNT() %></td>
		    <td><%=w.getWORK_DTTM() %></td>
		</tr>
		
	<%		
			}
				}
			else {
	
	%>
	<tr>
		<td colspan="17" style="text-align: center;">위치 정보를 입력한 후에 조회해 주세요.</td>
	</tr>
	<%
		}
			
	%>
	
	</table>


</body>
</html>