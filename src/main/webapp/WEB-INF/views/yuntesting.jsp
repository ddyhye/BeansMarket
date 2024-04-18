com.beans.market<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/common.css" type="text/css"/>
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
        background-color: green; /* Blue background */
        color: white; /* White text */
        padding: 12px 24px; /* Top and bottom padding 12px, left and right padding 24px */
        font-size: 16px; /* Text size */
        border: none; /* No border */
        cursor: pointer; /* Cursor changes to pointer when hovered over */
        border-radius: 5px; /* Rounded corners */
        transition: all 0.3s; /* Smooth transition for hover effects */
}
.charge:hover {
        background-color: darkgreen; /* Darker shade of blue on hover */
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


</style>
</head>

<body>
<div class="container">
		 <div class="beanspay">
		      <p>빈즈페이</p>
		      <p class="my_amount">1234567890</p>
		      <p>원</p>
		      <button class="charge">+ 충전</button>
    	</div>

        <div class="content">
			<p>내역 확인</p>
            <div class="history">
			    <div class="top">
			        <div class="date">2024-04-18</div>
			        <div class="category">분류</div>
			    </div>
			    <div class="bottom">
			        <div class="title">제목</div>
			        <div class="amount">금액</div>
			    </div>
			</div>

			<div class="history">
			        <div class="top">
			            <div class="date">2024-04-18</div>
			            <div class="category">분류</div>
			        </div>
			        <div class="bottom">
			            <div class="title">제목</div>
			            <div class="amount">금액</div>
			        </div>
			</div>
			    
			    <div class="history">
			        <div class="top">
			            <div class="date">2024-04-18</div>
			            <div class="category">분류</div>
			        </div>
			        <div class="bottom">
			            <div class="title">제목</div>
			            <div class="amount">금액</div>
			        </div>
			    </div>
			</div>
        
<!--  모달창 -->
    <div class="modal_charge">
        <div class="modal_body">
            <h2>빈즈페이 충전</h2>
            <p>얼마를 충전하시겠습니까? </p>
            <button class="modal_close">X</button>
        </div>
    </div>
        
        
</div>
</body>

<script>
const modal = document.querySelector('.modal_charge');
const btnOpenModal = document.querySelector('.charge');
const btnCloseModal = document.querySelector('.modal_close'); // 닫기 버튼 선택

btnOpenModal.addEventListener("click", () => {
    modal.style.display = "flex";
});

btnCloseModal.addEventListener("click", () => {
    modal.style.display = "none";
});

</script>
</html>