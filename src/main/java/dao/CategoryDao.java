package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	/* 페이징
	public int cntCategory() throws Exception {
		int cnt = 0;
		// db자원 초기화
		DBUtil dbUtil = new DBUtil();
		// db자원(jdbc api자원) 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 쿼리문 작성
		String sql = "SELECT COUNT(*) FROM category";
		// 쿼리 객체 생성
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		// 쿼리 실행
		rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("COUNT(*)"); 
		}
		return cnt;
	}
	*/	
	// admin -> updateCategoryForm.jsp 수정할때 필요한 value값 조회
	public Category selectCategory(int categoryNo) throws Exception {
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_name categoryName FROM category WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			category  = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));			
		}
		
		dbUtil.close(rs, stmt, conn);
		return category;
	}
	// admin -> updateaCategoryAction.jsp 수정
	public int updateCategoryName(Category category) throws Exception {
		int row = 0;
		
		String sql = "UPDATE category SET category_name = ?, updatedate = curdate() WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;		
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryNo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// admin -> deleteCategory.jsp ResultSet <- SELECT문의 결과값 가상의 테이블 View라고 부른다	
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
		String sql = "DELETE FROM category WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, categoryNo);
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception {
		int row = 0;
		
		// 쿼리작성
		String sql = "INSERT INTO category (category_kind, category_name, updatedate, createdate) values(?, ?, curdate(), curdate())";
		DBUtil dbUtil = new DBUtil();
		// db자원(jdbc api자원) 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		// 쿼리문 ?값 지정
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		stmt.setString(3, category.getUpdatedate());
		stmt.setString(4, category.getCreatedate());
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	
	
	// admin로그인 -> 카레고리관리 -> 카테고리목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		
		// 조회 쿼리문 작성
		String sql = "SELECT category_no categoryNo"
				+ " , category_kind categoryKind"
				+ " , category_name categoryName"
				+ " , updatedate"
				+ " , createdate"
				+ " FROM category";
		DBUtil dbUtil = new DBUtil();
		// db자원(jdbc api자원) 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1-셀렉트 절의 순서 컬럼이 한개만 있을때 쓴다
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate"));
			c.setCreatedate(rs.getString("createdate"));
			categoryList.add(c);
		}
		// db자원(jdbc api자원)반납
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
	
	// cash 입력시 <select>목록 출력
	public ArrayList<Category> selectCategoryList() throws Exception {		
		// 드라이버 로딩, 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 조회 쿼리문 작성
		String sql = "SELECT category_no categoryNo"
				+ " , category_kind categoryKind"
				+ " , category_name categoryName "
				+ " FROM category ORDER BY category_kind ASC";				
		// 쿼리 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		ArrayList<Category> categoryList = new ArrayList<Category>();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			
			categoryList.add(c);
		}
		
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
