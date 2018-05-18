/*package dao;
  
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
  
public class DBUtil {
    public static void main(String[] args) {
  
        try {
            Class.forName("com.mysql.jdbc.Driver");
  
            // ���������ݿ��Connection����
            // ������Ҫ�ṩ��
            // ���ݿ������ڵ�ip:127.0.0.1 (����)
            // ���ݿ�Ķ˿ںţ� 3306 ��mysqlר�ö˿ںţ�
            // ���ݿ����� how2java
            // ���뷽ʽ UTF-8
            // �˺� root
            // ���� admin
  
            Connection c = DriverManager
                    .getConnection(
                            "jdbc:mysql://127.0.0.1:3306/keshe?characterEncoding=UTF-8",
                            "root", "123456");
  
            System.out.println("���ӳɹ�����ȡ���Ӷ��� " + c);
  
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