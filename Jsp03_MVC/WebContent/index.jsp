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


	<jsp:forward page="mvccontroller.jsp?command=list"></jsp:forward>
								<!-- command=list라고 요청했다.
									어디로 가고싶다고 변수에 담아서 요청한거고,
									굳이 command라고 적지 않고 다른 변수 써도 된다. (abc도 가능) -->


</body>
</html>