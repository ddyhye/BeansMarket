<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/common.css" type="text/css" />
<link rel="stylesheet" href="resources/css/detail.css" type="text/css" />
<link rel="stylesheet" href="resources/css/tempsave.css" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>
<body>
<jsp:include page="../common.jsp" />
<div class="tempsave">
	<p>임시저장 글 목록</p>
	<button onclick="location.href='saleOfgoods.jsp'">글쓰기</button>
	  <table>
	    <tr>
	      <td>글번호</td>
	      <td>제목</td>
	      <td>등록일시</td>
	      <td>삭제</td>
	    </tr>
	  </table>
</div>

</body>
<script>

</script>
</html>