package com.my.dao;

import static com.my.db.JDBCTemplate.*;
//Class.method를 method라고 편하게 호출하기 위해서 static을 포함하여 import하였다.

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;

import com.my.dto.MyBoardDto;

public class MyBoardDao {

	public List<MyBoardDto> selectList(){
		// 1,2. JDBCTemplate 메소드 사용
		// ▼ DB 연결된 상태(세션)을 담은 객체
		Connection con = getConnection();
		
		// 3.
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE "
				+ " FROM MYBOARD "
				+ " ORDER BY MYNO DESC ";
		PreparedStatement pstm = null;
		// PreparedStatement: SQL구문을 실행시키는 기능을 가진 객체, ? 위치홀더를 이용하여 변수를 넣는다.
		ResultSet rs = null;
		// ResultSet: 응답되는 결과 테이블(SELECT)을 받는 객체
		List<MyBoardDto> list = new ArrayList<MyBoardDto>(); 
		// DTO의 값을 효과적으로 관리할 수 있는 객체 LIST를 만든다. 이 값을 리턴해줄거다.
		// 왜 하필 LIST? 순서대로 들어온거 순서대로 저장되고, 순서대로 출력되기때문에 사용한다.  
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("3. query 준비");
			
			// 4.
			rs = pstm.executeQuery();
			System.out.println("4. query 실행 및 리턴");
			// ▼ DB Table에서 가져온 row 1개를 dto에 담는 과정을 반복하는 코드 
			while(rs.next()) {
				MyBoardDto dto = new MyBoardDto();
						dto.setMyno(rs.getInt(1));
						dto.setMyname(rs.getString(2));
						dto.setMytitle(rs.getString(3));
						dto.setMycontent(rs.getString(4));
						dto.setMydate(rs.getDate(5));
									//rs.getInt("MYNO"),
									//rs.getString("MYNAME"),
									//rs.getString("MYTITLE"),
									//rs.getString("MYCONTENT"),
									//rs.getDate("MYDATE")); 도 가능하다. 
									
				list.add(dto);					
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 
			close(rs);
			close(pstm);
			close(con);
			System.out.println("5. db 종료");
		}
		
		return list;
	}
	
	public MyBoardDto selectOne(int myno) {	// 글 확인하기.
		// selectOne : 번호 하나를 받아서 해당 글 번호에 맞는 하나의 row를 dto에 담아서 해당 dto를 리턴해준다. 
		Connection con = getConnection();
		
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE "
				+ " FROM MYBOARD "
				+ " WHERE MYNO = ? ";
		
		PreparedStatement pstm = null; // ? 쿼리를 사용했으니 pstm을 입력한다.
		ResultSet rs = null;	// Table 형태를 받을 rs
		MyBoardDto dto = new MyBoardDto();	// row 하나를 dto에 담기
					 // null;을 입력해도 되는데 약간의 차이가 있다. 그건 로그인할 때 알아보자
		try {
			pstm = con.prepareStatement(sql); // pstm이 스트링 쿼리를 담았는데, ?가 있으니 
			pstm.setInt(1, myno);	// ?에 myno라는 값을 넣어준다.
			System.out.println("3. query 준비: " + sql);
			
			rs = pstm.executeQuery(); // 쿼리를 실행하면 테이블이 나오기때문에 rs에 담았다.
			System.out.println("4. query 실행 및 리턴");
			while (rs.next()) {
				dto.setMyno(rs.getInt(1));
				dto.setMyname(rs.getString(2));
				dto.setMytitle(rs.getString(3));
				dto.setMycontent(rs.getString(4));
				dto.setMydate(rs.getDate(5)); // dto에 row담기
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("5.db 종료");
		}
		
		return dto;
	}
	
	
	public int insert(MyBoardDto dto) {
		Connection con = getConnection();
		
		String sql = " INSERT INTO MYBOARD "
				+ " VALUES(MYBOARDSEQ.NEXTVAL, ?, ?, ?, SYSDATE) ";
		PreparedStatement pstm = null;
		
		int res = 0;	// return되는 값이 insert니까 int! ★
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, dto.getMyname());
			pstm.setString(2, dto.getMytitle());
			pstm.setString(3, dto.getMycontent()); // ?에 값 세개 넣어주기
			System.out.println("3. query 준비 : " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("4. query 실행 및 리턴");
			if (res > 0) {	// insert의 row개수가 0이상이라면? (이 뜻은 성공했다는 뜻!)
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5. db 종료");
		}
		return res;
	}
	
	public int update(MyBoardDto dto) {
		// 1,2번
		Connection con = getConnection();
		// 3번 
		String sql = " UPDATE MYBOARD "
				+ " SET MYTITLE = ?, MYCONTENT = ? "
				+ " WHERE MYNO = ? ";
		
		PreparedStatement pstm = null;
			
		int res = 0;
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, dto.getMytitle());
			pstm.setString(2, dto.getMycontent());
			pstm.setInt(3, dto.getMyno());	// ?에 값 넣어주기
			System.out.println("3. query 준비 : " + sql);
			
			res = pstm.executeUpdate();
			
			System.out.println("4. query 실행 및 리턴");
			if (res > 0) {
				commit(con);
			}

		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5. db 종료");
		}
		
		
		return res;
	}
	
	
	public int delete(int myno) {
		Connection con = getConnection();
		
		String sql = " DELETE FROM MYBOARD "
				+ " WHERE MYNO = ? ";
		
		PreparedStatement pstm = null;
		int res = 0;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno); // ?에 값 넣어주기
			System.out.println("3. query 준비 :" + sql);
			
			res = pstm.executeUpdate();
			if (res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5. db 종료");
		}
		
		return res;
		
	}
}
