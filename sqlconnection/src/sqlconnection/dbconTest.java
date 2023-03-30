package sqlconnection;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.cj.xdevapi.PreparableStatement;

public class dbconTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 오류");
			e.printStackTrace();
			return; 
		} //2. 드라이브 로딩
		Connection conn = null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		try {
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/db2020", "root", "1234"); //3. DB 연결
			psmt=conn.prepareStatement("select * from book1"); //4. 쿼리 준비
			//psmt=conn.prepareStatement("insert into book1 valuse(16,'축구 역사','굿스포츠',70000)");
			rs=psmt.executeQuery(); //select만 executeQuery 나머지는 executeUpdate
			//psmt.executeUpdate();
			
			while(rs.next()) {
				int bookid=rs.getInt("bookid");
				int price=rs.getInt("price");
				String bookname=rs.getString("bookname");
				String publisher=rs.getString("publisher");
				System.out.println("도서명: "+bookname+" , 출판사: "+publisher+" , bookid: "+bookid+" , price: "+price);
				
			}	
			} catch (SQLException e) {
				System.out.println("DB 연결 오류");
				
			} finally {
				try {
					if(psmt!=null) psmt.close();
					if(conn!=null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				
			}
		} 
	}

