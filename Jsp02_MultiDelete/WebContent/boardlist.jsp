<%@page import="com.muldel.dto.MDBoardDto"%>
<%@page import="java.util.List"%>
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

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

// F12를 확인해보면, chk에 글 번호마다 value값이 지정되어있는 것을 확인할 수 있다. 
// 선택삭제 기능
// 체크박스 전체 해제하고 선택삭제 버튼을 누르면, "하나 이상 체크해주세요"라는 창이 뜬다.

	$(function(){
		// .submit : submit 이벤트가 발생될 때, 실행 
		$("#muldelform").submit(function(){
			if($("#muldelform input:checked").length == 0) { // if는 유효성검사를 하고 있다. 
				alert("하나 이상 체크해주세요!");
				return false; // 전파도 막고, 기본 동작도 막는 것이 return false인데.. 
							 // 지금 기본 동작(submit)을 하고 있는건데, 뭐가 어떻게 될지 몰라서 다 막았다. 
			}
		});
	});
	
	// 이름이 all인 checkbox의 값을 가지고, 모든 chk의 checkbox 값들을 변경 (true/ false) 올체크, 올해지
	function allCheck(bool){
		var chks = document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			chk[i].checked = bool;
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

	<h1>♡LIST♡</h1>
	
	<form action="muldel.jsp" method="post" id="muldelform">
		<table border="1">
			<col width="30px"/>
			<col width="50px"/>
			<col width="100px"/>
			<col width="500px"/>
			<col width="100px"/>
			<tr>
				<th><input type="checkbox" name="all" onclick="allCheck(this.checked);"/></th>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
			
<%
	//향상된 for문
	for(MDBoardDto dto : list) {
		
%>			
	<tr>
		<th><input type="checkbox" name="chk" value="<%=dto.getSeq()%>"></th>
		<td><%=dto.getSeq() %></td>
		<td><%=dto.getWriter() %></td>
		<td><a href="boardselect.jsp?seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a></td>
				<!-- 번호를 기준으로 select할거여서 seq를 넘겨준다. where=?에 ?값에번호넣어주려고~ 
					왜 번호 기준이냐면, primary key(기본키)라서 안겹치게 하려고-->
		<td><%=dto.getRegdate() %></td>
		
	</tr>


<%

	}
%>			
			
			
			
			<tr>
				<td colspan="5" align="right">
					<input type="submit" value="선택삭제" >
					<input type="button" value="글작성" onclick="location.href='boardinsert.jsp'"/> <!-- insert페이지엔 보낼게 없다. 입력만 받을거니까 -->
				</td>	
			</tr>
		</table>
	
	</form>
	
	<%@ include file="./form/footer.jsp" %>
	<!-- footer.jsp파일이 boardlist.jsp에 종속(포함)돼서 meta태그가 보인다.(f12확인하면)
	include로 인해서..! 그래서 boardlist의 css들이 먹힌다. -->
</body>
</html>

<!--  
<상대경로?
/ : (root라고 부름) 최상위 디렉토리 
http://localhost:8787/jsp02_MultiDelete/boardlist.jsp
		톰캣		 여기 슬래시가 최상위      여기 슬래시는 contextroot

./ : 나와 같은 디렉토리, 나를 기준으로 상위 ,,,, 여기선 webcontent
../ : 상위 디렉토리


 -->