
<%@page import="com.mvc.dao.MVCDaoImpl"%>
<%@page import="com.mvc.dao.MVCDao"%>
<%@page import="com.mvc.dto.MVCDto"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.biz.MVCBizImpl"%>
<%@page import="com.mvc.biz.MVCBiz"%>
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
<!-- controller : 요청된 화면을 응답시켜준다. 화면 제어
	컨트롤러에서는 4가지의 순서를 따라야한다. 서블릿에서도 그렇고, 스프링에서는 달라진다.-->

<%
	String command = request.getParameter("command");
	System.out.println("<"+command+">");
	
	MVCBiz biz = new MVCBizImpl();
	
	/*SelectList*/
	if(command.equals("list")) {	// 만일 index.jsp에서 보내온 command의 값을 받은게 list라면, 
		// 1. 전달된 값이 있으면 받아주자. (command 제외하고 전달된 값) 없으므로 생략
		
		// 2. 필요하다면, db와 연결하자. 데이터베이스에서 연결해서 테이블 전체를 가져올거다. 왜냐면 selectlist를 하고 있기때문에.
		List<MVCDto> list = biz.selectList(); 
		
		// 3. 보내줄 값이 있다면, request에 담자. 
		request.setAttribute("list", list); // list라는 이름으로 list를 담을거다.
		
		// 4. 보내자
		pageContext.forward("mvclist.jsp");
	
	// list로 가고싶다고 한다면, db에서 값 가지고와서 request에 담아서 list로 보내자(응답시키자).
	
	
		/*insert*/	
	} else if (command.equals("insertform")) {
		//1.전달된 값이 있다면 받아주자 (해당 없음)
		//2.db와 연결하자(해당 없음)
		//3.보내줄 값 있나?(해당 없음)
		//4.보내자.
		response.sendRedirect("mvcinsert.jsp");
		
		/*글 작성하기*/
	} else if (command.equals("insertres")) {
		//1. 전달된 값이 있다. writer, title, content (insert td태그 보기)
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		// 2. 위에 3개를 dto에 담아서 전달해야한다. db랑 연결할거니까
		MVCDto dto = new MVCDto();
		dto.setWriter(writer);
		dto.setTitle(title);
		dto.setContent(content);
		// 위에를 비즈로 보내자! 
		int res = biz.insert(dto);
		// 3. 보내줄 값이 있으면 담자. 
		// 4. 전달하자. 만일 res가 0보다 크면..!
		if (res > 0) {
%>
		<script type="text/javascript">
			alert("저장 성공");
			location.href="mvccontroller.jsp?command=list";
		</script>
<%
		} else {
%>
		<script type="text/javascript">
			alert("저장 실패");
			location.href="mvccontroller.jsp?command=insertform";
		</script>
<%
		}
		
		/*selectOne*/
	} else if (command.equals("detail")) {
		//1.
		int seq = Integer.parseInt(request.getParameter("seq"));
		//2.
		MVCDto dto = biz.selectOne(seq);
		//3.
		request.setAttribute("dto", dto); // "dto"는 객체의 이름, dto는 객체. 왜 값을 받을때 object로 받을까? 모든 클래스의 부모클래스이기때문에 조상!(범위가 넓다)
		//4.
		pageContext.forward("mvcselect.jsp");
			// 실행화면 : localhost:8787/Jsp03_MVC/mvccontroller.jsp?command=detail&seq=2라고 나온다. 
			// C가 S에게 요청하면, S는 forward(위임)해서 mvcselect로 연결된다. 그럼 mvcselect가 응답도 하고 결과도 보여준다. 
			
			
		/*update*/	
	} else if(command.equals("updateform")){
		//1.
		int seq = Integer.parseInt(request.getParameter("seq"));
		//2.
		MVCDto dto = biz.selectOne(seq);
		//3.
		request.setAttribute("dto", dto);
		//4.
		pageContext.forward("mvcupdate.jsp");
		
		
	} else if (command.equals("updateres")) {
		//1. 번호랑, 제목, 내용
		int seq = Integer.parseInt(request.getParameter("seq"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		//2. 담아서 db에 연결 
		MVCDto dto = new MVCDto();
		dto.setSeq(seq);
		dto.setTitle(title);
		dto.setContent(content);
		int res = biz.update(dto);
		
		//3, 4. res가 말하는건 수정이 성공했거나, 실패했다.
		//      성공해도 controller를 거쳐서 띄운다. 그냥 바로 페이지로 보내도 되는데, 꼬이게 된다.
		// 아래 코드 평소랑 좀 다르게 함. 
		
		if (res > 0) {
			// 3.
			List<MVCDto> list = biz.selectList();
			request.setAttribute("list", list);
			// 4.
			pageContext.forward("mvclist.jsp");
			
		} else {
			// 3.
			MVCDto updateDto = biz.selectOne(seq);
			request.setAttribute("dto", updateDto);
			// 4.
			pageContext.forward("mvcselect.jsp");
		}
	
		/*delete 오류남ㅠ*/	
	} else if (command.equals("delete")) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		int res = biz.delete(seq);
		
		if (res > 0) {
%>
		<script type="text/javascript">
			alert("삭제 성공");
			location.href="mvccontroller.jsp?command=list";
		</script>
<%
		} else {
%>
		<script type="text/javascript">
			alert("삭제 실패");
			location.href="./controller.jsp?command=select&seq=<%=seq%>";
		</script>
<%
		}
	} 
%>

<h1>잘못왔다...</h1>
</body>
</html>