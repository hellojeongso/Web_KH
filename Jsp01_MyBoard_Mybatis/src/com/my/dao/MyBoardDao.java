package com.my.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.my.dto.MyBoardDto;

public class MyBoardDao extends SqlMapConfig {			// 상속 받음
	
		private String namespace = "com.my.mapper.";
	
		public List<MyBoardDto> selectList(){	
			//	try (SqlSession session = sqlSessionFactory.openSession()) {
			//	Blog blog = session.selectOne("org.mybatis.example.BlogMapper.selectBlog", 101);
			//	} -> try 하지 않고 작성. 
			
			//qlSessionFactory 객체는 Dao에서 openSession을 해서 SqlSeesion 객체를 만든다.
			//SqlSession은 어떤 mapper의(mapper.xml의 namespace) 어떤 특정 쿼리(select id)를 실행시켜서
			//리턴 받아주는 객체이다. (List<MyBoardDto> list에)
			SqlSession session = getSqlSessionFactory().openSession();
			List<MyBoardDto> list = session.selectList("com.my.mapper."+"selectList");	//원래는 com.my.mapper.seletList인데.. +하기 그냥 씀
			session.close();
			
			return list;				
		}
		
		// try-catch : alt + shift + z 
		public MyBoardDto selectOne(int myno) {	
			SqlSession session = null;
			MyBoardDto dto = null;
			
			try {
				session = getSqlSessionFactory().openSession();
				dto = session.selectOne(namespace + "selectOne", myno);  	// 원래 괄호 안에 위 코드 처럼 "com.my.mapper."+"selectOne" 써야하는데, 오타날 확률이 많으니까 필드 작성
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				session.close();
			}
				
				
			
			return dto;
		}
		
		
		public int insert(MyBoardDto dto) {
			int res = 0;
			
			try (SqlSession session = getSqlSessionFactory().openSession(true)) {
				res = session.insert(namespace+"insert", dto);
			}
			return res;
		}
		
		public int update(MyBoardDto dto) {
			int res = 0;
			try (SqlSession session = getSqlSessionFactory().openSession(true)) {
				res = session.update(namespace+"update", dto);
			}
			return res;
		}
		
		
		public int delete(int myno) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)) {
				res = session.delete(namespace+"delete", myno);
			}
			return res;
			
		}
	}
