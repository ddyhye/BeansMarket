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
<link rel="stylesheet" href="../resources/css/common.css" type="text/css" />
<link rel="stylesheet" href="../resources/css/detail.css" type="text/css" />
<link rel="stylesheet" href="../resources/css/saleofgoods.css" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>
<body>
<jsp:include page="../common.jsp" />

	<div class="salewrite">
		<div><i class="fa-regular fa-bookmark"></i><a href="TempSave">임시저장 글</a></div>
		<form action="goodsWrite.go">
			<div class="salemethod">
				거래방식
				<div class="option-container">
					<div class="option" id="sale-option"
						onclick="toggleSaleMethod('sale')">나눔/판매</div>
					<div class="option" id="auction-option"
						onclick="toggleSaleMethod('auction')">경매</div>
				</div>
			</div>

			<!-- 나눔/판매 선택 시 보여질 요소들 -->
			<div class="price-container" id="sale-price-container">
				<input type="text" id="price" placeholder="가격을 입력해 주세요">
				<p id="price-text">*나눔의 경우 가격을 0으로 설정해주세요</p>
			</div>

			<!-- 경매 선택 시 보여질 요소들 -->
			<div class="auction-details" id="auction-details"
				style="display: none;">
                <div class="auction-period">
                    <label for="auction-period">경매 기간</label>
                    <select id="auction-period" name="auction-period">
                        <option value="3">3일</option>
                        <option value="5">5일</option>
                        <option value="7">7일</option>
                    </select>
                </div>
				<div class="auction-start-price">
					<label for="start-price">시작 가격</label> <input type="text"
						name="start-price">
				</div>
				<div class="auction-immediate-price">
					<label for="immediate-price">즉시 낙찰가</label> <input type="text"
						name="immediate-price">
				</div>
			</div>

			<!--공통 요소들-->
			<div class="salecategory">
				<label for="category">카테고리</label> <select name="category">
					<option value="">선택</option>
					<option value="학생">디지털기기</option>
					<option value="회사원">가구/인테리어</option>
					<option value="기타">유아동</option>
				</select>
			</div>

			<div class="title">
				<label for="title">제목</label> <input type="text" name="title"
					placeholder="제목을 입력해 주세요">
			</div>

			<div class="photo">
				<label for="photo">사진선택</label> <input type="file"
					multiple="multiple" name="imageFiles">
			</div>

			<div class="content">
				<label for="content">설명</label>
				<textarea id="content" name="content" placeholder="게시글 내용을 작성해 주세요"></textarea>
			</div>

			<div class="place">
				<label for="place">거래 희망 장소</label> <input type="text" name="place"
					placeholder="ex.가산역 구디빌딩 근처">
			</div>

			<div class="buttons">
				<button type="button" id="temporary-save-button">임시저장</button>
				<button type="submit" id="save-button">저장</button>
			</div>
		</form>
	</div>

</body>
<script>
    // 거래방식에 따른 입력요소 변경
    function toggleSaleMethod(method) {
    const salePriceContainer = document.getElementById('sale-price-container');
    const auctionDetails = document.getElementById('auction-details');

        if (method === 'sale') {
            salePriceContainer.style.display = 'block';
            auctionDetails.style.display = 'none';
        } else if (method === 'auction') {
            salePriceContainer.style.display = 'none';
            auctionDetails.style.display = 'block';
        }
    }

    // 거래방식 선택
    const saleOption = document.getElementById('sale-option');
    const auctionOption = document.getElementById('auction-option');

    saleOption.addEventListener('click', function() {
        if (!saleOption.classList.contains('selected')) {
            saleOption.classList.add('selected');
            auctionOption.classList.remove('selected');
        }
    });

    auctionOption.addEventListener('click', function() {
        if (!auctionOption.classList.contains('selected')) {
            auctionOption.classList.add('selected');
            saleOption.classList.remove('selected');
        }
    });

    document.getElementById('price').addEventListener('input', function() {
    const priceInput = document.getElementById('price');
    const priceText = document.getElementById('price-text');
    if (priceInput.value === '0') {
        priceText.innerText = '나눔';
    } else {
        priceText.innerText = '*나눔의 경우 가격을 0으로 설정해주세요';
    }
	});
    
    

</script>
</html>