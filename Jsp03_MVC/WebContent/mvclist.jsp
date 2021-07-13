<%@page import="com.mvc.dto.MVCDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 원래 list에서 biz 만들어서 selectlist를 가져와가지고~~뭐 이렇게 했었는데 
	그렇게 안하고, 컨트롤러에서 전달해준 것을 받을거다.-->

<%
	List<MVCDto> list = (List<MVCDto>) request.getAttribute("list"); // 노란줄 뜨는거 정상
	// controller에서 전달 받은 request.getAttribute("list", list)를 형변환시켰다.  
%>
	<h1>LIST</h1>
	
		<table border="1">
			<col width="50x">
			<col width="100px">
			<col width="500px">
			<col width="100px">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
<%
	for (MVCDto dto : list){
%>
		

			<tr>
				<td><%=dto.getSeq() %></td>
				<td><%=dto.getWriter() %></td>
				<td><a href="mvccontroller.jsp?command=detail&seq=<%=dto.getSeq()%>"><%=dto.getTitle() %></a></td>
				<td><%=dto.getRegdate() %></td>
			</tr>
<%
		}

%>
			<tr>
				<td colspan="4" align="right"><input type="button" value="글작성" onclick="location.href='mvccontroller.jsp?command=insertform'"></td>
																							<!-- 글작성 : controller에게 insert 페이지를 요청했다. -->
			</tr>
		</table>

</body>
</html>