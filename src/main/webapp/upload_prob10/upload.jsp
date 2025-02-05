<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, java.io.*" %>
<%
    // 요청에서 모든 쿠키를 가져옵니다
    Cookie[] cookies = request.getCookies() ;
    String gubun = "";

    // 쿠키가 존재하는지 확인하고 'gubun' 쿠키를 찾습니다
    if(cookies != null){
        for(int i=0; i < cookies.length; i++){
            Cookie c = cookies[i] ;
            if(c.getName().equals("gubun")) {
                gubun = c.getValue();
            }
        }
    }

    // 'gubun' 쿠키가 없으면 경고 메시지를 표시하고 이전 페이지로 돌아갑니다
    if(gubun == null) {
        out.println("<script>alert('정상적인 접근이 아닙니다.');history.back(-1);</script>");
        return;
    }

    // 'gubun' 값을 사용하여 애플리케이션 파라미터에서 파일 경로를 가져옵니다
    String path = application.getInitParameter(gubun);
    try {
        // 파일 업로드를 처리하기 위해 MultipartRequest 객체를 생성합니다
        // 최대 파일 크기는 10KB (1024*10 바이트)로 설정됩니다
        MultipartRequest multi = new MultipartRequest(request, path, 1024*10, "UTF-8");
    } catch(Exception e) {
        // 파일 업로드 중 오류가 발생하면 "Error"를 출력합니다
        out.println("Error");
    }

%>
<!-- 처리 후 index.jsp로 리다이렉트합니다 -->
<script>location.href="index.jsp";</script>
