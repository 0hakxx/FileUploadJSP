<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,
				 java.lang.*,
				 java.util.*"
%>

<%
    String fileName = request.getParameter("file");

    // 파일 다운로드 취약점 보안 코드
    fileName = fileName.replace("\\", "/");
    fileName = fileName.replace("../", "");

    String ext = fileName.substring(fileName.lastIndexOf('.')+1).toLowerCase();
    response.setHeader("Content-Type","image/"+ext);
    String filename2 = new String(fileName.getBytes("8859_1"),"euc-kr");
    String path = application.getInitParameter("image");
    File file = new File(path+fileName);
    byte b[] = new byte[(int)file.length()];
    if(file.isFile()){
        BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
        BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
        int read = 0;
        while ((read=fin.read(b))!=-1){
            outs.write(b,0,read);
        }
        outs.close();
        fin.close();
    }

%>