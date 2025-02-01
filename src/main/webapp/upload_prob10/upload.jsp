<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, java.io.*" %>
<%
    Cookie[] cookies = request.getCookies() ;
    String gubun = "";

    if(cookies != null){
        for(int i=0; i < cookies.length; i++){
            Cookie c = cookies[i] ;
            if(c.getName().equals("gubun")) {
                gubun = c.getValue();
            }
        }
    }

    if(gubun == null) {
        out.println("<script>alert('정상적인 접근이 아닙니다.');history.back(-1);</script>");
        return;
    }

    String path = application.getInitParameter(gubun);
    try {
        MultipartRequest multi = new MultipartRequest(request, path, 1024*10, "UTF-8");
    } catch(Exception e) {
        out.println("Error");
    }
    
%>
<script>location.href="index.jsp";</script>