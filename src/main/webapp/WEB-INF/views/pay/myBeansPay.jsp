com.beans.market<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>


.beanspay {
    display: flex;
    align-items: center;
    justify-content: start;
}

.beanspay p {
    margin-right: 20px;
}



.history {
    border: 2px solid #000;
    width: 500px;
    padding: 10px;
    margin-bottom: 10px;
}

.top, .bottom {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
}

/*버튼 css */
.charge{
		margin-left : 5%;
        background-color: green;
        color: white;
        padding: 12px 24px; 
        font-size: 16px; 
        border: none; 
        cursor: pointer;
        border-radius: 5px; 
        transition: all 0.3s;
}
.charge:hover {
        background-color: darkgreen;
        color: #FFF; /* White text on hover */
}

/*모달창*/
.modal_charge {
    display: none; /* 기본적으로 모달을 숨깁니다 */
    position: fixed; /* 모달을 페이지에 고정 */
    left: 50%; /* 왼쪽에서부터 50% 위치에 배치 */
    top: 50%; /* 상단에서부터 50% 위치에 배치 */
    transform: translate(-50%, -50%); /* 센터 정렬을 위해 변환 적용 */
    width: 50%; /* 모달의 너비를 50%로 설정 */
    height: 50%; /* 모달의 높이를 50%로 설정 */
    background-color: white; /* 모달의 배경색 설정 */
    z-index: 10; /* 다른 요소들 위에 모달이 보이도록 z-index 설정 */
    padding: 20px; /* 내부 여백 추가 */
    border-radius: 10px; /* 테두리 둥글게 처리 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 모달에 그림자 효과 추가 */
}

.modal_body {
    margin: 20px 0; /* 내용 주변 여백 설정 */
}

.modal_close {
    position: absolute;
    right: 20px;
    top: 20px;
    cursor: pointer;
}

.modal_confirm {
    display: none; 
    position: fixed; 
    left: 50%; 
    top: 50%; 
    transform: translate(-50%, -50%);
    width: 25%; 
    height: 25%; 
    background-color: white;
    z-index: 10; 
    padding: 20px; 
    border-radius: 10px; 
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); 
}

</style>
</head>

<body>
<jsp:include page="../common.jsp" />
<div class="container">
	<div class="username">유저이름 들어갈곳</div>
		 <div class="beanspay">
		      <p><b>빈즈페이</b></p>
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
                <c:when test="${bean.option == '거래금 수령' || bean.option == '빈즈페이 충전'}">
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
        
<!-- 기존 모달창 -->
<div class="modal_charge">
    <div class="modal_body">
        <h2>빈즈페이 충전</h2>
        <p>얼마를 충전하시겠습니까? </p>
        <input type="text" id="chargeAmount">원
        <button class="modal_close">X</button>
        <button class="btn_confirm">확인</button> <!-- 확인 버튼 추가 -->
    </div>
</div>

<!-- 금액 확인 모달창 -->
<div class="modal_confirm">
    <div class="modal_body">
        <h2>충전 금액 확인</h2>
        <p id="confirmText">충전 금액: </p>
        <button class="confirm_close">확인</button>
        <button class="cancel">취소</button>
    </div>
</div>
        
        
</div>
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
        
        // 필요한 경우 '충전 금액 확인' 모달창을 여기서 열 수 있습니다.
        // 예: document.querySelector('.modal_confirm').style.display = 'block';
    });


</script>
</html>