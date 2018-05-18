/*package dao;
  
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
  
public class DBUtil {
    public static void main(String[] args) {
  
        try {
            Class.forName("com.mysql.jdbc.Driver");
  
            // 建立与数据库的Connection连接
            // 这里需要提供：
            // 数据库所处于的ip:127.0.0.1 (本机)
            // 数据库的端口号： 3306 （mysql专用端口号）
            // 数据库名称 how2java
            // 编码方式 UTF-8
            // 账号 root
            // 密码 admin
  
            Connection c = DriverManager
                    .getConnection(
                            "jdbc:mysql://127.0.0.1:3306/keshe?characterEncoding=UTF-8",
                            "root", "123456");
  
            System.out.println("连接成功，获取连接对象： " + c);
  
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
  
    }
}*/
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
   static String ip = "127.0.0.1";
   static int port = 3306;
   static String database = "keshe";
   static String encoding = "UTF-8";
   static String loginName = "root";
   static String password = "123456";

   static {
       try {
           Class.forName("com.mysql.jdbc.Driver");
       } catch (ClassNotFoundException e) {
           e.printStackTrace();
       }
   }

   public static Connection getConnection() throws SQLException {
       String url = String.format("jdbc:mysql://%s:%d/%s?characterEncoding=%s", ip, port, database, encoding);
       return DriverManager.getConnection(url, loginName, password);
   }
    
   public static void main(String[] args) throws SQLException {
       System.out.println(getConnection());
        
   }

}