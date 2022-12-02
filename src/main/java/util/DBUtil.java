package util;

import java.sql.*;
//  DBUtil에 있는 getConnection()메서드는 conn을 남긴다.
public class DBUtil {
	public Connection getConnection() throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");		
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "wkqk1234");
		
		return conn;
	}
	public void close(ResultSet rs, PreparedStatement stmt , Connection conn) throws Exception {
		if(rs != null) {
			rs.close();
		}
		if(rs != null) {
			stmt.close();
		}
		if(rs != null) {
			conn.close();
		}		
	}
}
