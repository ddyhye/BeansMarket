com.beans.market<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}

th, td {
    padding: 5px 10px;
}
textarea {
	width: 500px;
    height: 150px;
    resize: none;
}

input[type="text"]{
	width:100%;
}

</style>
</head>

<body>
	<jsp:include page="../common.jsp" />
		<div class="container">
		<!--  여기 안에서 작업하기 -->
<form action="question/write" method="post" enctype="multipart/form-data">
  <table>
    <thead>
      <tr>
        <th>항목</th>
        <th>내용</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>제목</td>
        <td><input type="text" name="title" /></td>
      </tr>
      <tr>
        <td>카테고리</td>
        <td>
          <select name="category">
            <option value="userid" selected>계정</option>
            <option value="confirm">빈즈페이</option>
            <option value="auction">경매</option>
            <option value="picture">사진</option>
            <option value="etc">기타</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>작성자</td>
        <td><input type="text" name="user_name" value="${sessionScope.loginId}"/></td>
      </tr>
      <tr>
        <td>비밀번호</td>
        <td><input type="password" name="password" /></td>
      </tr>
      <tr>
        <td>상세 내용</td>
        <td><textarea name="details" rows="5" cols="30"></textarea></td>
      </tr>
      <tr>
        <td>첨부파일</td>
        <td><input type="file" name="photos" multiple="multiple"/></td>
      </tr>
    </tbody>
  </table>
  <input type="submit" value="확인"/>
</form>
		
		
		
		
		
		</div>


</body>

<script>
</script>
</html>