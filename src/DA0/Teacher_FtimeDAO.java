package DA0;


import java.sql.ResultSet;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/****************************************
 * 3.1.根据工号号插入空闲时间：public void addFtime(string id,string time,String num);
4.根据工号和原来的空闲时间删除在数据库中的记录：
public void deleteFtime(string id,string time)
5.根据工号查询空闲时间：public List<string> getFtime(string id);
	public static List<String> getnum(String id)
		public static String getnum(String id,String time)
			public static void updatenum(String id,String time,String num)
 * @author LENOVO
 *
 */
public class Teacher_FtimeDAO {
	public static void addFtime(String tno,String time,String num){
		
        String sql = "insert into tea_ftime values('"+tno+"','"+time+"','"+num+"','"+num+"')";
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();){
        	s.execute(sql);
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
    }
	
	
	public static void deleteFtime(String tno,String time){
		String sql = "delete from tea_ftime where tno='"+tno+"' and ftime='"+time+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement(); ) {
			s.execute(sql);
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	public static void updatenum(String tno,String time,String updatenum){
		System.out.println("updatenum:");
		String sql = "update tea_ftime set updatenum= ?  where tno = ? and ftime=?";
		try (Connection c = DBUtil.getConnection();  PreparedStatement ps = c.prepareStatement(sql); ) {
            ps.setString(1, updatenum);
            ps.setString(2, tno);
            ps.setString(3, time);
			ps.execute();
//			System.out.println("updatenum:"+sql);
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	
	
	public static List<String> getFtime(String tno){            
		List<String> list=new ArrayList<String>();
		String sql = "select * from tea_ftime where tno='"+tno+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                String time = rs.getString(2);
                list.add(time);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
	}
	public static String getupdatenum(String tno,String time){     
	//	System.out.println("getupdatenum");
		String sql = "select * from tea_ftime where tno='"+tno+"' and ftime='"+time+"'";
		String num=null;
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                 num = rs.getString(3);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }

		return num;
	}
	public static String getstartnum(String tno,String time){            
		String sql = "select * from tea_ftime where tno='"+tno+"' and ftime='"+time+"'";
		String num=null;
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                 num = rs.getString(4);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }

		return num;
	}
}
