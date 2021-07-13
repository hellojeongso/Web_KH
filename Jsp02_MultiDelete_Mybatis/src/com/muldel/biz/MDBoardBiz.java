package com.muldel.biz;

import java.util.List;

import com.muldel.dto.MDBoardDto;

public interface MDBoardBiz {
	
	// 보통 BIZ는 DAO랑 비슷하게 만든다. MDBoardDao 복붙해옴
	public List<MDBoardDto> selectList(); 
	public MDBoardDto selectOne(int seq);
	public int insert(MDBoardDto dto);
	public int update(MDBoardDto dto);
	public int delete(int seq);
	
	
	public int multiDelete(String[] seqs);
}
