package com.muldel.dao;

import java.util.List;

import com.muldel.dto.MDBoardDto;

public interface MDBoardDao {

	String SELECT_LIST_SQL = " SELECT SEQ, WRITER, TITLE, CONTENT, REGDATE "
							+ " FROM MDBOARD "
							+ " ORDER BY SEQ DESC ";
	String SELECT_ONE_SQL = " SELECT SEQ, WRITER, TITLE, CONTENT, REGDATE "
							+ " FROM MDBOARD "
							+ " WHERE SEQ = ? ";
	String INSERT_SQL = " INSERT INTO MDBOARD "
						+ " VALUES (MDBOARDSEQ.NEXTVAL, ?, ?, ?, SYSDATE) "; // 시퀀스로 넣어주기로 했다는데요?
	String UPDATE_SQL = " UPDATE MDBOARD "
						+ " SET TITLE = ?, CONTENT = ? "
						+ " WHERE SEQ = ? ";
	String DELETE_SQL = " DELETE FROM MDBOARD "
					+ " WHERE SEQ = ? ";
	
	
	// public () : 해당 메소드가 실행되고 난 후에 리턴되는 값의 타입
	// 파라미터와 아규먼트 : 외부에서 전달 되는 값을 받아서 Dao에서 사용할 변수(ex. selectList, int seq..)
	public List<MDBoardDto> selectList(); // Dto가 담긴 LIST 리턴
	public MDBoardDto selectOne(int seq); // 글 번호에 맞는 DTO 
	public int insert(MDBoardDto dto);	// int : insert, update, delete된 row의 개수
	public int update(MDBoardDto dto);	
	public int delete(int seq);
	
	
	public int multiDelete(String[] seqs);
	
}


