<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="/Jsp01_MyBoard/se2/smarteditor2/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>







</head>
<body>

	<h1> INSERT </h1>
	
	<form action="myinsertres.jsp" method="post">
		<table border="1">
			<tr>
				<th>작성자</th>
				<td><input type="text" name="myname" style="color:pink;"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="mytitle" style="color:pink;"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<textarea name="weditor" id="weditor" rows="10" cols="100" ></textarea>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="submit" value="작성"/>
				<input type="button" value="취소" onclick="" />
				</td>
			</tr>
		</table>
	</form>
<script type="text/javascript">
alert("??")
var oEditors = [];
alert("!!")
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "weditor",
    sSkinURI: "/Jsp01_MyBoard/se2/smarteditor2/dist/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});

</script>
</body>
</html>
<!--  값을 다음페이지에 전달하려고 보니까 작성자, 제목, 내용이 name이라고 적혀있다. 이건 form으로 전달해줘야한다!  -->