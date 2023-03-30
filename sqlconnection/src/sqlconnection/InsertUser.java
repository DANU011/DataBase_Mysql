package sqlconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class InsertUser {
	public static void main(String[] args) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println();
			e.printStackTrace();
			return;
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0321", "root", "1234");
			psmt = conn.prepareStatement("INSERT INTO USER VALUES ('kdk','정과장','456s@naver.com')");
			psmt.executeUpdate();
			System.out.println("A new book was inserted successfully!");
		} catch (SQLException e) {
			System.out.println("DB 연결 오류");
			e.printStackTrace();
		} finally {
			try {
				if (psmt != null) {
					psmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
