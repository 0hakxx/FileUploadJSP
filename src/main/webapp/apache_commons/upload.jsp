<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	boolean result = false;
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);

	if(isMultipart) {
		DiskFileItemFactory factory = new DiskFileItemFactory();		
		ServletFileUpload upload = new ServletFileUpload(factory);				
			
		List<FileItem> items = upload.parseRequest(request);
		Iterator<FileItem> itr = items.iterator();
				
		while(itr.hasNext()) {		
			FileItem item = itr.next();
			String fName = item.getFieldName();
			String userFileName = item.getName();
			String contentType = item.getContentType();
			long fileSize = item.getSize();
								
			if(!userFileName.isEmpty() && fileSize>0){				
				String dir = request.getSession().getServletContext().getRealPath("/apache_commons/upload");					
			
				File saveFilePath = new File(dir);						
				if(!saveFilePath.exists()){						
					saveFilePath.mkdir();					
				}

				item.write(new File(saveFilePath, userFileName));					
				out.println("<script>alert('\\'"+userFileName+"\\' 업로드 성공!');location.href='index.jsp'</script>");
				result = true;
			}
		}
	}
	
	if(!result) {
		out.println("<script>alert('파일이 존재하지 않습니다.');history.back(-1);</script>");
	}
%>
