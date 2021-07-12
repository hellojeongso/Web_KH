<%@page import="com.muldel.biz.MDBoardBizImpl"%>
<%@page import="com.muldel.biz.MDBoardBiz"%>
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

	/* 만일 4개의 게시글이 있다면, 1번과 2번 4번 게시글을 선택삭제 할 경우  
		localhost:8787/Jsp02_MultiDelete/muldel.jsp?chk=4&chk=2&chk=1 로 넘어가게 된다. (NAME=KEY, VALUE=VALUE) 키 밸류 키 밸류,,
		
		그동안 코드를 사용할 때, getParameter로 받았는데 여러개의 값은 배열로 받아야한다. 
	*/
	
	// 같은 이름으로 여러개의 값이 올 경우, chk는 체크박스의 name
	String[] seqs = request.getParameterValues("chk");

	if(seqs == null || seqs.length == 0){ //만일 seqs 아무 값이 없거나, seqs의 길이가 0이라면
%>
	<script type="text/javascript">
		alert("삭제할 글을 하나 이상 체크해 주세요!");
		location.href="boardlist.jsp";
	</script>
	
<%
	} else {
		MDBoardBiz biz = new MDBoardBizImpl();
		int res = biz.multiDelete(seqs);
		if (res == seqs.length) {   // 내가 삭제 요청한 갯수와 삭제된 갯수가 같다면
%>
		<script type="text/javascript">
			alert("선택된 글들이 모두 삭제되었습니다.");
			location.href="boardlist.jsp";
		</script>

<%
		} else {
%>
	
		<script type="text/javascript">
			alert("선택된 글들이 삭제되지 않았습니다.");
			location.href="boardlist.jsp";
		</script>

<%
		}
	}
%>




</body>
</html>