package Servlet;
//����һ�β��Դ���


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DA0.StudentDAO;
import DA0.TeacherDAO;

public class LoginServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");  
		request.setCharacterEncoding("UTF-8");//�����Ҫ�����ڻ�ȡ���Ĳ���
        String id = request.getParameter("account");
        String password = request.getParameter("password");
        password=MD5.MD5(password);
        String check=request.getParameter("check");
        System.out.println("LoginServlet");
        boolean is_id=false;
    	boolean is_password=false;//���ݿ��е�����
    	String feedback_js=" ";//������������˵�jsҳ��
        //�ǽ�ʦ
        if(check.equals("tea"))
        {
        	//�˺ź����붼��ȷ;
        	is_id=TeacherDAO.isExist(id);
        	System.out.print("tea"+is_id);
        	System.out.println("tea:"+id);
        	System.out.println("tea:"+password);
        	//�û�����
        	if(is_id)
        	{
        		is_password=TeacherDAO.isPasswd(id,password);
        		System.out.print("tea"+is_password);
        		if(is_password)
        		{
        			//���û������浽session�У��Ա����ĸ�����ҳ��Ϣ��ʹ��
        			 HttpSession session=request.getSession();
        			 session.setAttribute("account",id);
        			 session.setAttribute("position", "tea");
        			//�����ض���
        			response.sendRedirect("main.jsp");
        			
        		}else {
        			 PrintWriter out = response.getWriter();//ͨ��servlet��dopost������ȡresponse����ͨ��getWriter������ȡPrintWriter����
                     out.flush();//��ջ���
                     out.println("<script>");//���script��ǩ
                     out.println("alert('The password is incorrect, please reenter it!');");//js��䣺���alert���
                     out.println("history.back();");//js��䣺�����ҳ�������
                     out.println("</script>");//���script��β��ǩ
        		}
        	}else {
        	//�û�������
        		 PrintWriter out = response.getWriter();//ͨ��servlet��dopost������ȡresponse����ͨ��getWriter������ȡPrintWriter����
                 out.flush();//��ջ���
                 out.println("<script>");//���script��ǩ
                 out.println("alert('This username does not exist, please register after landing!');");//js��䣺���alert���
                 out.println("history.back();");//js��䣺�����ҳ�������
                 out.println("</script>");//���script��β��ǩ
        	}
        	
        }else {
        	//ѧ��
        	//�˺ź����붼��ȷ;
        	is_id=StudentDAO.isExist(id);
        	System.out.println("stu:"+id);
        	System.out.println("stu:"+password);
        	System.out.print("stu"+is_id);
        	//�û�����
        	if(is_id)
        	{
        		is_password=StudentDAO.isPasswd(id,password);
        		System.out.print("stu"+is_password);
        		if(is_password)
        		{
        			//���û������浽session�У��Ա����ĸ�����ҳ��Ϣ��ʹ��
        			 HttpSession session=request.getSession();
        			 session.setAttribute("account",id);
        			 session.setAttribute("position", "stu");
        			//�����ض���
        			response.sendRedirect("main.jsp");
        		}else {
        			 PrintWriter out = response.getWriter();//ͨ��servlet��dopost������ȡresponse����ͨ��getWriter������ȡPrintWriter����
                     out.flush();//��ջ���
                     out.println("<script>");//���script��ǩ
                     out.println("alert('The password is incorrect, please reenter it!');");//js��䣺���alert���
                     out.println("history.back();");//js��䣺�����ҳ�������
                     out.println("</script>");//���script��β��ǩ
        		}
        	}else {
        	
        		 PrintWriter out = response.getWriter();
                 out.flush();//��ջ���
                 out.println("<script>");
                 out.println("alert('This username does not exist, please register after landing!');");
                 out.println("history.back();");
                 out.println("</script>");
        	}
        }
      	
	} 
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");  
		request.setCharacterEncoding("UTF-8");
		String type= request.getParameter("type");
		if(type=="sign_out")
		{
			System.out.println(type);
			request.getSession().removeAttribute("account");
			request.getSession().removeAttribute("position");
			System.out.println(type);
			response.sendRedirect("main.jsp");
		}
	}
}
