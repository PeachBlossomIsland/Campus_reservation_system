<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%
String id="150420114";
Cookie username=new Cookie("account",id);
Cookie position=new Cookie("position","tea");
response.addCookie(username);
response.addCookie(position);
response.sendRedirect("main.jsp");
%>