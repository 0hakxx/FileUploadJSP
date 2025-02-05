<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,
				 java.lang.*,
				 java.util.*"
%>

<%
    // 클라이언트로부터 'file' 파라미터를 받아옴
    String fileName = request.getParameter("file");

    // 파일 다운로드 취약점 보안 코드
    // 백슬래시를 슬래시로 변경하여 경로 조작 방지
    fileName = fileName.replace("\\", "/");
    // '../'를 제거하여 상위 디렉토리 접근 방지
    fileName = fileName.replace("../", "");

    // 파일 확장자 추출
    String ext = fileName.substring(fileName.lastIndexOf('.')+1).toLowerCase();
    // Content-Type 헤더 설정
    response.setHeader("Content-Type","image/"+ext);
    // 파일명 인코딩 변환 (8859_1에서 euc-kr로)
    String filename2 = new String(fileName.getBytes("8859_1"),"euc-kr");
    // 이미지 파일 경로 설정
    String path = application.getInitParameter("image");
    // 파일 객체 생성
    File file = new File(path+fileName);
    // 파일 크기만큼의 바이트 배열 생성
    byte b[] = new byte[(int)file.length()];
    // 파일이 존재하는 경우 실행
    if(file.isFile()){
        // 파일 입력 스트림 생성
        BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
        // 응답 출력 스트림 생성
        BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
        int read = 0;
        // 파일 내용을 읽어 응답 스트림에 쓰기
        while ((read=fin.read(b))!=-1){
            outs.write(b,0,read);
        }
        // 스트림 닫기
        outs.close();
        fin.close();
    }

%>
