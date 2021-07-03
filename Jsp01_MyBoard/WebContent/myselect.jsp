<%@page import="com.my.dto.MyBoardDto"%>
<%@page import="com.my.biz.MyBoardBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  해당 번호에 맞는 값 하나를 가져왔다. -->
<%

	int myno = Integer.parseInt(request.getParameter("myno"));
	// mylist에서 링크를 눌러서 myselect로 넘어오게되면, request 객체에 담겨서 전달되는데 여기에 전달되는 값들은 모두 string으로 전달된다. 
	// 그래서 다시 숫자로 형변환을 해줘야한다.
	
	MyBoardBiz biz = new MyBoardBiz();
	MyBoardDto dto = biz.selectOne(myno);
	// mylist.jsp에서 biz를 호출하고, biz에서는 dao를 호출해서 
	// dao와 db랑 연결해서 값을 가져와서 dto에 담는걸 반복해서 list로 담고 
	// biz로 리턴하면 biz는 화면으로 list를 리턴해준다.
	
	// 이것은 db에서 값을 가져오는 과정이다. 

%>


	<h1>DETAIL</h1>
	
	<table border="1">
		<tr>
			<th>작성자</th> 
			<td><%=dto.getMyname() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=dto.getMytitle() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="60" readonly="readonly"><%=dto.getMycontent() %></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" value="수정" onclick="location.href='myupdate.jsp?myno=<%=dto.getMyno()%>'"/>
				<!-- selectOne랑 차이가 별로 없다.. get방식으로 보내는거고, ?키=밸류 형식이다.  myupdate.jsp로 갈 때 가져가야할 값이 있다. 그것은 myno 번호 기준으로 수정할 데이터!-->
				<input type="button" value="삭제" onclick="location.href='mydelete.jsp?myno=<%=dto.getMyno()%>'"/>
				<input type="button" value="목록" onclick=""/>
			</td>
		</tr>		
	</table>
</body>
</html>