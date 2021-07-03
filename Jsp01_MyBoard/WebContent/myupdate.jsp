<%@page import="com.my.biz.MyBoardBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.my.dao.MyBoardDao" %>
<%@ page import="com.my.dto.MyBoardDto" %>    

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here </title>
</head>
<body>

<%
	int myno = Integer.parseInt(request.getParameter("myno"));
	// request 객체에 키=밸류 형태로 값을 전달하면 string형태로 전달되기때문에 형변환했다. 
			
	MyBoardBiz biz = new MyBoardBiz();
	MyBoardDto dto = biz.selectOne(myno);
	// 웬만하면 biz통해서 dao를 가자
	// 스프링에선 biz에서 굉장히 많이 다루기때문에 biz에서 가자.

%>
	<h1>UPDATE</h1>
	<!-- ★ body에 담는 이유 -->
	<form action="myupdateres.jsp" method="post">
		<input type="hidden" name="myno" value="<%=dto.getMyno()%>"/>		<!-- 글번호가 안보이게 했다. -->
		<table border="1">
			<tr>
				<th>작성자</th>
				<td><%=dto.getMyname() %></td> <!-- 고정 -->
			</tr>
			<tr>
				<th>제목</th> <!-- 수정이 가능하게! -->
				<td><input type="text" name="mytitle" value="<%=dto.getMytitle()%>"></td>
			</tr>
			<tr>
				<th>내용</th> <!-- 수정이 가능하게! -->
				<td><textarea rows="10" cols="60" name="mycontent"> <%=dto.getMycontent()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정"/>
					<input type="button" value="취소" onclick="" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
<!--  
쿼리문
UPDATE MYBOARD
SET MYTITLE = ?, MYCONTENT = ?
WHERE MYNO = ?; 


코드 : 글 번호에 맞는걸 수정할건데, mytitle과 mycontent를 수정할거야
 -->