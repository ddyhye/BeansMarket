<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="resources/css/detail.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
<header>
		<jsp:include page="./common.jsp"/>
	</header>
	<main>
		<jsp:include page="./nav.jsp"/>
		<section>
			<div class="container">
		   		<div class="memberP-top">
		   			<div class="memberP-top-1">
		   				<div class="memberP-top-head">
		   					<p>EMAIL</p>
		   				</div>
		   				<p>ahruru@email.com</p>
	   				</div>
	   				<div class="memberP-top-2">
		   				<div class="memberP-top-head">
		   					<p>NICNAME</p>
		   				</div>
		   				<p>아루루</p>
	   				</div>
	   				<div class="memberP-top-3">
		   				<div class="memberP-top-head">
		   					<p>주소 / 거래 범위</p>
		   				</div>
		   				<p>경기도 광명시 광명동 / 광명시</p>
	   				</div>
	   				<div class="memberP-top-4">
		   				<div class="memberP-top-head">
		   					<p>성별</p>
		   				</div>
		   				<p>남자</p>
	   				</div>
	   				<div class="memberP-top-5">
		   				<div class="memberP-top-head">
		   					<p>EMAIL</p>
		   				</div>
		   				<p>1999.06.18</p>
	   				</div>
	   				<div class="memberP-top-6">
		   				<div class="memberP-top-head">
		   					<p>Beans pay</p>
		   				</div>
		   				<p>1999.06.18</p>
		   				<p id="payUpdateBtn">잔액 변경</p>
	   				</div>
		   		</div>
		   		<div class="memberP-center"></div>
		   	</div>
 		</section>
	</main>

</body>

<script>
</script>
</html>