<%@page import="com.my.biz.MyBoardBiz"%>
<%@page import="com.my.dto.MyBoardDto"%>
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
	String myname = request.getParameter("myname");
	String mytitle = request.getParameter("mytitle");
	String mycontent = request.getParameter("mycontent");
	
	MyBoardDto dto = new MyBoardDto();
	dto.setMyname(myname);
	dto.setMytitle(mytitle);
	dto.setMycontent(mycontent);
	// MyBoartDto dto = new MyBoardDto(0, myname, mytitle, mycontent, null); 처럼 한번에 담을 수 있다. 
	
	MyBoardBiz biz = new MyBoardBiz();
	int res = biz.insert(dto);
	
	if (res > 0){
%>
	<script type="text/javascript">
		alert("글 작성 성공");
		location.href="mylist.jsp";			// 성공이라면 mylist로 가라. 
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		alert("글 작성 실패");
		location.href="myinsert.jsp";		// 실패라면 글 myinsert로 가라.
		//location.href="myinsert.jsp"; 대신 history.back();을 대신 써도 된다. 뭐하는 기능인지 알아볼 것 
	</script>
<%
	}
%>


	

%>

</body>
</html>