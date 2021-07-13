<%@page import="com.muldel.biz.MDBoardBiz"%>
<%@page import="com.muldel.biz.MDBoardBizImpl"%>
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
	// 같은 이름으로 여러 개의 값이 올 경우
	String[] seqs = request.getParameterValues("chk");

	if (seqs == null || seqs.length == 0) {
		
%>
	<!-- 이 코드는 평소에는 실행되지 않는다. boradlist.jsp에 이미 이 기능을 하는 코드가 있기 때문.
		 그 코드에서 오류나 다른 이유로 걸러주지 못할 경우 여기서 걸러주기 위해 이 코드를 작성하였다.-->
	<script type="text/javascript">
		alert("삭제할 글을 하나 이상 체크해 주세요!");
		location.href="boardlist.jsp";
	</script>

<%
	} else {
		MDBoardBiz biz = new MDBoardBizImpl();
		int res = biz.multiDelete(seqs);
		if (res == seqs.length) {
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