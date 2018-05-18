package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SignoutServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);//防止创建Session
		if(session == null){
			response.sendRedirect("main.jsp");
			return;
		}
		session.removeAttribute("account");
		session.removeAttribute("position");
		response.sendRedirect("main.jsp");
	}
}
