<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/userManageDetail.css" type="text/css"/>
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
		   		<div class="memberP">
		   			<div class="memberP-top">
		   				<div class="memberP-top-left">
		   					<img src="/photo/${new_filename}" alt="">
	   					</div>
	   					<div class="memberP-top-right">
	   						<div class="memberP-top-right-column">
	   							<div class="memberP-top-right-head">
	   								<p>이메일</p>
	   							</div>
	   							<p id="memberEmail">${email}</p>
	   						</div>
	   						<div class="memberP-top-right-column">
	   							<div class="memberP-top-right-head">
	   								<p>닉네임</p>
	   							</div>
	   							<p>${name}</p>
	   						</div>
	   						<div class="memberP-top-right-column">
	   							<div class="memberP-top-right-head">
	   								<p>주소 / 거래 범위</p>
	   							</div>
	   							<p>${location} / ${scope}</p>
	   						</div>
	   						<div class="memberP-top-right-column">
	   							<div class="memberP-top-right-head">
	   								<p>성별</p>
	   							</div>
	   							<p>${gender}</p>
	   						</div>
	   						<div class="memberP-top-right-column">
	   							<div class="memberP-top-right-head">
	   								<p>생년월일</p>
	   							</div>
	   							<p>${birth_date}</p>
	   						</div>
	   					</div>
	   				</div>
	   				<div class="memberP-login">
	   					<div class="memberP-login-head">
	   						<p class="login1">마지막 로그인 일자</p>
	   						<p class="login2">정보 약간 동의</p>
	   						<p class="login3">휴먼</p>
	   						<p class="login4">탈퇴</p>
	   					</div>
	   					<div class="memberP-login-body">
	   						<p class="login1">${last_login}</p>
	   						<p class="login2">2001-07-07</p>
	   						<p class="login3">${dormant}</p>
	   						<p class="login4">${secession}</p>
	   					</div>
	   				</div>
	   				<div class="memberP-pay">
	   					<div class="memberP-pay-head">
	   						<p>Beans Pay</p>
	   					</div>
	   					<p>${point} 원</p>
	   					<p id="payManageBtn">잔액 변경</p>
	   					<p id="payHistoryBtn">Pay History...</p>
	   				</div>
	   				<div class="memberP-manage">
	   					<div class="memberP-manage-column">
		   					<div class="memberP-manage-head">
		   						<p>경고 횟수</p>
		   					</div>
		   					<p>${warn_count} 회</p>
		   					<p id="disciplineManageBtn">Discipline History...</p>
	   					</div>
	   					<div class="memberP-manage-column">
		   					<div class="memberP-manage-head">
		   						<p>기간 정지 시작일</p>
		   					</div>
		   					<p>${login_banstr}</p>
	   					</div>
	   					<div class="memberP-manage-column">
		   					<div class="memberP-manage-head">
		   						<p>기간 정지 해제일</p>
		   					</div>
		   					<p>${login_banend}</p>
	   					</div>
	   				</div>	   				
	   			</div>
	   			
	   			<div class="payAdd">
		   			<div class="payAdd-top">
		   				<p id="deleteBtn">X</p>
		   			</div>
	   				<div class="payAdd-subject">
	   					<h3>빈즈페이 잔액 수정</h3>
	   				</div>
		   			<div class="payAdd-center">
		   				<input type="text" id="inputPoint"/>
		   				<p id="addBtn">충전</p>
		   				<p id="minusBtn">감소</p>
		   			</div>
	   			</div>
	   			
	   			<div class="payHistory">
	   				<div class="payHistory-top">
	   					<p id="deleteBtn2">X</p>
		   			</div>
		   			<div class="payHistory-center">
		   				<div class="payHistory-center-head">
		   					<p>경고 일자</p>
		   					<p>입출금 구분</p>
		   					<p>설명</p>
		   					<p>금액</p>
		   					<p>글번호</p>
			   			</div>
			   			<div class="payHistory-center-body">
			   				<p>item.reg_date</p>
		   					<p>item.option</p>
		   					<p>item.content</p>
		   					<p>item.price</p>
		   					<p>item.idx</p>
			   			</div>
		   			</div>
	   			</div>
	   			
	   			<div class="disciplineHistory">
	   				<div class="disciplineHistory-top">
	   					<p id="deleteBtn3">X</p>
		   			</div>
		   			<div class="disciplineHistory-center">
		   			</div>
	   			</div>
	   			
		   	</div>
 		</section>
	</main>

</body>

<script>
	// 빈즈 페이 잔액 수정
	$('#payManageBtn').on('click', function() {
		$('.payAdd').addClass('active');
	});
	$('#deleteBtn').on('click', function() {
		$('.payAdd').removeClass('active');
	});
	$('#addBtn').on('click', function() {
		var memberEmail = $('#memberEmail').text();
		var inputPoint = $('#inputPoint').val();
		// *** 들어온 값이 숫자인지 유효성 검사!!!! /
		window.location.href = '<c:url value="/admin/userManageDetailAdd.go?memberEmail='+memberEmail+'&inputPoint='+inputPoint+'"/>';
		
		$('.payAdd').removeClass('active');
	});
	$('#minusBtn').on('click', function() {
		var memberEmail = $('#memberEmail').text();
		var inputPoint = $('#inputPoint').val();
		
		window.location.href = '<c:url value="/admin/userManageDetailMinus.go?memberEmail='+memberEmail+'&inputPoint='+inputPoint+'"/>';
		
		$('.minusBtn').removeClass('active');
	});
</script>
</html>