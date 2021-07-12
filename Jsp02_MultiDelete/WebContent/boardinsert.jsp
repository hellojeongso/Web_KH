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
	<!--  include로 포함시킨 페이지가 기준경로  -->
	<%@ include file="./form/header.jsp" %>
	
	<form action="./boardinsertres.jsp" method="post">
		<table border="1">
			<tr>
				<th>작성자</th>
				<td><input type="text" name="writer"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="저장">
					<input type="button" value="취소" onclick="location.href='./boardlist.jsp'">
				</td>
			</tr>
		</table>
	</form>
	
	<%@ include file="./form/footer.jsp" %>

</body>
</html>