package dao;

import vo.Member;

import java.sql.*;

import util.*;

public class MemberDao {
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
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_name memberName FROM MEMBER WHERE member_id=? AND member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId()); // ?는 매개변수로 들어온 paramMember
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next( )) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			
		}
		
		
		rs.close();
		stmt.close();
		conn.close(); // 반납
		
		return paramMember;
	}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		/*
		// 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		// 드라이버 연결
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "wkqk1234");
		*/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		
		return resultRow;
	}
	
	
	
	
	
}
