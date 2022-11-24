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
	public ArrayList<HashMap<String, Object>> updateCash(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문 작성
		String sql = "SELECT ct.category_kind categoryKind, ct.category_name categoryName"
				+ " , c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo"
				+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no"
				+ " WHERE c.member_id = ? ORDER BY C.CASH_DATE ASC, ct.category_kind ASC";
		// 쿼리 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 쿼리문 ?값 지정
		stmt.setString(1, memberId);
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryMemo", rs.getString("categoryMemo"));			
			list.add(m);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문 작성
		String sql = "SELECT"
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, c.cash_price cashPrice"
				+ "		, c.category_no categoryNo"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC";
		// 쿼리객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 쿼리문 ?값 지정
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		// map에 rs값 저장
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// cashDateList.jsp
		public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			// 드라이버 로딩, 연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
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
			// 쿼리 객체 생성
			PreparedStatement stmt = conn.prepareStatement(sql);
			// 쿼리 ?값 지정
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			// 쿼리 실행
			ResultSet rs = stmt.executeQuery();
			// map에 rs값 저장
			
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
			
			rs.close();
			stmt.close();
			conn.close();
			return list;
		}
	// insertCashAction
	public int insertCash(Cash paramCash) throws Exception {
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문 작성
		String insertSql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) values(?, ?, ?, ?, ?, curdate(), curdate())";
		// 쿼리 객체 생성
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		// 쿼리문 ?값 지정
		insertStmt.setInt(1, paramCash.getCategoryNo());
		insertStmt.setString(2, paramCash.getMemberId());
		insertStmt.setString(3, paramCash.getCashDate());
		insertStmt.setLong(4, paramCash.getCashPrice());
		insertStmt.setString(5, paramCash.getCashMemo());
		// 쿼리 실행
		int row = insertStmt.executeUpdate();
		
		if(row == 1) {
			insertStmt.close();
			conn.close();
			return 1;
		} else {
			insertStmt.close();
			conn.close();
			return 0;
		}
			
		
	}
}