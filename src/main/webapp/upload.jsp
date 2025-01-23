<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%
    //업로드 되는 웹 디렉터리 지정
    String Path = "C:\\Users\\yeong\\IdeaProjects\\FileUploadJSP\\src\\main\\webapp\\upload";

    // - request: HTTP 요청 객체
    // - Path: 파일이 저장될 서버의 경로
    // - 1024*10: 최대 파일 크기를 10KB로 제한
    // - "UTF-8": 인코딩 방식 지정
    MultipartRequest multi = new MultipartRequest(request, Path, 1024 * 10 , "UTF-8");
    String filename = Path + "\\" + multi.getFilesystemName("userfile");
%>
<li>업로드 성공 ! 업로드 경로 : <%=filename%></li>
