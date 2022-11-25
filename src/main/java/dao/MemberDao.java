package dao;

import vo.Member;

import java.util.*;

import java.sql.*;

import util.*;

public class MemberDao {
	// 관리자 : 멤버레벨수정
	public int updateMemberLevel(Member member) throws Exception {
		return 0;
	}
	// 관리자페이지에서 보이는 멤버수
	public int selectMemberCount() throws Exception {
		return 0;
	}
	// 관리자가 멤버 리스트 띄울때 쓰는거
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		/*
		 OREDER BY createdate DESC
		 */
		return null;
	}
	// 관리자가 멤버 강퇴 시킬때 쓰는거 회원 넘버로 삭제
	public int deleteMemberByAdmin(Member member) throws Exception {
		
		return 0;
	}
	// 회원 탈퇴 회원 넘버와 비밀번호로 삭제
	public int deleteMember(Member member) throws Exception {
		
		return 0;
	}
	// 로그인
	public Member login(Member paramMember) throws Exception {	

		Member resultMember  = null;			
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
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문 작성
		String loginSql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM MEMBER WHERE member_id=? AND member_pw=PASSWORD(?)";
		// 쿼리 객체 생성
		PreparedStatement loginStmt = conn.prepareStatement(loginSql);
		// 쿼리문 ?값 지정
		loginStmt.setString(1, paramMember.getMemberId()); // ?는 매개변수로 들어온 paramMember
		loginStmt.setString(2, paramMember.getMemberPw());
		// 쿼리 실행
		ResultSet loginRs = loginStmt.executeQuery();
		if(loginRs.next( )) {
			resultMember = new Member();
			resultMember.setMemberId(loginRs.getString("memberId"));
			resultMember.setMemberName(loginRs.getString("memberName"));
			resultMember.setMemberLevel(loginRs.getInt("memberLevel"));
		}
		
		
		loginRs.close();
		loginStmt.close();
		conn.close(); // 반납		
		return resultMember;
	}
	// 아이디 중복 방지
	// 반환값 true:이미존재 false:사용가능
	public Boolean memberCk(String memberId) throws Exception {
		// 드라이버 로딩 , 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문 작성
		String ckSql = "SELECT member_id memberId FROM MEMBER WHERE member_id = ?";
		// 쿼리 객체 생성
		PreparedStatement ckStmt = conn.prepareStatement(ckSql);
		// 쿼리문 ?값 지정
		ckStmt.setString(1, memberId);
		// 쿼리 실행
		ResultSet ckRs = ckStmt.executeQuery();
		if(ckRs.next()) {
			ckRs.close();
			ckStmt.close();
			conn.close();
			return true;
		} else {
			dbUtil.close(ckRs, ckStmt, conn);
			return false;
		}		
	}
	
	
	// 회원가입
	// ()는 입력 받는 값
	public int insertMember(Member paramMember) throws Exception {
		int row = 0;
		/*
		// 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		// 드라이버 연결
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "wkqk1234");
		*/		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문 작성
		String insertSql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) "
				+ " VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		// 쿼리 객체 생성
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		// 쿼리 ?값 지정
		insertStmt.setString(1, paramMember.getMemberId());
		insertStmt.setString(2, paramMember.getMemberPw() );
		insertStmt.setString(3, paramMember.getMemberName());
		
		 row = insertStmt.executeUpdate();
		 
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
	public int updateMember(Member paramMember) throws Exception {
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문 작성
		String upSql = "UPDATE MEMBER SET member_name=? WHERE member_id=? AND member_pw=PASSWORD(?)";
		// 쿼리 객체 생성
		PreparedStatement upStmt = conn.prepareStatement(upSql);
		// 쿼리문 ?값 지정
		upStmt.setString(1, paramMember.getMemberName());
		upStmt.setString(2, paramMember.getMemberId());
		upStmt.setString(3, paramMember.getMemberPw());
		// 쿼리 실행
		int row = upStmt.executeUpdate();
		
		if(row == 1) {
			upStmt.close();
			conn.close();
			return 1;
		} else {
			upStmt.close();
			conn.close();
			return 0;
		}
	}
	
	// 비밀번호 수정
	
	public int pwUpMember(Member member) throws Exception {
		int row = 0;
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리문
		String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
		// 쿼리 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 쿼리문 ?값 지정
		stmt.setString(1, member.getMemberPw2());
		stmt.setString(2, member.getMemberId());
		stmt.setString(3, member.getMemberPw());
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
	
	
	
	
	
	
	
}
