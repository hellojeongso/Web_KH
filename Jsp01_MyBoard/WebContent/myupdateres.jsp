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
<title>Insert title here</title>
</head>
<body>

<%
	// update에서 보낸 myno, mytitle, mycontent
	// res에서는 이전페이지에서 보내준 걸 받아줘야한다. 
	int myno = Integer.parseInt(request.getParameter("myno"));
	String mytitle = request.getParameter("mytitle");
	String mycontent = request.getParameter("mycontent");
	// biz 통해서-> dao 통해서 db랑 연결하고 -> db에 수정하기 위해서 받아왔다. 
	// 그러므로 Dto에 담아준다. 
	MyBoardDto dto = new MyBoardDto();
	dto.setMyno(myno);
	dto.setMytitle(mytitle);
	dto.setMycontent(mycontent);
	// MyBoardDto dto = new MyBoardDto(myno, null, mytitle, mycontent, null); 도 가능하다.
	// 위에는 세터를 사용했다. 
	
	MyBoardBiz biz = new MyBoardBiz();
	
	int res = biz.update(dto);
	
	if(res > 0) {
%>
		<script type="text/javascript">
			alert("글 수정 성공");
			location.href="myselect.jsp?myno=<%=myno%>";			
		</script>
<%
		} else {
%>
		<script type="text/javascript">
			alert("글 수정 실패");
			location.href="myupdate.jsp?myno=<%=myno%>";		
		</script>
<%
		}
%>

</body>
</html>