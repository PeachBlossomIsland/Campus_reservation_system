package DA0;


import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class Stu_Tea_WtimeDAO {
	public static void addwtime(String sno,String tno,String time){
		
        String sql = "insert into stu_tea_wtime(sno,tno,wtime) values('"+sno+"','"+tno+"','"+time+"')";
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();){
        	s.execute(sql);
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
    }
	
	public static void addevaluate(String sno,String time,String evaluate,String score) {
		String sql = "update stu_tea_wtime set evaluate='"+evaluate+"', score='"+score+"' where sno='"+sno+"'"+"and wtime='"+time+"'";
		try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();){
	        	s.execute(sql);
	        } catch (SQLException e) {
	  
	            e.printStackTrace();
	        }
		
		
	}
	public static void deletesnowtime(String sno,String time){
		String sql = "delete from stu_tea_wtime where sno='"+sno+"'and wtime='"+time+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement(); ) {
			s.execute(sql);
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	public static void deleteteawtime(String tno,String time) {
		String sql="delete from stu_tea_wtime where tno='"+tno+"'and wtime='"+time+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement(); ) {
			s.execute(sql);
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
		
	}
	
	public static List<String> sgetWtime(String sno){            
		List<String> list=new ArrayList<String>();
		String sql = "select * from stu_tea_wtime where sno='"+sno+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                String time = rs.getString(3);
                list.add(time);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
	}
	public static String sgettno(String sno,String time){            
		 String tno=new String();
		String sql = "select * from stu_tea_wtime where sno='"+sno+"' and wtime='"+time+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
             tno = rs.getString(2);

            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return tno;
		
	}
	public static List<String> tgetWtime(String tno){            
		List<String> list=new ArrayList<String>();
		String sql = "select wtime from stu_tea_wtime where tno='"+tno+"' group by wtime";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                String time = rs.getString(1);
                list.add(time);
            }
			
		}catch (SQLException e) {
            e.printStackTrace();
        }
		return list;
	}
	public static List<String> tgetsno(String tno,String time){            
		List<String> list=new ArrayList<String>();
		String sql = "select * from stu_tea_wtime where tno='"+tno+"' and wtime ='"+time+"'" ;
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                String sno = rs.getString(1);
                list.add(sno);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
	}
	public static List<String> getevaluate(String tno,String time){
		List<String> list=new ArrayList<String>();
		String sql = "select * from stu_tea_wtime where tno='"+tno+"' and wtime='"+time+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                String evalute = rs.getString(4);
                list.add(evalute);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
		
	}
	public static List<String> tgetscore(String tno,String time){
		List<String> list=new ArrayList<String>();
		String sql = "select * from stu_tea_wtime where tno='"+tno+"' and wtime='"+time+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                
                String score = rs.getString(5);
                list.add(score);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
		
	}
}
