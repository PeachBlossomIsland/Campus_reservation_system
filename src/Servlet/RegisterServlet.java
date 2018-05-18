package Servlet;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DA0.Student;
import DA0.StudentDAO;
import DA0.Teacher;
import DA0.TeacherDAO;

public class RegisterServlet extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");  
		request.setCharacterEncoding("UTF-8");//锟斤拷锟斤拷锟揭拷锟斤拷锟斤拷诨锟饺★拷锟斤拷牟锟斤拷锟�
		System.getProperty("file.encoding");
		String name = request.getParameter("name");
        String id = request.getParameter("account");
        String password = request.getParameter("password");
        password=MD5.MD5(password);
        String check=request.getParameter("check");
        String sex= request.getParameter("sex");
        //锟斤拷锟节斤拷师锟斤拷院系锟斤拷锟斤拷学锟斤拷锟斤拷专业,锟斤拷锟斤拷玫锟斤拷锟斤拷枪锟斤拷锟絭alue锟斤拷英锟侥的ｏ拷锟斤拷要转锟斤拷锟斤拷锟斤拷锟侥碉拷锟节存到锟斤拷锟捷匡拷
        String dep= request.getParameter("dep");
        System.out.println("RegisterServlet");
       // System.out.println(dep);
        //锟斤拷英锟斤拷转锟斤拷为锟斤拷锟斤拷
        switch(dep)
        {
        case "Computer":dep="计算机学院";break;
        case "eng":dep="理学院";break;
        case "ocean":dep="船舶海洋学院";break;
        case "info":dep="信息学院";break;
        }
        switch(sex)
        {
        case "boy":sex="男";break;
        case "girl":sex="女";break;
        }
        boolean is_id;//锟斤拷注锟斤拷锟斤拷锟叫讹拷锟斤拷锟斤拷屎锟斤拷欠锟斤拷丫锟阶拷锟斤拷锟斤拷
        //锟角斤拷师
        if(check.equals("tea"))
        {
        	System.out.println("tea");
        	//锟剿号猴拷锟斤拷锟诫都锟斤拷确;
        	is_id=TeacherDAO.isExist(id);
        	System.out.println("is_id:"+is_id);
        	//锟矫伙拷锟斤拷锟斤拷
        	if(is_id)
        	{//锟斤拷锟斤拷撕锟斤拷丫锟斤拷锟阶拷锟斤拷锟�
        		PrintWriter out = response.getWriter();//通锟斤拷servlet锟斤拷dopost锟斤拷锟斤拷锟斤拷取response锟斤拷锟斤拷通锟斤拷getWriter锟斤拷锟斤拷锟斤拷取PrintWriter锟斤拷锟斤拷
                out.flush();//锟斤拷栈锟斤拷锟�
                out.println("<script>");//锟斤拷锟絪cript锟斤拷签
                out.println("alert('This account has been registered, please login!');");//js锟斤拷洌猴拷锟斤拷alert锟斤拷锟�
                out.println("history.back();");//js锟斤拷洌猴拷锟斤拷锟斤拷页锟斤拷锟斤拷锟斤拷锟�
                out.println("</script>");//锟斤拷锟絪cript锟斤拷尾锟斤拷签	
        	}else {
        		Teacher teacher=new Teacher();
        		teacher.setId(id);
        		teacher.setName(name);
        		teacher.setPasswd(password);
        		teacher.setSex(sex);
        		teacher.setDepartment(dep);
        		TeacherDAO.add(teacher);
        		System.out.println(id+name+password+sex+dep);
        		//锟斤拷页锟斤拷锟截讹拷锟津到碉拷陆页锟斤拷
        		response.sendRedirect("login.html");
        	}
        }else {
        	//学锟斤拷
        	//锟剿号猴拷锟斤拷锟诫都锟斤拷确;
        	System.out.println("stu");
        	try {
        		is_id=StudentDAO.isExist(id);
        		System.out.println("is_id:"+is_id);
        		//锟矫伙拷锟斤拷锟斤拷
            	if(is_id)
            	{
            		//锟斤拷锟斤拷撕锟斤拷丫锟斤拷锟阶拷锟斤拷锟�
            		PrintWriter out = response.getWriter();//通锟斤拷servlet锟斤拷dopost锟斤拷锟斤拷锟斤拷取response锟斤拷锟斤拷通锟斤拷getWriter锟斤拷锟斤拷锟斤拷取PrintWriter锟斤拷锟斤拷
                    out.flush();//锟斤拷栈锟斤拷锟�
                    out.println("<script>");//锟斤拷锟絪cript锟斤拷签
                    out.println("alert('This account has been registered, please login!');");//js锟斤拷洌猴拷锟斤拷alert锟斤拷锟�
                    out.println("history.back();");//js锟斤拷洌猴拷锟斤拷锟斤拷页锟斤拷锟斤拷锟斤拷锟�
                    out.println("</script>");//锟斤拷锟絪cript锟斤拷尾锟斤拷签	
            	}else {
            	
            		Student student=new Student();
            		student.setId(id);
            		student.setName(name);
            		student.setPasswd(password);
            		student.setSex(sex);
            		student.setProfession(dep);
            		for(int i=0;i<5;i++) 
            		{
            			System.out.println(student.getId());
            		}
            		StudentDAO.add(student);
            		System.out.println(id+name+password+sex+dep);
            		//锟斤拷页锟斤拷锟截讹拷锟津到碉拷陆页锟斤拷
            		response.sendRedirect("login.html");
            	}
        		
        	}catch(Exception ex)
        	{
        		System.out.println("is_id_error"+ex);
        	}
        	
        }
     
	}
}
