<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>라디오버튼과 체크박스 요청 처리 결과 뷰 화면</h1>
    <table border="1" width="400">
      <tr>
        <td>이름</td>
        <td>
          <%=request.getParameter("name") %>
        </td>
      </tr>
      <tr>
		<td>성벌</td>
        <td>
          <%
            if(request.getParameter("gender").equals("mail")){
          %>
              남자
          <%  
            }else{
          %>
              여자
          <%    
            }
          %>
        </td>
      </tr>
      <tr>
        <td>취미</td>
        <td>
          <%
            String[] hobby=request.getParameterValues("hobby");
            for(int i=0; i<hobby.length; i++){
          %>
            <%=hobby[i] %>&nbsp;&nbsp;
          <%              
            }
          %>
        </td>
      </tr>
    </table>

</body>
</html>
