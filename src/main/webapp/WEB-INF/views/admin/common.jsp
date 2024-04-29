<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"href="<c:url value='/resources/css/admin_top.css'/>" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<div class="left-header">
	     <div class="mark">
	         <p>BEANS</p>
	     </div>
	     <div class="pageName">
	         <p class="head-p">회원 관리</p> 
	     </div>
	 </div>
	 <div class="right-header">
	     <div class="adminName head-p">
	         <p class="head-p">관리자 명</p><!-- 세션으로 받아서 회원관리처럼 이름 변경 -->
	     </div>
	     <div class="alarm-icon">
	         <i class="fa-solid fa-bell"></i>
	     </div>
	     <div class=>
	     	<button class="logout">로그아웃</button>
	     </div>
	 </div>
</body>
 
<script>
	var pageName = '${pageName}';
	if (pageName != '') {
		$('.pageName p').text(pageName);	
	}
	
</script>
</html>