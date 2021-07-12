<%@page import="com.my.biz.MyBoardBiz"%>
<%@page import="com.my.dto.MyBoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
<!--  mvc1패턴으로 게시판을 만들기때문에 뷰가 컨트롤러 역할을 하고 있다.
	  mylist.jsp에서 biz 호출해서, biz에선 dao를 호출해서
	  dao에서 db랑 연결하는 값을 가져와서 dto에 담는걸 반복해서 list에 담고
	  biz로 리턴하면 biz는 화면으로 list를 리턴해준다.   -->
<% 
	MyBoardBiz biz = new MyBoardBiz();
	List<MyBoardDto> list = biz.selectList();
	
%>
	<h1>＼༼㊜ɷ㊜༽/  L I S T  ＼༼㊜ɷ㊜༽/</h1>

	<table border="1">
		<col width="50px"/>
		<col width="100px"/>
		<col width="500px"/>
		<col width="100px"/>
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>

<% 
	for (MyBoardDto dto : list) {
%>
	<tr>
		<td><%=dto.getMyno() %></td>
		<td><%=dto.getMyname() %></td>
		<td><a href="myselect.jsp?myno=<%=dto.getMyno()%>"><%=dto.getMytitle() %></a></td> 
		<!--  제목을 눌렀을 때 어디로 갈거야? myselect.jsp로 간다. myselect.jsp에서는 글 하나를 보기 위해 myno를 전달?★ -->
		<td><%=dto.getMydate() %></td>
	</tr>
<%	
	}
%>	
	<tr>
      <td colspan="4" align="right">
         <input type="button" value="글작성" onclick="location.href='myinsert.jsp'" />
	</td>
	</tr>
	</table>
</body>
</html>

<!--  

for (int i = 0; i < list.size(); i++) {
	
	<tr>
		<td></%=list.get(i).getMyno() %></td>
		<td></%=list.get(i).getMyname() %></td>
		<td><a href="#"></%=list.get(i).getMytitle() %></a></td>
		<td></%=list.get(i).getMydate() %></td>
	</tr>
	}
도 가능하다 !! ! ! ! 
 -->