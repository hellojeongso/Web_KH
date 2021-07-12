package com.muldel.dao;

import static com.muldel.db.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.muldel.dto.MDBoardDto;

public class MDBoardDaoImpl implements MDBoardDao {
// 여기가 Dao 주 클래스
	@Override
	public List<MDBoardDto> selectList() {
		//1.
		//2.
		Connection con = getConnection();
		
		//3.
		String sql = " SELECT SEQ, WRITER, TITLE, CONTENT, REGDATE "
				+ " FROM MDBOARD "
				+ " ORDER BY SEQ DESC  ";
		
		Statement stmt = null;
		ResultSet rs = null;
		List<MDBoardDto> list = new ArrayList<MDBoardDto>();
		
		try {
			stmt = con.prepareStatement(sql);
			System.out.println("3. query 준비 :" + sql);
			
			// 4. 
			rs = stmt.executeQuery(SELECT_LIST_SQL);
			while (rs.next()) {
				MDBoardDto dto = new MDBoardDto();
								dto.setSeq(rs.getInt(1));
								dto.setWriter(rs.getString(2));
								dto.setTitle(rs.getString(3));
								dto.setContent(rs.getString(4));
								dto.setRegdate(rs.getDate(5));
				
				list.add(dto);
			}
		} catch (SQLException e) {
		
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
		
	}

	@Override
	public MDBoardDto selectOne(int seq) {
		
		Connection con = getConnection();
		
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MDBoardDto dto = new MDBoardDto();
		
		try {
			pstm = con.prepareStatement(SELECT_ONE_SQL);
			pstm.setInt(1, seq);
			
			rs = pstm.executeQuery();
			while (rs.next()) {
				dto.setSeq(rs.getInt(1));
				dto.setWriter(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRegdate(rs.getDate(5));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
		}
		
		return dto;
	}
	

	@Override
	public int insert(MDBoardDto dto) {
		
		Connection con = getConnection();
		
		PreparedStatement pstm = null;
		int res = 0;
		
		try {
			pstm = con.prepareStatement(INSERT_SQL);
			pstm.setString(1, dto.getWriter());
			pstm.setString(2, dto.getTitle());
			pstm.setString(3, dto.getContent());
			
			res = pstm.executeUpdate();
			if (res > 0) {
				commit(con);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		
		return res;
	}



	@Override
	public int update(MDBoardDto dto) {
		
		Connection con = getConnection();
		
		PreparedStatement pstm = null;
		int res = 0;
		
		try {
			pstm = con.prepareStatement(UPDATE_SQL);
			pstm.setInt(3, dto.getSeq());
			pstm.setString(1, dto.getTitle());
			pstm.setString(2, dto.getContent());
			
			res = pstm.executeUpdate();
			if (res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		
		return res;
	}
	@Override
	public int delete(int seq) {
		
		Connection con = getConnection();
		
		PreparedStatement pstm = null;
		int res = 0;
		
		try {
			pstm = con.prepareStatement(DELETE_SQL);
			pstm.setInt(1, seq);
			
			res = pstm.executeUpdate();
			if (res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		
		return res;
	}


	@Override
	public int multiDelete(String[] seqs) {
		Connection con = getConnection();
		
		PreparedStatement pstm = null;
		int res = 0;
		int[] cnt = null;
		
		try {
			pstm = con.prepareStatement(DELETE_SQL);
			for (int i = 0; i < seqs.length; i++) {
				pstm.setString(1, seqs[i]);
				// 메모리에 sql문을 적재 후, executeBatch() 메소드가 호출되면 한번에 실행!
				pstm.addBatch();
				System.out.println("삭제할 번호:" + seqs[i]);
			}
			
			// 메모리에 저장된 sql문을 한번에 실행!
			// 리턴 : int[] 
			// 성공 -2 / 실패 -3
			cnt = pstm.executeBatch();
			System.out.println("4. query 실행 및 리턴");
			for (int i = 0; i < cnt.length; i++) {
				
				if (cnt[i] == -2) {
					//성공인 갯수 카운트
					res++;
				}
			}
			
			if (seqs.length == res) {
				commit(con);
			} else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm, con);
			System.out.println("5. db종료");
		}
		
		return res;
	}

}

/*
 * 
 *	원래는 dao에서 db로 쿼리문 보내면
 * db는 쿼리문보고 테이블을,ㅇ아니면 int를 리턴
 * 근데 이건 dao와 db사이에 메모리공간을 새만들고 
 * dao가 이 메모리공간에 add한다. 
 *pstm.addBatch()는 다오에서 메모리에다가 쿼리문을 저장해주는 역할을 한다.
 *sql0, sql1, sql2 .........
 *그럼 거기에 딜리트쿼리문이 차곡차곡쌓인다. 
 *cnt = pstm.executeBatch();하면 한번에 db로 보낸다?
 *그럼 그 저장된 결과를 리턴해주는데........... 
 *if (cnt[i] == -2) -> 즉 -2는 성공했냐? ? ? 성공했으면 ++;
 *
 *한번에 여러개의 쿼리를 전달이 가능해서
 *커넥션객체는 한개로 여러개의 sql문으로 전달이가능해서
 *db에서 한번에 실행가능 ex) 0번지 쿼리 1번지 쿼리 2번지 쿼리 배열로 전달돼서
 *(-2, -2, -3) 실패했다 성공했다 이렇게 한번에 전달가능 
 *결과값 배열로 리턴 
 *-2의 갯수가 같지않음녀 rollback할거다.
 *성공하면(3개) commit 
 *
 *res++ 이 성공인애들의 갯수를 전달하는거임
 *
 *
*/