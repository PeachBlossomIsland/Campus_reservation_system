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



public class TeacherDAO {
		public static Teacher get(String id) {
			Teacher bean = null;
			  
	        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
	  
	            String sql = "select * from teacher where tno ='" + id+"'";
	  
	            ResultSet rs = s.executeQuery(sql);
	  
	            if (rs.next()) {
	                bean = new Teacher();
	                String name = rs.getString(2);
	                String tsex = rs.getString(3);
	                String dep = rs.getString(4);
	                String tpass = rs.getString(5);
	                String prof = rs.getString(6);
	                bean.setName(name);
	                bean.setId(id);
	                bean.setSex(tsex);
	                bean.setDepartment(dep);
	                bean.setPasswd(tpass);
	                bean.setprof(prof);
	            }
	  
	        } catch (SQLException e) {
	  
	            e.printStackTrace();
	        }
	        return bean;
		}
	
	public static void add(Teacher tea) {
	String id = tea.getId();
	String name = tea.getName();
    String tsex = tea.getSex();
    String dep = tea.getDepartment();
    String tpass = tea.getPasswd();
    String prof = tea.getprof();
    try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();){
        String sql = "insert into teacher(tno,tname,tsex,tdep,tpass,prof) values('"+id+"','"+name+"','"+tsex+"','"+dep+"','"+tpass+"','"+prof+"')";
    	s.execute(sql);
   } catch (SQLException e) {

       e.printStackTrace();
   }
}
	public static void updateAll(Teacher tea){
		String id = tea.getId();
		String name = tea.getName();
		String tsex = tea.getSex();
		String dep = tea.getDepartment();
		String tpass = tea.getPasswd();
		String prof = tea.getprof();
		String sql = "update teacher set tname='"+name+"',tsex='"+tsex+"',tdep='"+dep+"',tpass='"+tpass+"',prof='"+prof+"' where tno='"+id+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement(); ) {
			 
			s.execute(sql);
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	
	public static void updatePasswd(String id,String tpass){
	
		String sql = "update teacher set tpass= ? where tno = ?";
		try (Connection c = DBUtil.getConnection();  PreparedStatement ps = c.prepareStatement(sql); ) {
			ps.setString(2, id);
            ps.setString(1, tpass);
			ps.execute();
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	
	public static void delete(String id){
		String sql = "delete from teacher where tno='"+id+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement(); ) {
			s.execute(sql);
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	
	public static boolean isExist(String id)
	{
		String sql = "select * from teacher where tno='"+id+"'";
		try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement(); ) {
			ResultSet rs = s.executeQuery(sql);
			if (rs.next()) {
				return true;
			}
			
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
		return false;
	}
	public static boolean isPasswd(String id,String tpass){
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
  
            String sql = "select * from teacher where tno = '" + id+"'";
  
            ResultSet rs = s.executeQuery(sql);
  
            if (rs.next()) {
                String tpass1 = rs.getString(5);
                if(tpass.equals(tpass1))
            {
            	return true;
            }
            }
            

        } catch (SQLException e) {
  
            e.printStackTrace();
        }
		return false;  
	}
	public static List<Teacher> getdepteacher(String dep)
	{
		List<Teacher> list=new ArrayList<Teacher>();
		String sql = "select * from teacher where tdep ='" +dep+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                Teacher bean = new Teacher();
                String id = rs.getString(1);
                String name = rs.getString(2);
                String tsex = rs.getString(3);
                String tdep = rs.getString(4);
                String tpass = rs.getString(5);
                String prof = rs.getString(6);
                bean.setName(name);
                bean.setId(id);
                bean.setSex(tsex);
                bean.setDepartment(tdep);
                bean.setPasswd(tpass);
                bean.setprof(prof);
                list.add(bean);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
		
		
		
	}
	
	
	
	public static List<Teacher> getAllteacher()
	{            
		List<Teacher> list=new ArrayList<Teacher>();
		String sql = "select * from teacher ";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                Teacher bean = new Teacher();
                String id = rs.getString(1);
                String name = rs.getString(2);
                String tsex = rs.getString(3);
                String dep = rs.getString(4);
                String tpass = rs.getString(5);
                String prof = rs.getString(6);
                bean.setName(name);
                bean.setId(id);
                bean.setSex(tsex);
                bean.setDepartment(dep);
                bean.setPasswd(tpass);
                bean.setprof(prof);
                list.add(bean);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
	}
	
	
	
	
	
	
	
	
}
