package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	
	
	
	public int deleteNotice(Notice notice) throws Exception {
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		return 0;
	}
	
	
	public int updateNotice(Notice notice) throws Exception {
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice _no = ?";
		return 0;
	}
	
	public int insertNotice(Notice notice) throws Exception {
		String sql = "INSERT INTO notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
		return 0;
	}
	// 마지막 페이지 구하기 위한 총 행의수를 가져오는 쿼리문 작성
	public int selectNoticeCount() throws Exception {
		int count = 1;
		// 드라이버 로딩,연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 생성
		String sql = "SELECT COUNT(*) FROM notice";
		// 쿼리객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt(count);
		}
		return count;
	}
	// loginForm공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 작성
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, updatedate, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?, ?";
		// 쿼리 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 쿼리문 ?값 지정
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setUpdatedate(rs.getString("updatedate"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		return list;
	}
}
