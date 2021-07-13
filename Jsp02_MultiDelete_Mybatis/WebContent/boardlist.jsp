<%@page import="com.muldel.biz.MDBoardBizImpl"%>
<%@page import="com.muldel.dto.MDBoardDto"%>
<%@page import="java.util.List"%>
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

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	
	// muldel.jsp에도 비슷한(거의 똑같은) 기능을 하는 코드가 있다.
	// 이 코드는 클라이언트이고, muldel.jsp의 "삭제할 글을 하나 이상 체크해주세요" 이 부분은 서버이다.
	// 그래서 이 코드만 화면에 뜨는 것이고, 만일 오류나 다른 이유로 여기서 걸러주지 못할 경우 muldel.jsp에서 걸러준다.
	$(function(){
		// .submit : submit 이벤트가 발생될 때, 실행
		$("#muldelform").submit(function(){
			if($("#muldelform input:checked").length == 0) {
				alert("하나 이상 체크해주세요!");
				return false;	// 전파도 막고 기본동작도 막는 역할
			}
		});
	});
	
	// 이름이 all인 checkbox의 값을 가지고, 모든 chk의 checkbox 값들을 변경! (true / false)
	function allCheck(bool) {
		var chks = document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked = bool;
		}
	}

</script>

</head>
<body>

<%
	MDBoardBiz biz = new MDBoardBizImpl();
	List<MDBoardDto> list = biz.selectList();
%>

	<%@ include file="./form/header.jsp" %>

	<h1>LIST</h1>
	
	<form action="muldel.jsp" method="post" id="muldelform">
		<table border="1">
			<col width="30px" />
			<col width="50px" />
			<col width="100px" />
			<col width="500px" />
			<col width="100px" />
			<tr>
				<th><input type="checkbox" name="all" onclick="allCheck(this.checked);"/></th>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>

<%
			for (MDBoardDto dto : list) {
%>			
			
			<tr>
				<th><input type="checkbox" name="chk" value="<%=dto.getSeq()%>"></th>
				<td><%=dto.getSeq() %></td>
				<td><%=dto.getWriter() %></td>
				<td><a href="boardselect.jsp?seq=<%=dto.getSeq()%>"><%=dto.getTitle() %></a></td>
				<td><%=dto.getRegdate() %></td>
			</tr>
			
<%
			}
%>
			
			<tr>
				<td colspan="5" align="right">
					<input type="submit" value="선택삭제">
					<input type="button" value="글작성" onclick="location.href='boardinsert.jsp'" />
				</td>
			</tr>
		</table>
	</form>

	<%@ include file="./form/footer.jsp" %>

</body>
</html>