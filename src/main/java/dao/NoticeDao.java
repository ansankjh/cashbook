package dao;

import java.sql.*;

import java.util.ArrayList;

import util.DBUtil;
import vo.*;

public class NoticeDao {
	// 공지 삭제
	public int deleteNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "DELETE FROM notice WHERE notice_no = ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, notice.getNoticeNo());
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
	
	// 공지 수정
	public int updateNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라이버 로딩 ,연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
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
	
	public int insertNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라아비어 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "INSERT INTO notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setString(2, notice.getUpdatedate());
			stmt.setString(3, notice.getCreatedate());
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
	// 마지막 페이지 구하기 위한 총 행의수를 가져오는 쿼리문 작성
	public int selectNoticeCount() {
		int count = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 드라이버 로딩,연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// 쿼리문 생성
			String sql = "SELECT COUNT(*) FROM notice";
			// 쿼리객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리 실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
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
		return count;
	}
	
	// loginForm공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// 쿼리문 작성
			String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, updatedate, createdate"
					+ " FROM notice ORDER BY createdate DESC"
					+ " LIMIT ?, ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 쿼리 실행
			rs = stmt.executeQuery();
			list  = new ArrayList<Notice>();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setUpdatedate(rs.getString("updatedate"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
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
	
	// 공지 내용 value값	
	public ArrayList<Notice> selectNotice(int noticeNo) {
		ArrayList<Notice> noticeList = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "SELECT notice_memo noticeMemo FROM notice WHERE notice_no = ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, noticeNo);
			// 쿼리 실행
			rs = stmt.executeQuery();
			
			noticeList = new ArrayList<Notice>();
			if(rs.next()) {
				Notice n = new Notice();
				n.setNoticeMemo(rs.getString("noticeMemo"));
				noticeList.add(n);
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
		return noticeList;
	}
	// adminMain.jsp 최근 멤버 목록 조회
	public ArrayList<Member> selectMember() {
		ArrayList<Member> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_id memberId, member_level memberLevel FROM member ORDER BY member_no ASC";
		try {
			// db연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 객체 생성
			stmt = conn.prepareStatement(sql);			
			// 쿼리 실행
			rs = stmt.executeQuery();
			list = new ArrayList<Member>();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
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
