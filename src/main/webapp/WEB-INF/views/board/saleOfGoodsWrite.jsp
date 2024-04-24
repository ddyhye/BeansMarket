<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css" />
<link rel="stylesheet" href="../resources/css/detail.css" type="text/css" />
<link rel="stylesheet" href="../resources/css/saleofgoods.css" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<jsp:include page="../common.jsp" />

<div class="salewrite">
    <div><i class="fa-regular fa-bookmark"></i><a href="<c:url value="/board/TempSave.go"/>">임시저장 글</a></div>
    <form action="goodsWrite.do" method="POST" enctype="multipart/form-data">
        <div class="salemethod">
            거래방식
            <input type="hidden" id="tempwrite" name="draft" value="N" />
            <div class="option-container">
            	<input type="hidden" id="selectedOption" name="option" value="" />
                <div class="option" id="sale-option" onclick="toggleSaleMethod('sale')">나눔/판매</div>
                <div class="option" id="auction-option" onclick="toggleSaleMethod('auction')">경매</div>
            </div>
        </div>

        <!-- 나눔/판매 선택 시 보여질 요소들 -->
        <div class="price-container" id="sale-price-container">
            <input name="price" type="text" id="price" placeholder="가격을 입력해 주세요">
            <p id="price-text">*나눔의 경우 가격을 0으로 설정해주세요</p>
        </div>

        <!-- 경매 선택 시 보여질 요소들 -->
        <div class="auction-details" id="auction-details" style="display: none;">
            <div class="auction-period">
                <label for="auction-period">경매 기간</label>
                <select id="auction-period" name="auction-period">
                    <option value="0">선택</option>
                    <option value="3">3일</option>
                    <option value="5">5일</option>
                    <option value="7">7일</option>
                </select>
            </div>
            <div class="auction-start-price">
                <label for="start-price">시작 가격</label> <input type="text" name="start-price">
            </div>
            <div class="auction-immediate-price">
                <label for="immediate-price">즉시 낙찰가</label> <input type="text" name="immediate-price">
            </div>
        </div>

        <!-- 공통 요소들 -->
        <div class="salecategory">
            <label for="category">카테고리</label>
            <select name="category">
                <option value="0">선택</option>
                <option value="m001">남성 패션/잡화</option>
                <option value="m002">디지털 기기</option>
            </select>
        </div>

        <div class="title">
            <label for="title">제목</label> <input type="text" name="subject" placeholder="제목을 입력해 주세요">
        </div>

        <div class="photo">
            <label for="photo">사진선택</label>
            <input type="file" multiple="multiple" name="photos">
        </div>

        <div class="content">
            <label for="content">설명</label>
            <textarea id="content" name="content" placeholder="게시글 내용을 작성해 주세요"></textarea>
        </div>

        <div class="place">
            <label for="place">거래 희망 장소</label> <input type="text" name="place" placeholder="ex.가산역 구디빌딩 근처">
        </div>

        <div class="buttons">
            <button type="button" onclick="tempwrite()" id="temporary-save-button">임시저장</button>
            <button type="button" onclick="salewrite()" id="save-button">저장</button>
        </div>
    </form>
</div>

<script>

	$(document).ready(function() {	    
	    toggleSaleMethod('sale');
	    
	    // "판매" 옵션 클릭 시 처리
	    $('#sale-option').click(function () {
	        toggleSaleMethod('sale');
	    });
	
	    // "경매" 옵션 클릭 시 처리
	    $('#auction-option').click(function () {
	        toggleSaleMethod('auction');
	    });
	});
	
    // 거래방식에 따른 입력요소 변경
    function toggleSaleMethod(method) {
        const salePriceContainer = document.getElementById('sale-price-container');
        const auctionDetails = document.getElementById('auction-details');
        var selectedOptionInput = document.getElementById('selectedOption');

        if (method === 'sale') {
            salePriceContainer.style.display = 'block';
            auctionDetails.style.display = 'none';
            selectedOptionInput.value = '판매'; // 숨겨진 필드 값 업데이트
            document.getElementById('sale-option').classList.add('selected');
            document.getElementById('auction-option').classList.remove('selected');
        } else if (method === 'auction') {
            salePriceContainer.style.display = 'none';
            auctionDetails.style.display = 'block';
            selectedOptionInput.value = '경매'; // 숨겨진 필드 값 업데이트
            document.getElementById('auction-option').classList.add('selected');
            document.getElementById('sale-option').classList.remove('selected');
        }
    }

    $(document).ready(function () {
        $('#sale-option').click(function () {
            toggleSaleMethod('sale');
        });

        $('#auction-option').click(function () {
            toggleSaleMethod('auction');
        });
    });

    document.getElementById('price').addEventListener('input', function () {
        const priceInput = document.getElementById('price');
        const priceText = document.getElementById('price-text');
        if (priceInput.value === '0') {
            priceText.innerText = '나눔';
        } else {
            priceText.innerText = '*나눔의 경우 가격을 0으로 설정해주세요';
        }
    });

    function salewrite() {
        console.log("글쓰기");

        var option = $('#selectedOption').val();
        var price = $('#price').val();
        var auctionPeriod = $('#auction-period').val();
        var startPrice = $('input[name="start-price"]').val();
        var immediatePrice = $('input[name="immediate-price"]').val();
        var category = $('select[name="category"]').val();
        var title = $('input[name="subject"]').val();
        var photos = $('input[name="photos"]').eq(0).prop('files');
        var content = $('textarea[name="content"]').val();
        var place = $('input[name="place"]').val();

        if (option == "") {
            alert("옵션을 선택해주세요");
            return;
        } else if (option === '판매' && price == "") {
            alert("가격을 입력해주세요");
            return;
        } else if (option === '경매' && auctionPeriod == "0") {
            alert("경매기간을 입력해주세요");
            return;
        } else if (option === '경매' && startPrice == "") {
            alert("시작가를 입력해주세요");
            return;
        } else if (option === '경매' && immediatePrice == "") {
            alert("즉시낙찰가를 입력해주세요");
            return;
        } else if (category == "0") {
            alert("카테고리를 선택해주세요");
            return;
        } else if (title == "") {
            alert("제목을 입력해주세요");
            return;
        } else if (photos.length == 0) {
            alert("사진을 선택해주세요");
            return;
        } else if (content == "") {
            alert("내용을 입력해주세요");
            return;
        } else if (place == "") {
            alert("거래 희망 장소를 입력해주세요");
            return;
        }

        $('form').submit();
    }
    
    function tempwrite(){
    	
        var title = $('input[name="subject"]').val();
    	
        if (title == "") {
        	alert("제목을 입력해주세요");
        }else {
            console.log("제목:", title);
            alert("임시 저장되었습니다.");
        }
        
        $('form').submit();
    }

</script>
</body>
</html>
