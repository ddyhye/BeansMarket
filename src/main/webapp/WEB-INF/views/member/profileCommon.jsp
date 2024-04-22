<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/profileCommon.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="../common.jsp" />
	
	<div class="container">
		<div class="link">
			<div class="link-member">
				<h3>회원 정보</h3>
				<p>&nbsp;• 마이페이지</p>
				<p>&nbsp;• 관심 물품</p>
				<p>&nbsp;• 차단 회원 관리</p>
			</div>
			<div class="link-Transaction">
				<h3>거래</h3>
				<p>&nbsp;• 판매 내역</p>
				<p>&nbsp;• 구매 내역</p>
				<p>&nbsp;• 거래 미승인 목록</p>
			</div>
			<div class="link-Auction">
				<h3>경매</h3>
				<p>&nbsp;• 입찰 내역</p>
			</div>
			<div class="link-pay">
				<h3>빈즈페이</h3>
				<p>&nbsp;• 나의 빈즈페이</p>
			</div>
		</div>
</body>

<script>
	// 링크 이동
	$('.link p').on('click', function() {
		var pText = $(this).text().trim();
		
		if(pText === '• 마이페이지') {
			window.location.href = './myPage.go';
		} else(pText === '• 관심 물품') {
			window.location.href = './minePage.go';
		} else(pText === '• 차단 회원 관리') {
			window.location.href = '';
		} else(pText === '• 판매 내역') {
			window.location.href = '';
		} else(pText === '• 구매 내역') {
			window.location.href = '';
		} else(pText === '• 거래 미승인 목록') {
			window.location.href = '';
		} else(pText === '• 입찰 내역') {
			window.location.href = '';
		} else(pText === '• 나의 빈즈페이') {
			window.location.href = '';
		}
		
		
	});

</script>
</html>