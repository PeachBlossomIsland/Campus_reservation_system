package Servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DA0.Stu_Tea_WtimeDAO;
import DA0.Student;
import DA0.StudentDAO;
import DA0.Teacher;
import DA0.TeacherDAO;
import DA0.Teacher_FtimeDAO;
import net.sf.json.JSONArray;

public class TeainfoServlet extends HttpServlet {
	
	  protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
		  	request.setCharacterEncoding("utf-8");
	        response.setCharacterEncoding("utf-8");
	        String kind = request.getParameter("k");
	        String time = request.getParameter("t");
	        String ac=request.getParameter("ac");
	        String html=null;
	        System.out.println("TeainfoServlet"+kind+" "+time+" "+ac);
	        time=time.toString();
	        if (kind.trim().equals("tea_change_passwd"))
	        {	
	        	//教师改密码
	        	time=MD5.MD5(time);
	        	TeacherDAO.updatePasswd(ac, time);
	        	System.out.println("tea_change_passwd"+ac+time);
	        	response.getWriter().write("<script language='javascript'>alert('Password modification success!');window.history.back(-1);</script>;");
	        }else if(kind.trim().equals("stu_change_passwd")) {
	        	time=MD5.MD5(time);
	        	StudentDAO.updatePasswd(ac, time);
	        	System.out.println("change_passwd"+ac+time);
	        	response.getWriter().write("<script language='javascript'>alert('Password modification success!');window.history.back(-1);</script>;");
	        }    
	        else if(kind.trim().equals("red")) {
	        	//教师设置空闲时间,返回前端的数据就是num
	        	String num=request.getParameter("num");
	        	Teacher_FtimeDAO.addFtime(ac,time,num);
	        	System.out.println("red"+"ac:"+ac+"time:"+time+"num "+num);
	        	html=num;
	        	response.getWriter().write(html);
	        }else if(kind.trim().equals("green")) {
	        	//教师取消设置的空闲时间
	        	Teacher_FtimeDAO.deleteFtime(ac, time);
	        	System.out.println("green"+ac+time);
	        	html="canceltime_succeed";
	        	response.getWriter().write(html);
	        }else if(kind.trim().equals("tea_yellow"))
	        {
	        	/*
	        	*教师预约学生的预约;
	        	 * 修改的地方有二个：
	        	 * 1.将tea_ftime表中的工号-时间的记录删除,
	        	 * 2.将stu_tea_wtime表中的所有的工号-时间的预约记录删除
	        	 */
	        	Teacher_FtimeDAO.deleteFtime(ac, time);
	        	Stu_Tea_WtimeDAO.deleteteawtime(ac,time);
	        	System.out.println("tea_yellow:"+ac+" "+time);
	        }else if(kind.trim().equals("stu_yellow")) {
	        	//这个是学生取消预约信息的;
	        	//一个是修改stu_tea_wtime表，将学生-教师-时间的记录删除，
	        	//一个是修改tea_ftime表，这个中的num字段的含义是还可以预约的人数，将人数+1
	        	String tea_id=request.getParameter("tea_id");
	        	Stu_Tea_WtimeDAO.deletesnowtime(ac, time);
	        	//修改可预约的人数
	        	System.out.println("stu_yellow:ac"+ac+" time:"+time+"tea_id:"+tea_id);
	        	System.out.println("Teacher_FtimeDAO.getupdatenum(ac, time)"+Teacher_FtimeDAO.getupdatenum(tea_id, time));
	        	Teacher_FtimeDAO.updatenum(tea_id, time,String.valueOf(Integer.parseInt(Teacher_FtimeDAO.getupdatenum(tea_id, time))+1));
	        	html="cacel_appointment_succeed";
	        	response.getWriter().write(html);
	        }
	        else if(kind.trim().equals("tea_p_info")) {
	        	Teacher tea=TeacherDAO.get(ac);
	        	List pinfo=new ArrayList<String>();
	        	pinfo.add(tea.getName());
	        	pinfo.add(tea.getSex());
	        	pinfo.add(tea.getDepartment());
	        	response.getWriter().write(JSONArray.fromObject(pinfo).toString());
	        	System.out.println("tea_p_info:"+ac+" "+time);
	        }else if(kind.trim().equals("tea_get_ftime")) {
	        	List<String> ftime=Teacher_FtimeDAO.getFtime(ac);
	        	List<String> list=new ArrayList<String>();
	        	for(int i=0;i<ftime.size();i++)
	        	{
	        		String t=ftime.get(i);
	        		String un=Teacher_FtimeDAO.getupdatenum(ac,t);
	        		String sn=Teacher_FtimeDAO.getstartnum(ac,t);
	        		if(un.equals(sn))
	        		{
	        			list.add(t);
	        			list.add(sn);
	        		}
	        		System.out.println("get_ftime:t"+t+" updatenum"+un+" startnum"+sn);
	        	}	
	        	response.getWriter().write(JSONArray.fromObject(list).toString());
	        	System.out.println("get_ftime:"+ac+" "+time);
	        }else if(kind.trim().equals("tea_get_rtime")) {
	        	//得到教师被预约的信息，包括：学生的人数，被预约的时间
	        	List<String> r_time=Stu_Tea_WtimeDAO.tgetWtime(ac);//老师的被预约的时间
	        	List<String> rtime=new ArrayList<String>();
	        	for(int i=0;i<r_time.size();i++)
	        	{
	        		//被预约的时间
	        		String t=r_time.get(i);
	        		rtime.add(t);
	        		rtime.add(String.valueOf(Stu_Tea_WtimeDAO.tgetsno(ac,t).size()));
	        		System.out.println("tea_get_rtime"+" ac:"+ac+" t："+t);
	        		System.out.println("人数:"+String.valueOf(Stu_Tea_WtimeDAO.tgetsno(ac,t).size()));
	        		System.out.println("tea_get_rtime"+" "+t);
	        	}
	        	response.getWriter().write(JSONArray.fromObject(rtime).toString());
	        }
	        else if(kind.trim().equals("appoint_get_time"))
	        {
	        	//首先得到老师的空闲时间;根绝这个时间，如果updatetime为0的说明已经预约满了，否则的话还没有预约满
	        	List<String> ftime=Teacher_FtimeDAO.getFtime(ac);
	        	List<String> list=new ArrayList<String>();
	        	for(int i=0;i<ftime.size();i++)
	        	{
	        		String t=ftime.get(i);
	        		String ftime_num=Teacher_FtimeDAO.getupdatenum(ac,t);
	        		list.add(t);
	        		list.add(ftime_num);
	        		System.out.println("appoint_get_time+t:"+t+"num:"+ftime_num);
	        	}
	        	response.getWriter().write(JSONArray.fromObject(list).toString());
	        	System.out.println("appoint_get_time: "+ac+" "+time);
	        }else if(kind.trim().equals("ap_time")) {
	        	//这个是appointment.jsp页面中，学生预约教师的信息；
	        	String sno=request.getParameter("sno");
	        	Stu_Tea_WtimeDAO.addwtime(sno, ac, time);
	        	Teacher_FtimeDAO.updatenum(ac, time,String.valueOf((Integer.parseInt(Teacher_FtimeDAO.getupdatenum(ac, time))-1)));
	        	System.out.println("ap_time");
	        	html="appointment_succeed";
	        	response.getWriter().write(html);
	        }else if(kind.trim().equals("stu_p_info")) {
	        	Student stu=StudentDAO.get(ac);
	        	List pinfo=new ArrayList<String>();
	        	pinfo.add(stu.getName());
	        	pinfo.add(stu.getSex());
	        	pinfo.add(stu.getProfession());
	        	response.getWriter().write(JSONArray.fromObject(pinfo).toString());
	        }else if(kind.trim().equals("stu_get_rtime")) {
	        	//学生得到自己的预约时间
	        	List<String> r_time=Stu_Tea_WtimeDAO.sgetWtime(ac);//根据学号得到预约时间
	        	List<String> list=new ArrayList<String>();
	        	for(int i=0;i<r_time.size();i++)
	        	{
	        		String t=r_time.get(i);
	        		//以预约时间-预约教师的顺序添加到列表
	        		list.add(t);
	        		list.add(Stu_Tea_WtimeDAO.sgettno(ac, t));
	        		System.out.println("time:"+t+"tno:"+Stu_Tea_WtimeDAO.sgettno(ac, t));
	        	}
	        	response.getWriter().write(JSONArray.fromObject(list).toString());
	        }else if(kind.trim().equals("sub_evaluate"))
	        {
	        	//t为时间，score为打的分数;ac为学生的学号，text为评价信息
	        	String score=request.getParameter("score");
	        	String evaluate=request.getParameter("text");
	        	System.out.println("sub_evaluate"+"score:"+score+" text:"+evaluate+" sno:"+ac+" time:"+time);
	        	Stu_Tea_WtimeDAO.addevaluate(ac, time, evaluate, score);
	        }else if(kind.trim().equals("set_pro_field"))
	        {
	        	//设置专业领域
	        	Teacher tea=TeacherDAO.get(ac);
	        	tea.setprof(time);
	        	TeacherDAO.updateAll(tea);
	        	System.out.println("set_pro_field"+"text:"+time);
	        	response.getWriter().write("<script language='javascript'>alert('Set up a professional success!');window.history.back(-1);</script>;");
	        }else if(kind.trim().equals("get_evaluation"))
	        {
	        	System.out.println("get_evaluation");
	        	//以学生学号，时间，评价的顺序写入到list中,get_evaluation
	        	//首先得到教师被预约的时间
	        	List<String> rtime=Stu_Tea_WtimeDAO.tgetWtime(ac);
	        	List<String> list=new ArrayList<String>();
	        	for(int i=0;i<rtime.size();i++)
	        	{
	        		String t=rtime.get(i);
	        		//得到这个时间点预约老师的学生的学号
	        		List<String> sno_list=Stu_Tea_WtimeDAO.tgetsno(ac, t);
	        		List<String> evaluation=Stu_Tea_WtimeDAO.getevaluate(ac, t);
	        		if(sno_list.size()==evaluation.size())
	        		{
	        			for(int j=0;j<sno_list.size();j++)
	        			{
	        				list.add(sno_list.get(j));
	        				list.add(t);
	        				list.add(evaluation.get(j));
	        				System.out.println("get_evaluation：sno:"+sno_list.get(j)+" t:"+t+" evaluation:"+evaluation.get(j));
	        			}
	        		}else {
	        			System.out.println("get_evaluation中学生的个数和时间不同");
	        		}
	        		
	        	}
	        	response.getWriter().write(JSONArray.fromObject(list).toString());
	        }else if(kind.trim().equals("get_commpro"))
	        {
	        	//这个是得到老师的预约信息的，以 学生学号-时间为顺序的
	        	//以学生学号，时间，评价的顺序写入到list中,get_evaluation
	        	//首先得到教师被预约的时间
	        	List<String> rtime=Stu_Tea_WtimeDAO.tgetWtime(ac);
	        	List<String> list=new ArrayList<String>();
	        	for(int i=0;i<rtime.size();i++)
	        	{
	        		String t=rtime.get(i);
	        		//得到这个时间点预约老师的学生的学号
	        		List<String> sno_list=Stu_Tea_WtimeDAO.tgetsno(ac, t);
	        		for(int j=0;j<sno_list.size();j++)
	        		{
	        			list.add(sno_list.get(j));
	        			list.add(t);
	        			System.out.println("get_commpro t:"+t+" sno:"+sno_list.get(j));
	        		}
	        	}
	        	response.getWriter().write(JSONArray.fromObject(list).toString());
	        }else {
	        	System.out.println("else");
	        }
	    }
}
