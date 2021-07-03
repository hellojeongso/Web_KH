package com.my.dto;

import java.util.Date;

public class MyBoardDto {
	
	// 필드 : 연결하고 싶은 DB 테이블 컬럼의 이름과 똑같이 작성하는 것이 좋다. 
	private int myno;
	private String myname;
	private String mytitle;
	private String mycontent;
	private Date mydate;
	
	// 생성자
	public MyBoardDto() {
		
	}
	
	// 파라미터 5개 있는 생성자
	public MyBoardDto(int myno, String myname, String mytitle, String mycontent, Date mydate) {
		this.myno = myno;
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
		this.mydate = mydate;
	}

	// getter&setter
	public int getMyno() {
		return myno;
	}

	public void setMyno(int myno) {
		this.myno = myno;
	}

	public String getMyname() {
		return myname;
	}

	public void setMyname(String myname) {
		this.myname = myname;
	}

	public String getMytitle() {
		return mytitle;
	}

	public void setMytitle(String mytitle) {
		this.mytitle = mytitle;
	}

	public String getMycontent() {
		return mycontent;
	}

	public void setMycontent(String mycontent) {
		this.mycontent = mycontent;
	}

	public Date getMydate() {
		return mydate;
	}

	public void setMydate(Date mydate) {
		this.mydate = mydate;
	}
	
	
	
}