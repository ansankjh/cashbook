package dao;

import java.util.*;
import util.*;
import java.sql.*;
import vo.*;

public class HelpDao {
	// 관리자쪽에서 호출
	// selectHelpList 오버로딩 : 메서드 이름이 같은데 매개값이 다른것
	// admin/helpListAll.jsp
	public ArrayList<HashMap<String, Object>> selectHelpListAll(int beginRow, int rowPerPage) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		SELECT h.help_no, h.help_memo, h.member_id
			, h.updatedate, h.createdate 
			, c.comment_no
			, c.comment_memo
			FROM help h LEFT OUTER JOIN COMMENT c 
			ON h.help_no = c.help_no WHERE h.member_id = 'goodee';
		 */
		// 쿼리문작성
		String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo"
				+ " , h.createdate helpCreatedate, c.comment_memo commentMemo"
				+ " , c.createdate commentCreatedate, h.member_id memberId"
				+ " , c.comment_no commentNo"
				+ " FROM help h LEFT OUTER JOIN comment c"
				+ " ON h.help_no = c.help_no ORDER BY h.help_no ASC"
				+ " LIMIT ?, ?";
		try {
			// 초기화
			dbUtil = new DBUtil();			
			// 연결, 값 지정
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 쿼리 실행		
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				m.put("memberId", rs.getString("memberId"));	
				m.put("commentNo", rs.getString("commentNo"));
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
	
	
	// selectHelpList 오버로딩 : 메서드 이름이 같은데 매개값이 다른것
	// helpList.jsp
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId, int beginRow, int rowPerPage) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		SELECT h.help_no, h.help_memo, h.member_id
			, h.updatedate, h.createdate 
			, c.comment_no
			, c.comment_memo
			FROM help h LEFT OUTER JOIN COMMENT c 
			ON h.help_no = c.help_no WHERE h.member_id = 'goodee';
		 */
		// 쿼리문작성
		String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo"
				+ " , h.createdate helpCreatedate, c.comment_memo commentMemo"
				+ " , c.createdate commentCreatedate, h.member_id memberId"
				+ " , c.comment_no commentNo"
				+ " FROM help h LEFT OUTER JOIN comment c"
				+ " ON h.help_no = c.help_no WHERE h.member_id=? ORDER BY h.help_no ASC"
				+ " LIMIT ?, ?";
		try {
			// 초기화
			dbUtil = new DBUtil();			
			// 연결, 값 지정
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			// 쿼리 실행		
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				m.put("memberId", rs.getString("memberId"));	
				m.put("commentNo", rs.getString("commentNo"));
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
	
	
	// Help 테이블 총 행의 수
	public int helpCount() {
		int row = 0;
		// 쿼리문 작성
		String sql = "SELECT COUNT(*) FROM help";
		DBUtil dbUtil  = null;
		// 드라이버 연결 초기화
		Connection conn = null;
		// 쿼리 객체 초기화
		PreparedStatement stmt = null;
		// 쿼리 실행 초기화
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			// 값 넣기
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt("COUNT(*)");
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
		return row;
	}
	
	// comment 답변조회
	public ArrayList<HashMap<String, Object>> selectComment(int helpNo) {
		ArrayList<HashMap<String, Object>> list = null;
		String sql = "SELECT comment_memo commentMemo, createdate commentCreatedate FROM comment WHERE help_no = ?";
		// 초기화
		DBUtil dbUtil = null;
		// 연결 초기화
		Connection conn = null;
		// 쿼리 객체 초기화
		PreparedStatement stmt = null;
		// 쿼리 실행 초기화
		ResultSet rs = null;
		
		try {
			dbUtil = new DBUtil();
			// 연결
			conn = dbUtil.getConnection();
			// 쿼리 객체
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, helpNo);
			// 쿼리 실행
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
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
	
	/* 문의내용 조회 helpOne.jsp
	public Help selectHelpMemo(int helpNo) throws Exception {
		Help help = null;
		// 쿼리문 작성
		String sql = "SELECT help_title helpTitle, help_memo helpMemo FROM help WHERE help_no = ?";
		DBUtil dbUtil = new DBUtil();
		// 드라이버 연결 초기화
		Connection conn = null;
		// 쿼리 객체 초기화
		PreparedStatement stmt = null;
		// 쿼리 실행 초기화
		ResultSet rs = null;
		// 드라이버 연결
		conn = dbUtil.getConnection();
		// 쿼리 객체 생성
		stmt = conn.prepareStatement(sql);
		// 쿼리문 ?값 지정
		stmt.setInt(1, helpNo);
		// 쿼리 실행
		rs = stmt.executeQuery();
		if(rs.next()) {
			help = new Help();
			help.setHelpTitle(rs.getString("helpTitle"));
			help.setHelpMemo(rs.getString("helpMemo"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return help;
	}
	*/
	
	// 문의하기 insertHelpAction.jsp
	public int insertHelp(Help help) {
		int row = 0;
		/* 쿼리문 작성		
		INSERT INTO HELP (
				member_id
				, help_title
				, help_memo
				, updatedate
				, createdate)
		VALUES('goodee', '안녕하세요', '질문있습니다.', CURDATE(), CURDATE());
		*/
		String sql = "INSERT INTO help (help_memo, member_id, updatedate, createdate) values(?, ?, now(), now())";
		DBUtil dbUtil = null;
		// 드라이버 연결 초기화
		Connection conn = null;
		// 쿼리 객체 초기화
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			// 드라이버 연결
			conn = dbUtil.getConnection();
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
			stmt.setString(3, help.getUpdatedate());
			stmt.setString(4, help.getCreatedate());
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
	
	// updateHelpAction.jsp 문의내용 수정
	public int updateHelp(Help help) {
		int row = 0;
		/*
		 UPDATE help SET help_memo = '1번 문의사항' WHERE help_no = 1;
		*/
		// 쿼리문 작성
		String sql = "UPDATE help SET help_memo = ? WHERE help_no = ?";
		// 초기화
		DBUtil dbUtil = null;
		// 드라이버 연결 초기화
		Connection conn = null;
		// 쿼리 객체 초기화
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			//드라이버 연결
			conn = dbUtil.getConnection();
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, help.getHelpMemo());
			stmt.setInt(2, help.getHelpNo());
			// 쿼리실행
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
	
	// deleteHelp.jsp 문의삭제
	public int deleteHelp(int helpNo) {
		int row = 0;
		// 쿼리문 작성
		String sql = "DELETE FROM help WHERE help_no = ?";
		// 초기화
		DBUtil dbUtil = null;
		// 드라이버 연결 초기화
		Connection conn = null;
		// 쿼리 객체 초기화
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();
			// 드라이버 연결
			conn = dbUtil.getConnection();
			//쿼리객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, helpNo);
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
