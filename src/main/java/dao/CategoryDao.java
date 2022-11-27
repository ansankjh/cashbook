package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
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
