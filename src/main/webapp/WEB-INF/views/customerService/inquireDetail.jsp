<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<c:url value='/resources/css/inquire.css'/>" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>


<body>
	<jsp:include page="../common.jsp" />
	
	<div class="container">
		<div class="top">
			<i class="fa-solid fa-arrow-left"></i>
		</div>
		
		<div class="enquire">
			<div class="enquire-title">
				<c:if test="${success eq 'N'}">
				    <p class="inquire-mark">처리중</p>
				</c:if>
				<c:if test="${success eq 'Y'}">
				    <p class="inquire-mark">처리 완료</p>
				</c:if>
				<h3>${inquiry_title}</h3>
			</div>
			<div class="enquire-info">
				<div class="enquire-info-1">
					<div class="enquire-info-head">문의자</div>
					<p>${enquirer}</p>
				</div>
				<div class="enquire-info-2">
					<div class="enquire-info-head">문의 옵션</div>
					<p>${category_name}</p>
				</div>
				<div class="enquire-info-3">
					<div class="enquire-info-head">비밀번호</div>
					<p>${inquiry_pw}</p>
				</div>
				<div class="enquire-info-4">
					<div class="enquire-info-head">등록일</div>
					<p>${reg_date}</p>
				</div>
			</div>
			<div class="enquire-img">
				<c:forEach items="${photos}" var="photo">
					<img src="/photo/${photo.new_picname}" name="inquirePhoto"/>
				</c:forEach>
			</div>
			<div class="enquire-content">
				<p>${inquiry_account}</p>
			</div>
		</div>
		
		<div class="admin">
			<div class="enquire-info-head">답변</div>
			<div class="enquire-info-body">
				<c:if test="${not empty id}">
				    <p>${id}</p>
				    <div class="admin-reply">${reply}</div>
				</c:if>
				<c:if test="${empty id}">
				    <p>문의 사항을 확인 중 입니다...</p>
				</c:if>
			</div>
		</div>
	</div>
</body>


<script>
	//뒤로가기
	$('.fa-arrow-left').on('click', function() {
		window.location.href='<c:url value="/customerService/inquire.go"/>';
	});
</script>
</html>