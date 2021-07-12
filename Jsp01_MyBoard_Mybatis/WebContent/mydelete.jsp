<%@page import="com.my.biz.MyBoardBiz"%>
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
	// SELECT에서 MYDELETE로 MYNO를 보내줬다. 
	int myno = Integer.parseInt(request.getParameter("myno"));

	MyBoardBiz biz = new MyBoardBiz();
	int res = biz.delete(myno);
	// 비즈를 통해서 myno를 딜리트할거다
	
	if(res>0) {
%>	
	<script type="text/javascript">
		alert("글 삭제 성공");
		location.href="mylist.jsp";
	</script>	
<% 
	} else {
%>	

	<script type="text/javascript">
		alert("글 삭제 실패");
		location.href="myselect.jsp?myno=<%=myno%>"; // 다시 해당 글로 간다. 
	</script>
	
<%
	}
%>
	

</body>
</html>