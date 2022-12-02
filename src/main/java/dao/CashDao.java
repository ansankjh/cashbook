package dao;

import java.sql.*;

import java.util.ArrayList;
import java.util.HashMap;

import vo.*;

import util.DBUtil;

public class CashDao {	
	/*
	SELECT 
		c.cash_no cashNo
		, c.cash_date cashDate
		, c.cash_price cashPrice
		, c.category_no categoryNo
		, ct.category_kind categoryKind
		, ct.category_name categoryName
	FROM cash c INNER JOIN category ct
	ON c.category_no = ct.category_no
	WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?
	ORDER BY c.cash_date ASC;
	 */
	// 호출 : cashList.jsp
	// updateCash
	public ArrayList<HashMap<String, Object>> selectCash(String memberId, int cashNo) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리문 작성
		String sql = "SELECT ct.category_name categoryName"
				+ " , c.cash_price cashPrice"
				+ " , c.cash_memo cashMemo"
				+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no"
				+ " WHERE cash_no = ?";
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, cashNo);
			// 쿼리 실행
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("categoryName", rs.getString("categoryName"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashMemo", rs.getString("cashMemo"));			
				list.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	
		
		return list;
	}
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리문 작성
		String sql = "SELECT"
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, c.cash_price cashPrice"
				+ "		, c.category_no categoryNo"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "		, c.cash_memo cashMemo"
				+ "		, c.updatedate updateDate"
				+ "		, c.createdate createDate"
				+ "		, c.member_id memberId"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC";
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			// 쿼리 실행
			rs = stmt.executeQuery();
			// map에 rs값 저장
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("categoryNo", rs.getInt("categoryNo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("createDate", rs.getString("createDate"));
				m.put("memberId", rs.getString("memberId"));
				list.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}		
		return list;
	}
	
	// cashDateList.jsp
		public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
			ArrayList<HashMap<String, Object>> list = null;
			DBUtil dbUtil  = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문 작성
			String sql = "SELECT"
					+ "		c.cash_no cashNo"
					+ "		, c.cash_date cashDate"
					+ "		, c.cash_price cashPrice"
					+ "		, c.cash_memo cashMemo"
					+ "		, ct.category_kind categoryKind"
					+ "		, ct.category_name categoryName"
					+ " FROM cash c INNER JOIN category ct"
					+ " ON c.category_no = ct.category_no"
					+ " WHERE c.member_id = ?"
					+ " AND YEAR(c.cash_date) = ?"
					+ " AND MONTH(c.cash_date) = ?"
					+ " AND DAY(c.cash_date) = ?"
					+ " ORDER BY c.cash_date ASC, ct.category_kind ASC";
			try {
				// 드라이버 로딩, 연결
				dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
				// 쿼리 객체 생성
				stmt = conn.prepareStatement(sql);
				// 쿼리 ?값 지정
				stmt.setString(1, memberId);
				stmt.setInt(2, year);
				stmt.setInt(3, month);
				stmt.setInt(4, date);
				// 쿼리 실행
				rs = stmt.executeQuery();
				// map에 rs값 저장
				list = new ArrayList<HashMap<String, Object>>();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					// 과제
					// m.put()
					m.put("cashNo", rs.getInt("cashNo"));
					m.put("cashDate", rs.getString("cashDate"));
					m.put("cashPrice", rs.getLong("cashPrice"));
					m.put("cashMemo", rs.getString("cashMemo"));
					m.put("categoryKind", rs.getString("categoryKind"));
					m.put("categoryName", rs.getString("categoryName"));		
					list.add(m);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}		
			return list;
		}
		
	// insertCashAction
	public int insertCash(Cash paramCash) {
		int row = 0;
		DBUtil dbUtil  = null;
		Connection conn = null;
		PreparedStatement insertStmt = null;
		// 쿼리문 작성
		String insertSql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) values(?, ?, ?, ?, ?, curdate(), curdate())";
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// 쿼리 객체 생성
			insertStmt = conn.prepareStatement(insertSql);
			// 쿼리문 ?값 지정
			insertStmt.setInt(1, paramCash.getCategoryNo());
			insertStmt.setString(2, paramCash.getMemberId());
			insertStmt.setString(3, paramCash.getCashDate());
			insertStmt.setLong(4, paramCash.getCashPrice());
			insertStmt.setString(5, paramCash.getCashMemo());
			// 쿼리 실행
			row = insertStmt.executeUpdate();
			
			if(row == 1) {
				insertStmt.close();
				conn.close();
				return 1;
			} else {
				insertStmt.close();
				conn.close();
				return 0;
			} 
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, insertStmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	// cash 업데이트
	public int updateCash(Cash cash) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		// 쿼리문 작성
		String sql = "UPDATE CASH SET category_no=?, cash_price=?, cash_memo=? WHERE cash_no=? AND member_id=?";
		try {
			// 드라이버 로딩 , 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();			
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setLong(2, cash.getCashPrice());
			stmt.setString(3, cash.getCashMemo());
			stmt.setInt(4, cash.getCashNo());
			stmt.setString(5, cash.getMemberId());
			// 쿼리 실행
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}		
		return row;
	}
	
	// cash삭제
	public int deleteCash(Cash cash) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// 쿼리문 작성
		String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ?";
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();		
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, cash.getCashNo());
			stmt.setString(2, cash.getMemberId());
			// 쿼리 실행
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}	
		return row;		
	}	
}