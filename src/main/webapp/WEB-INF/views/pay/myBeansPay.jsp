<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/pay.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>

<body>
	<jsp:include page="../member/profileCommon.jsp" />
			<div class="main">
				<div class="container">
					<div class="username">
						<h3>${userName} 님의 빈즈페이</h3>
					</div>
					<div class="beanspay">
						<p>빈즈페이</p>
						<p class="my_amount">${my_amount}</p>
						<p>원</p>
						<button class="charge">+ 충전</button>
					</div>
			
					<div class="content">
						<p><b>내역 확인</b></p>
						<c:forEach var="bean" items="${beans}">
							<div class="history">
								<div class="top">
									<div class="date">${bean.reg_date}</div>
									<div class="category">${bean.option}</div>
								</div>
								<div class="bottom">
									<div class="title">${bean.content}</div>
									<c:choose>
										<c:when test="${bean.option =='경매글 입찰' || bean.option == '거래금 지불'}">
											<div class="amount" style="color: red;">-${bean.price}</div>
										</c:when>
										<c:when test="${bean.option == '거래금 수령' || bean.option == '입찰금 반환' || bean.option == '빈즈페이 충전'}">
											<div class="amount" style="color: blue;">+${bean.price}</div>
										</c:when>
										<c:otherwise>
											<div class="amount">${bean.price}</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</c:forEach>
					</div>
		

					<div class="modal_charge">
						<div class="modal_body">
							<button type="button" class="modal_close">X</button>							
							<h2>빈즈페이 충전</h2>
							<p>얼마를 충전하시겠습니까? </p>
							<form action="/main/pay/charge" method="post">
								<input type="number" id="chargeAmount" name="pay" min="0" step="100">원
								<input type="submit" value="확인"/>
							</form>
						</div>
					</div>

			

					<div class="modal_confirm">
						<div class="modal_body">
							<h2>충전 금액 확인</h2>
							<p id="confirmText">충전 금액: </p>
							<button class="confirm_close">확인</button>
							<button class="cancel">취소</button>
						</div>
					</div>
				</div>

			</div><!-- main 종료 -->
	</div> <!-- include 무리 하는 태그 -->
</body>

<script>
	const modal = document.querySelector('.modal_charge');
	const confirmModal = document.querySelector('.modal_confirm'); // 새로운 모달 선택
	const btnOpenModal = document.querySelector('.charge');
	const btnCloseModal = document.querySelector('.modal_close');
	const btnConfirm = document.querySelector('.btn_confirm'); // 확인 버튼 선택
	const confirmClose = document.querySelector('.confirm_close'); // 금액 확인 모달 닫기 버튼 선택
	const chargeAmount = document.getElementById('chargeAmount'); // 금액 입력 필드
	const confirmText = document.getElementById('confirmText'); // 금액 확인 텍스트
	const cancel = document.querySelector('.cancel'); 
	
	
	btnOpenModal.addEventListener("click", () => {
	    modal.style.display = "flex";
	});
	
	btnCloseModal.addEventListener("click", () => {
	    modal.style.display = "none";
	});
	
	// '확인' 버튼 클릭 이벤트
	btnConfirm.addEventListener("click", () => {
	    const amount = chargeAmount.value; // 입력한 금액 가져오기
	    confirmModal.style.display = "flex"; // 금액 확인 모달 보여주기
	});
	
	// 확인시 모달 전부 닫음
	confirmClose.addEventListener("click", () => {
	    confirmModal.style.display = "none";
	    modal.style.display = "none";
	});
	// 금액확인 취소시 confirm 모달만 닫음
	cancel.addEventListener("click", () => {
	    confirmModal.style.display = "none";
	});
	
	document.querySelector('.btn_confirm').addEventListener('click', function() {
    // 입력한 금액 가져오기
    var chargeAmount = document.getElementById('chargeAmount').value;
    
    // '충전 금액 확인' 모달의 텍스트를 변경
    document.getElementById('confirmText').textContent = '' + chargeAmount + '원 을 충전하시겠습니까??';
	    
	});
</script>
</html>