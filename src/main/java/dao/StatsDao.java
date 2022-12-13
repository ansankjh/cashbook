package dao;

import java.sql.*;

import java.util.ArrayList;
import java.util.HashMap;

import vo.*;

import util.DBUtil;

public class StatsDao {
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
}