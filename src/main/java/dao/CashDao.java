package dao;

import java.sql.*;

import java.util.ArrayList;
import java.util.HashMap;

import vo.*;

import util.DBUtil;

public class CashDao {
	// 페이징
	public HashMap<String, Object> selectMaxMinYear() {
		HashMap<String, Object> map = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문 작성
		String sql = "SELECT"
				+ "		(SELECT Min(YEAR(cash_date)) FROM cash) minYear"
				+ "		, (SELECT Max(YEAR(cash_date)) FROM cash) maxYear"
				+ " FROM DUAL";
		try {
			// 드라이버 연결, 로딩
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리 객체생성
			stmt = conn.prepareStatement(sql);
			// 쿼리 실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("minYear", rs.getInt("minYear"));
				map.put("maxYear", rs.getInt("maxYear"));
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
		return map;
	}
	// 사용자별 년도를(페이징) 매개값으로 입력받아 월별(수입/지출) sum,avg
	public ArrayList<HashMap<String, Object>> selectSumAvgByMonth(String memberId, int year) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
			// 쿼리문 작성
			String sql = "SELECT"
					+ "			MONTH(t2.cashDate) m"
					+ "			, COUNT(t2.importCash) iCnt"
					+ "			, IFNULL(SUM(t2.importCash), 0) iSum"
					+ "			, IFNULL(ROUND(AVG(t2.importCash)), 0) iAvg"
					+ "			, COUNT(t2.exportCash) eCnt"
					+ "			, IFNULL(SUM(t2.exportCash), 0) eSum"
					+ "			, IFNULL(ROUND(AVG(t2.exportCash)), 0) eAvg"
					+ "		FROM"
					+ "			(SELECT"
					+ "					memberId"
					+ "					, cashNo"
					+ "					, cashDate"
					+ "					, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "					, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "				FROM (SELECT cs.cash_no cashNo"
					+ "							, cs.cash_date cashDate"
					+ "							, cs.cash_price cashPrice"
					+ "							, cg.category_kind categoryKind"
					+ "							, cs.member_id memberId"
					+ "						FROM cash cs"
					+ "						INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ "		WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ "		GROUP BY MONTH(t2.cashDate)"
					+ "		ORDER BY MONTH(t2.cashDate) ASC";
				
		try {
			// 드라이버 로딩 연결
			dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
			//쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			// 쿼리 실행
			rs = stmt.executeQuery();
			// 저장
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("m"));
				m.put("iCnt", rs.getInt("iCnt"));
				m.put("iSum", rs.getInt("iSum"));
				m.put("iAvg", rs.getInt("iAvg"));
				m.put("eCnt", rs.getInt("eCnt"));
				m.put("eSum", rs.getInt("eSum"));
				m.put("eAvg", rs.getInt("eAvg"));
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
	// 사용자별 년도별 수입/지출 sum,avg
	public ArrayList<HashMap<String, Object>> selectSumAvgByYear(String memberId) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		 SELECT 
			YEAR(t2.cashDate) 년
			, COUNT(t2.importCash) 수입카운트
			, IFNULL(SUM(t2.importCash), 0) 수입합계
			, IFNULL(ROUND(AVG(t2.importCash)), 0) 수입평균
			, COUNT(t2.exportCash) 지출카운트
			, IFNULL(SUM(t2.exportCash), 0) 지출합계
			, IFNULL(ROUND(AVG(t2.exportCash)), 0) 지출평균
		FROM
			(SELECT 
				memberId
				, cashNo
				, cashDate
				, IF(categoryKind = '수입', cashPrice, null) importCash
				, IF(categoryKind = '지출', cashPrice, null) exportCash
			FROM (SELECT cs.cash_no cashNo
						, cs.cash_date cashDate
						, cs.cash_price cashPrice
						, cg.category_kind categoryKind
						, cs.member_id memberId
					FROM cash cs 
					INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2
		WHERE t2.memberId = 'goodee'
		GROUP BY YEAR(t2.cashDate)
		ORDER BY YEAR(t2.cashDate) ASC; 
		 */
			// 쿼리문 작성
			String sql = "SELECT"
					+ "		YEAR(t2.cashDate) y"
					+ " 	, COUNT(t2.importCash) iCnt"
					+ "		, IFNULL(SUM(t2.importCash), 0) iSum"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) iAvg"
					+ "		, COUNT(t2.exportCash) eCnt"
					+ "		, IFNULL(SUM(t2.exportCash), 0) eSum"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) eAvg"
					+ "	FROM"
					+ "		(SELECT"
					+ "				memberId"
					+ "				, cashNo"
					+ "				, cashDate"
					+ "				, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "				, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "			FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId"
					+ "					FROM cash cs"
					+ "					INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ?"
					+ " GROUP BY YEAR(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate) ASC";
				
		try {
			// 드라이버 로딩 연결
			dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
			//쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, memberId);
			// 쿼리 실행
			rs = stmt.executeQuery();
			// 저장
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year", rs.getInt("y"));
				m.put("iCnt", rs.getInt("iCnt"));
				m.put("iSum", rs.getInt("iSum"));
				m.put("iAvg", rs.getInt("iAvg"));
				m.put("eCnt", rs.getInt("eCnt"));
				m.put("eSum", rs.getInt("eSum"));
				m.put("eAvg", rs.getInt("eAvg"));
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