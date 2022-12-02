package dao;

import vo.Member;
import vo.Notice;

import java.util.*;

import org.mariadb.jdbc.export.Prepare;

import java.sql.*;

import util.*;

public class MemberDao {
	// 관리자 : 멤서 수정할때 value값
	public ArrayList<Member> selectMember(int memberNo) throws Exception {
		ArrayList<Member> memberList = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "SELECT member_id memberId, member_level memberLevel FROM member WHERE member_no = ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, memberNo);
			// 쿼리 실행
			rs = stmt.executeQuery();
			memberList = new ArrayList<Member>();
			if(rs.next()) {
				Member m = new Member();
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				memberList.add(m);
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
		return memberList;
	}
	// 관리자 : 멤버레벨수정
	public int updateMemberLevel(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라이버 로딩, 수정
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "UPDATE member SET member_level = ? WHERE member_no = ? AND member_id = ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
			stmt.setString(3, member.getMemberId());
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
	// 관리자페이지에서 보이는 멤버수
	public int selectMemberCount() {
		int cnt = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 드라이버 로딩 ,연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "SELECT COUNT(*) FROM MEMBER";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리 실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("COUNT(*)");
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
		return cnt;
	}
	// 관리자가 멤버 리스트 띄울때 쓰는거
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> memberList = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		 OREDER BY createdate DESC
		 */
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			/*
			 SELECT member_no memberNo
				, member_id memberId
				, member_level memberLevel
				, member_name memberName
				, updatedate updateDate
				, createdate createDate 
				FROM member 
				ORDER BY createdate
				DESC LIMIT ?, ?;
			 */
			// 쿼리문 작성
			String sql = "SELECT member_no memberNo"
					+ " , member_id memberId"
					+ " , member_level memberLevel"
					+ " , member_name memberName"
					+ " , updatedate updateDate"
					+ " , createdate createDate "
					+ " FROM member ORDER BY member_no DESC LIMIT ?, ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 쿼리 실행
			rs = stmt.executeQuery();
			
			memberList = new ArrayList<Member>();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updateDate"));
				m.setCreatedate(rs.getString("createDate"));
				memberList.add(m);
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
		return memberList;
	}
	// 관리자가 멤버 강퇴 시킬때 쓰는거 회원 넘버로 삭제
	public int deleteMemberByAdmin(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "DELETE FROM member WHERE member_no = ?";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setInt(1, member.getMemberNo());
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
	
	// 로그인
	public Member login(Member paramMember) {	
		Member resultMember  = null;			
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement loginStmt = null;
		ResultSet loginRs = null;
		/*
		// 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		// 드라이버 연결
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "wkqk1234");
		--> DB를 연결하는 코드(명령들)가 Dao 메서드들에 거의 공통으로 중복되는 코드다.
		--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		--> 입력값과 반환값을 결정해야 한다.
		--> 입력값은 없다. 반환값은 Connection타입의 결과값이 남아야한다.
		*/
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String loginSql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM MEMBER WHERE member_id=? AND member_pw=PASSWORD(?)";
			// 쿼리 객체 생성
			loginStmt = conn.prepareStatement(loginSql);
			// 쿼리문 ?값 지정
			loginStmt.setString(1, paramMember.getMemberId()); // ?는 매개변수로 들어온 paramMember
			loginStmt.setString(2, paramMember.getMemberPw());
			// 쿼리 실행
			loginRs = loginStmt.executeQuery();
			if(loginRs.next( )) {
				resultMember = new Member();
				resultMember.setMemberId(loginRs.getString("memberId"));
				resultMember.setMemberName(loginRs.getString("memberName"));
				resultMember.setMemberLevel(loginRs.getInt("memberLevel"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(loginRs, loginStmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return resultMember;
	}
	
	// 아이디 중복 방지
	// 반환값 true:이미존재 false:사용가능
	public Boolean memberCk(String memberId) {
		boolean result = false;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement ckStmt = null;
		ResultSet ckRs = null;
		
		try {
			// 드라이버 로딩 , 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String ckSql = "SELECT member_id memberId FROM MEMBER WHERE member_id = ?";
			// 쿼리 객체 생성
			ckStmt = conn.prepareStatement(ckSql);
			// 쿼리문 ?값 지정
			ckStmt.setString(1, memberId);
			// 쿼리 실행
			ckRs = ckStmt.executeQuery();
			if(ckRs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(ckRs, ckStmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// 비번 중복 방지
	public Boolean memberPwCk(Member member) {
		boolean result = false;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "SELECT member_pw FROM MEMBER WHERE member_id = ? AND member_pw = PASSWORD(?)";
			// 쿼리객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw2());
			// 쿼리 실행
			rs = stmt.executeQuery();
			if(rs.next( )) {
				return true;
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
		return result;
	}
	
	
	// 회원가입
	// ()는 입력 받는 값
	public int insertMember(Member paramMember) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement insertStmt = null;
		/*
		// 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		// 드라이버 연결
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "wkqk1234");
		*/		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String insertSql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) "
					+ " VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
			// 쿼리 객체 생성
			insertStmt = conn.prepareStatement(insertSql);
			// 쿼리 ?값 지정
			insertStmt.setString(1, paramMember.getMemberId());
			insertStmt.setString(2, paramMember.getMemberPw() );
			insertStmt.setString(3, paramMember.getMemberName());
			
			 row = insertStmt.executeUpdate();
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
		/*
		if(row == 1) {
			System.out.println("회원가입 성공");
			dbUtil.close(null, insertStmt, conn);
			return 1;
		} else {
			System.out.println("회원가입 실패");
			dbUtil.close(null, insertStmt, conn);
			return 0;
		}	
		*/
	}
	
	// 회원정보 수정
	public int updateMember(Member paramMember) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String upSql = "UPDATE MEMBER SET member_name=? WHERE member_id=? AND member_pw=PASSWORD(?)";
			// 쿼리 객체 생성
			PreparedStatement upStmt = conn.prepareStatement(upSql);
			// 쿼리문 ?값 지정
			upStmt.setString(1, paramMember.getMemberName());
			upStmt.setString(2, paramMember.getMemberId());
			upStmt.setString(3, paramMember.getMemberPw());
			// 쿼리 실행
			row = upStmt.executeUpdate();
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
	
	// 비밀번호 수정
	
	public int pwUpMember(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문
			String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, member.getMemberPw2());
			stmt.setString(2, member.getMemberId());
			stmt.setString(3, member.getMemberPw());
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
	
	// 회원탈퇴	
	public int deleteMember(Member member) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			// 드라이버 로딩, 연결
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 쿼리문 작성
			String sql = "DELETE FROM MEMBER WHERE member_id=? AND member_pw= PASSWORD(?)";
			// 쿼리객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리문 ?값 지정
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			// 쿼리문 실행
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
