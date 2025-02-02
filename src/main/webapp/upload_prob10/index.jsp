<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,
				 java.lang.*,
				 java.util.*,
				 java.util.regex.*,
				 java.util.StringTokenizer,
				 java.util.Date, java.text.*,
				 java.text.SimpleDateFormat,
				 java.text.ParseException"
%>
<%
    String RootPath = application.getInitParameter("image");
    String[] tRootPath = DirectoryBrowser(RootPath);
    Cookie ck = new Cookie("gubun", "image");
    response.addCookie(ck);




%>


<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="">
    <title>:: CREHACKTIVE IMAGE BROWSER PANEL ::</title>
    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="./css/offcanvas.css" rel="stylesheet">
</head>

<body class="bg-light">
<main role="main" class="container">
    <div class="d-flex align-items-center p-3 my-3 text-white-50 bg-good rounded box-shadow">
        <img class="mr-3" src="logo.png" alt="" width="48" height="48">
        <div class="lh-100">
            <h6 class="mb-0 text-white lh-100">CREHACKTIVE IMAGE BROWSER PANEL</h6>
            <small>@ Since 2019 Create by CreHacktive</small>

        </div>
    </div>
    <div class="my-3 p-5 bg-white rounded box-shadow">
        <form action="upload.jsp" method="POST" enctype="multipart/form-data">
            <h6 class="border-bottom border-gray pb-2 mb-0">Image Uploader</h6>
            <div class="media text-muted pt-3">
                <div class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                    <div class="d-flex justify-content-between align-items-center w-100">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="imgFile">
                            <label class="custom-file-label" for="fileInput">Choose Image file</label>
                        </div>
                    </div>
                    <br>
                    <center><input type="submit" class="btn btn-outline-danger" value="Upload"></center>
                </div>
            </div>
        </form>
    </div>

    <div class="my-3 p-5 bg-white rounded box-shadow">
        <h6 class="border-bottom border-gray pb-2 mb-0">Image File List</h6>
        <%
            for (int i=0; i < tRootPath.length; i++) {
                if(tRootPath[i] != null) { %>
        <div class="media text-muted pt-3">
            <div class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <span class="text-gray-dark"><%=tRootPath[i]%></span>
                </div>
                <a href="imgViewer.jsp?file=<%=tRootPath[i]%>" target="blank">[VIEW]</a>
            </div>
        </div>
        <%
                }
            }
        %>
        <small class="d-block text-right mt-3">
            <a href="#">Move to top</a>
        </small>
    </div>
</main>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#customFile").on('change', function(){  // 값이 변경되면

            if(window.FileReader){  // modern browser
                var filename = $(this)[0].files[0].name;
            } else {  // old IE
                var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
            }
            // 추출한 파일명 삽입

            $("label[for='fileInput']").text(filename);
        });
    });
</script>
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="./js/jquery-slim.min.js"><\/script>')</script>
<script src="./js/popper.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/offcanvas.js"></script>
</body>
</html>
<%!
    public static String[] DirectoryBrowser(String RootPath)
    {
        String File_List = "";
        String FileName = "";
        int idx = 0;
        File FindDir = new File(RootPath);
        if (!FindDir.exists() || !FindDir.isDirectory()) {
            // 디렉터리가 없을 경우 예외 처리
            return new String[0];  // 빈 배열 반환
        }


        String[] FindFile = FindDir.list();
        if (FindFile == null) {
            return new String[0];  // 빈 배열 반환
        }

        String[] FileArr = new String[FindFile.length];

        for (int i = 0; i < FindFile.length; i++) {
            File fp = new File(FindDir + "/" + FindFile[i]) ;

            if ( fp.isDirectory() == false ) {
                FileArr[idx] = FindFile[i];
                idx = idx + 1;
            }
        }

        return FileArr ;
    }%>