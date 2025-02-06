<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, java.io.*, java.util.Enumeration" %>
<%
    //취약한 소스코드(file 파라미터만 검증)
    String path = "C:\\Users\\yeong\\IdeaProjects\\FileUploadJSP\\src\\main\\webapp\\cos_example1\\upload";

    MultipartRequest multi = new MultipartRequest(request, path, 1024*10*10, "UTF-8");

    String filename = multi.getFilesystemName("file");
    if(filename != null) {
        int wextOffset = filename.lastIndexOf(".");
        String filext = filename.substring(wextOffset+1).toLowerCase();

        if(!filext.equals("jpg") && !filext.equals("png") && !filext.equals("gif")) {
            File fp = new File(path, filename);
            fp.delete();
            out.println("<script>alert('이미지 파일만이 허용됩니다.');history.back(-1);</script>");
            return;
        }
        out.println("<script>alert(\""+filename+"\" 업로드 성공);location.href='index.jsp'</script>");
    }
    //안전한 소스코드(모든 파라미터 검증)
//    String path = "C:\\Users\\yeong\\IdeaProjects\\FileUploadJSP\\src\\main\\webapp\\cos_example1\\upload";
//
//    MultipartRequest multi = new MultipartRequest(request, path, 1024*10*10, "UTF-8");
//    Enumeration formNames = multi.getFileNames();
//
//    while(formNames.hasMoreElements()) {
//        String param = (String)formNames.nextElement();
//        String fileName = multi.getFilesystemName(param);
//        int extOffset = fileName.lastIndexOf(".");
//        String fileExt = fileName.substring(extOffset+1).toLowerCase();
//
//        if(!fileExt.equals("jpg") && !fileExt.equals("png") && !fileExt.equals("gif")) {
//            File fp = new File(path, fileName);
//            fp.delete();
//            out.println("<script>alert('허용된 확장자가 아닙니다.');history.back(-1);</script>");
//            return;
//        }
//
//        out.println("<script>alert('\\'"+fileName+"\\' 업로드 성공!');location.href='index.jsp'</script>");
//    }
%>