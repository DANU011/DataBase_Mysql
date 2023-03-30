package sqlconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class ReadAlluser {
	public static void main(String[] args) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 오류");
			e.printStackTrace();
			return;
		} // 2. 드라이브 로딩
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0321", "root", "1234"); // 3. DB 연결
			psmt = conn.prepareStatement("select * from user"); // 4. 쿼리 준비
			rs = psmt.executeQuery(); // select만 executeQuery 나머지는 executeUpdate

			while (rs.next()) {
				
				String id = rs.getString("id");
				String name = rs.getString("name");
				String email = rs.getString("email");
				System.out.println("id: " + id + " , name: " + name + " , email: " + email);
			}
		} catch (SQLException e) {
			System.out.println("DB 연결 오류");

		}

	}
	
}

