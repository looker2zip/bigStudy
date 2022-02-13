<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>라디오 단추와 체크 버튼 요청 처리 예제</h1>
  <form action="RequestPro.jsp" method="post">
    <table border="1" width="400">
      <tr>
        <td>이름</td>
        <td>
          <input type="text" name="name">
        </td>
      </tr>
      <tr>
        <td>성벌</td>
        <td>
          &nbsp;남<input type="radio" name="gender" value="mail">
          &nbsp;여<input type="radio" name="gender" value="femail">
        </td>
      </tr>
 <tr>
        <td>취미</td>
        <td>
          &nbsp;독서<input type="checkbox" name="hobby" value="독서">
          &nbsp;게임<input type="checkbox" name="hobby" value="게임">
          &nbsp;TV시청<input type="checkbox" name="hobby" value="TV시청">
          &nbsp;축구<input type="checkbox" name="hobby" value="축구">
          &nbsp;기타<input type="checkbox" name="hobby" value="기타">
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <p align="center">
            <input type="submit" value="전송">
          </p>
        </td>
      </tr>
    </table>
  </form>
  
</body>
</html>
