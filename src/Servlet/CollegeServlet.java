package Servlet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DA0.Teacher;
import net.sf.json.JSONArray;
import DA0.TeacherDAO;
public class CollegeServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
	  	request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String dep = request.getParameter("dep");
        System.out.println(dep);
        switch(dep)
        {
        case "Computer":dep="计算机学院";break;
        case "eng":dep="理学院";break;
        case "ocean":dep="船舶海洋学院";break;
        case "info":dep="信息学院";break;
        }
        System.out.println(dep);
        List<Teacher> list=DA0.TeacherDAO.getdepteacher(dep);
        List<String> dep_list=new ArrayList<String>();
        System.out.println(list.size());
        //这儿是以 工号-姓名-研究领域依次来得到的；
        for(int i=0;i<list.size();i++)
        {
        	dep_list.add(list.get(i).getId());
        	dep_list.add(list.get(i).getName());
        	dep_list.add(list.get(i).getprof());
        }
        System.out.println("CollegeServlet4");
        response.getWriter().write(JSONArray.fromObject(dep_list).toString());
	}
}
