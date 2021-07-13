<%@page import="com.mvc.dto.MVCDto"%>
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
<%
	MVCDto dto = (MVCDto) request.getAttribute("dto");
	//mvcdto로 형변환한 dto(보낸거 받았다.)
%>
	<h1> UPDATE </h1>
	
	<form action="mvccontroller.jsp" method="post"> <!-- 보내줄 값이 많아서 post로 잡았다. -->
		<input type="hidden" name="command" value="updateres">
		<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
		<!-- 글번호 보내줘야하는데, update는 화면에 보여주지 않았으니까 hidden으로 잡는다. -->
		<table border="1">
			<tr>
				<th>작성자</th>
				<td><%=dto.getWriter() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" value="<%=dto.getTitle() %>" name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="content"><%=dto.getContent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="location.href='mvccontroller.jsp?command=select&seq=<%=dto.getSeq() %>'">
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>