package com.muldel.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.muldel.dto.MDBoardDto;

public class MDBoardDaoImpl extends SqlMapConfig implements MDBoardDao {

	private String namespace = "muldel.mapper.";
	
	@Override
	public List<MDBoardDto> selectList() {
		List<MDBoardDto> list = new ArrayList<MDBoardDto>();
		
		try(SqlSession session = getSqlSessionFactory().openSession(false)){
			list = session.selectList(namespace+"selectList");
		}
	
		return list;
		
	}

	@Override
	public MDBoardDto selectOne(int seq) {
		
		return null;
	}
	

	@Override
	public int insert(MDBoardDto dto) {
		return 0;
	}



	@Override
	public int update(MDBoardDto dto) {
		
		return 0;
	}
	@Override
	public int delete(int seq) {
		
		
		return 0;
	}


	@Override
	public int multiDelete(String[] seqs) {
		// 동적 쿼리
		int count = 0;
		
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seqs", seqs);
		
		SqlSession session = null;
		
		try {
			session = getSqlSessionFactory().openSession(false);
			count = session.delete(namespace+"multiDelete", map);
			if (count == seqs.length) {
				session.commit();
			}
		} catch (Exception E) {
			E.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}

}
