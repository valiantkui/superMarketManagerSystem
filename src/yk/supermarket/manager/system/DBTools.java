package yk.supermarket.manager.system;
/**
 * jdbc连接数据库的封装类
 * @author KUIKUI
 */
/*import java.io.FileNotFoundException;
import java.io.IOException;*/
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/*import java.util.Properties;*/
public class DBTools {
	/**
	 * 获得jdbc连接
	 * 
	 */
	public static Connection getConnection()
	{
//		Properties proper=new Properties();
		try {
		/*	proper.load(new FileInputStream("database.properties"));
			String driver=proper.getProperty("jdbc.drivers");
			String url=proper.getProperty("jdbc.url");
			String username=proper.getProperty("jdbc.username");
			String password=proper.getProperty("jdbc.password");*/
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket","root","uAiqwVwjJ8-i");
	
		}catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 关闭Connection连接
	 */
	public static void close(Connection con)
	{
		if(con!=null)
		{
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 关闭Statement连接
	 */
	public static void close(Statement stat)
	{
		if(stat!=null)
		{
			try {
				stat.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 关闭ResultSet连接
	 */
	public static void close(ResultSet rs)
	{
		if(rs!=null)
		{
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}
