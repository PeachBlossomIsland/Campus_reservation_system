package DA0;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class DBUtil {
    static  String ip = "127.0.0.1";
    static  int  port = 3306;
    static  String database = "keshe";
    static  String encoding = "UTF-8";
    static  String loginName = "root";
    static  String password = "123456";

   static {
       try {
           Class.forName("com.mysql.jdbc.Driver");
       } catch (ClassNotFoundException e) {
           e.printStackTrace();
       }
   }

   public static Connection getConnection() throws SQLException {
//	   String inf [] = new String [] {
//			   ip, port, database, encoding	   
//	   };
       String url = String.format("jdbc:mysql://%s:%d/%s?characterEncoding=%s",  ip,
    		   port, database, encoding);
       return DriverManager.getConnection(url, loginName, password);
   }
}