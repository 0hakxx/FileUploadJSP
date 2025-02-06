<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, java.io.*, java.util.Enumeration" %>
<%
    String path = request.getRealPath("/cos_example1/upload");

    MultipartRequest multi = new MultipartRequest(request, path, 1024*10*10, "UTF-8");
    Enumeration formNames = multi.getFileNames();

    while(formNames.hasMoreElements()) {
        String param = (String)formNames.nextElement();
        String fileName = multi.getFilesystemName(param);
        int extOffset = fileName.lastIndexOf(".");
        String fileExt = fileName.substring(extOffset+1).toLowerCase();

        if(!fileExt.equals("jpg") && !fileExt.equals("png") && !fileExt.equals("gif")) {
            File fp = new File(path, fileName);
            fp.delete();
            out.println("<script>alert('허용된 확장자가 아닙니다.');history.back(-1);</script>");
            return;
        }

        out.println("<script>alert('\\'"+fileName+"\\' 업로드 성공!');location.href='index.jsp'</script>");
    }
%>