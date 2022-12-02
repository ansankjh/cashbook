package dao;

import vo.*;
import java.sql.*;

import util.DBUtil;

public class CommentDao {
	
	// 입력
	public int insertComment(Comment comment) {
		int row = 0;
		DBUtil dbUtil =null;
		Connection conn = null;
		PreparedStatement stmt = null;
		// 쿼리문 작성
		String sql = "INSERT INTO COMMENT(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW());";
		try {
			// 초기화 
			dbUtil = new DBUtil();	
			// 연결
			conn = dbUtil.getConnection();
			// 객체
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
			stmt.setString(4, comment.getUpdatedate());
			stmt.setString(5, comment.getCreatedate());
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
	// 수정form
	public Comment selectCommentOne(int commentNo) {
		Comment c = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리문 작성
		String sql = "SELECT comment_no commentNo, comment_memo commentMemo FROM comment WHERE comment_no = ?";
		try {
			// 초기화
			dbUtil = new DBUtil();
		
			// 연결
			conn = dbUtil.getConnection();
			// 객체
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, commentNo);
			// 실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				c = new Comment();
				c.setCommentNo(rs.getInt("commentNo"));
				c.setCommentMemo(rs.getString("commentMemo"));
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
		return c;
	}
	// 수정ACTION
	public int updateComment(Comment comment) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		// 쿼리문
		String sql = "UPDATE COMMENT SET comment_memo = ?, updatedate = now()  WHERE comment_no = ?"; 
		try {
			// 초기화
			dbUtil  = new DBUtil();		
			// 연결
			conn = dbUtil.getConnection();
			// 객체
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
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
	
	// 삭제
	public int deleteComment(Comment comment) {
		int row = 0;
		DBUtil dbUtil = null;
		// 연결초기화
		Connection conn = null;
		// 객체 초기화
		PreparedStatement stmt = null;
		// 쿼리문 
		String sql = "DELETE FROM COMMENT WHERE comment_no = ?";
		try {
			// 초기화
			dbUtil = new DBUtil();		
			// 연결
			conn = dbUtil.getConnection();
			// 객체
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, comment.getCommentNo());
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
