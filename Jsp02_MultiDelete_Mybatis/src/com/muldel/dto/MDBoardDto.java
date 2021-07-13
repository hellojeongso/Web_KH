package com.muldel.dto;

import java.util.Date;

public class MDBoardDto {
// row를 dto에 저장하는 과정
	
	private int seq;
	private String writer;
	private String title;
	private String content;
	private Date regdate;
	
	public MDBoardDto() {
		
	}
	
	// 글 작성할 때 사용할 파라미터 있는 생성자
	// 작성자, 제목, 내용 
	public MDBoardDto(String writer, String title, String content) {
		this.writer = writer;
		this.title = title;
		this.content = content;
	}
	
	// 글 수정할 때 사용할 파라미터 있는 생성자
	// 번호, 제목, 내용
	public MDBoardDto(int seq, String title, String content) {
		this.seq = seq;
		this.title = title;
		this.content = content;
	}
	
	public MDBoardDto(int seq, String writer, String title, String content, Date regdate) {
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
/* 작성
 * 
 * 글 작성할 땐 new MDBoarddto(0, writer, title, content, null);
 * 귀찮을 땐 new MDBoardDto(writer, title, content);
 * 
 * 
 * 수정
 * new MDBoarddto (seq, null, title, content, null);
 * 귀찮을 땐 new MDBoarddto(seq, title, content);
 * 
 * 그래서 파라미터 생성자 따로 따로 작성했다. 
 */
	
	
}
