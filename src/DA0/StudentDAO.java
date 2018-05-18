package DA0;



import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/*************************************************
 * 1.根据学号得到此学生的信息：Public Student get(string id);
2.往数据库中插入一个学生的全部信息：public void add(Student stu);(这个方法用于注册)
3.更新学生的全部信息：public void updateAll(Student stu);
4.根据学号修改密码：public void updatePasswd(string id,string spass);
5.根据学号删除学生信息：public void delete(string id);
6.在注册时根据学号判断学生是否存在：public boolean isExist(string id);存在返回真，否则返回假；
7.登陆时判断账号所对应的密码是否正确:public boolean isPasswd(string id,string spass);正确返回真，错误返回假
8.获取全部的学生信息 public static List<Student> getAllstudent()

 * @author LENOVO
 *
 */
public class StudentDAO {
	public static Student get(String sno) {
		Student bean = null;
		  
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
  
            String sql = "select * from student where sno ='" + sno+"'";
  
            ResultSet rs = s.executeQuery(sql);
  
            if (rs.next()) {
                bean = new Student();
                String name = rs.getString(2);
                String ssex = rs.getString(3);
                String pro = rs.getString(4);
                String spass = rs.getString(5);
                bean.setName(name);
                bean.setId(sno);
                bean.setSex(ssex);
                bean.setProfession(pro);
                bean.setPasswd(spass);
            }
  
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
        return bean;
	}
	public static void add(Student stu){
		String id = stu.getId();
		String name = stu.getName();
        String ssex = stu.getSex();
        String pro = stu.getProfession();
        String spass = stu.getPasswd();
        
        
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();){
        	String sql = "insert into student(sno,sname,ssex,pro,spass) values('"+id+"','"+name+"','"+ssex+"','"+pro+"','"+spass+"')";
        
        	s.execute(sql);
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
    }
	
	public static void updateAll(Student stu){
		String id = stu.getId();
		String name = stu.getName();
		String ssex = stu.getSex();
		String pro = stu.getProfession();
		String spass = stu.getPasswd();     
				try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement(); ) {
        	String sql = "update student set sname='"+name+"',ssex='"+ssex+"',pro='"+pro+"',spass='"+spass+"' where sno='"+id+"'";
			s.execute(sql);
			
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	public static void updatePasswd(String sno,String spass){
	
		String sql = "update student set spass= ?  where sno = ?";
		try (Connection c = DBUtil.getConnection();  PreparedStatement ps = c.prepareStatement(sql); ) {
            ps.setString(1, spass);
            ps.setString(2, sno);
			ps.execute();
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	public static void delete(String sno) {
		String sql = "delete from student where sno='"+sno+"'";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement(); ) {
			s.execute(sql);
	
	}catch (SQLException e) {
		  
        e.printStackTrace();
    }
	}
	
	public static boolean isExist(String sno)
	{
		String sql = "select * from student where sno='"+sno+"'";
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
	
	
	
	public static boolean isPasswd(String sno,String spass) {
        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
  
            String sql = "select * from student where sno = '" + sno+"'";
            ResultSet rs = s.executeQuery(sql);
            
            if (rs.next()) {
            
                String spass1 = rs.getString(5);
                System.out.println(spass1);
                System.out.println(spass);
                if(spass.equals(spass1))
            {
            	return true;
            }
            }
        } catch (SQLException e) {
  
            e.printStackTrace();
        }
		return false;  
	}
	public static List<Student> getAllstudent()
	{            
		List<Student> list=new ArrayList<Student>();
		String sql = "select * from student ";
		try (Connection c = DBUtil.getConnection();  Statement s = c.createStatement();) 
		{
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
                Student bean = new Student();
                String id = rs.getString(1);
                String name = rs.getString(2);
                String ssex = rs.getString(3);
                String pro = rs.getString(4);
                String spass = rs.getString(5);
                bean.setName(name);
                bean.setId(id);
                bean.setSex(ssex);
                bean.setProfession(pro);
                bean.setPasswd(spass);
                list.add(bean);
            }
			
		}catch (SQLException e) {
  
            e.printStackTrace();
        }
		return list;
		
	}
}