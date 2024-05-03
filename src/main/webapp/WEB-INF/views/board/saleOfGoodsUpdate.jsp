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
<link rel="stylesheet" href="../resources/css/saleofgoods.css" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	.fa-bookmark {
		margin-left: 10px;
		font-size: 20px;
	}
</style>
</head>
<body>
<jsp:include page="../common.jsp" />

<div class="salewrite">
    <%-- <div class="draftDiv"><i class="fa-solid fa-bookmark"></i></i><a href="<c:url value="/board/TempSave.go"/>">임시저장 글</a></div> --%>
    <div class="draftDiv">
    </div>
    <h2 id="writeSubject">나눔/판매 글 수정</h2>
    <form action="<c:url value='/board/saleOfGoodsUpdate.do'/>" method="POST" enctype="multipart/form-data">
        <div class="salemethod">
        	<div class="form-head">
            	거래방식
            </div>
            <input type="hidden" id="tempwrite" name="draft" value="N" />
            <div class="option-container">
            	<input type="hidden" id="selectedOption" name="option" value="" />
                <div class="option" id="sale-option" onclick="toggleSaleMethod('sale')">나눔/판매</div>
                <!-- <div class="option" id="auction-option" onclick="toggleSaleMethod('auction')">경매</div> -->
            </div>
        </div>

        <!-- 나눔/판매 선택 시 보여질 요소들 -->
        <div class="price-container" id="sale-price-container">
        	<div class="form-head">
            	가격
            </div>
            <input name="price" type="text" id="price" value="${price}" placeholder="가격을 입력해 주세요">
            <p id="price-text">*나눔의 경우 가격을 0으로 설정해주세요</p>
        </div>
  

        <!-- 공통 요소들 -->
        <input type="hidden" name="idx" value="${idx}"/>
        <div class="salecategory">
        	<div class="form-head">
	            <label for="category">카테고리</label>
            </div>
            <select name="category">
                <option value="m001">선택</option>
                <option value="m001" ${category_idx == "m001" ? "selected" : ""}>디지털 기기</option>
                <option value="m002" ${category_idx == "m002" ? "selected" : ""}>가구/인테리어</option>
                <option value="m003" ${category_idx == "m003" ? "selected" : ""}>유아동</option>
                <option value="m004" ${category_idx == "m004" ? "selected" : ""}>여성 패션</option>
                <option value="m005" ${category_idx == "m005" ? "selected" : ""}>여성 잡화</option>
                <option value="m006" ${category_idx == "m006" ? "selected" : ""}>뷰티 미용</option>
                <option value="m007" ${category_idx == "m007" ? "selected" : ""}>남성 패션/잡화</option>
                <option value="m008" ${category_idx == "m008" ? "selected" : ""}>생활가전</option>
                <option value="m009" ${category_idx == "m009" ? "selected" : ""}>생활/주방</option>
                <option value="m010" ${category_idx == "m010" ? "selected" : ""}>가공식품</option>
                <option value="m011" ${category_idx == "m011" ? "selected" : ""}>스포츠/레저</option>
                <option value="m012" ${category_idx == "m012" ? "selected" : ""}>취미/게임/음반</option>
                <option value="m013" ${category_idx == "m013" ? "selected" : ""}>식물</option>
                <option value="m014" ${category_idx == "m014" ? "selected" : ""}>반려동물 용품</option>
            </select>
        </div>

        <div class="title">
        	<div class="form-head">
	            <label for="title">제목</label> 
            </div>
            <input type="text" name="subject" value="${subject}" placeholder="제목을 입력해 주세요">
        </div>

        <div class="photo">
        	<div class="form-head">
	            <label for="photo">사진선택</label>
            </div>
            <input type="file" multiple="multiple" name="photos" disabled>
        </div>

        <div class="content">
        	<div class="form-head">
 	            <label for="content">설명</label>
            </div>
            <textarea id="content" name="content" placeholder="게시글 내용을 작성해 주세요">${content}</textarea>
        </div>

        <div class="place">
        	<div class="form-head">
	            <label for="place">거래 희망 장소</label> 
            </div>
            <input type="text" name="place" value="${place}" placeholder="ex.가산역 구디빌딩 근처">
        </div>

        <div class="buttons">
            <input type="submit" value="수정"/>
        </div>
    </form>
</div>

<script>
	var bbsIdx = '${idx}';

	$(document).ready(function() {	    
	    toggleSaleMethod('sale');
	    
	    // "판매" 옵션 클릭 시 처리
	    $('#sale-option').click(function () {
	        toggleSaleMethod('sale');
	    });
	});
	
    // 거래방식에 따른 입력요소 변경
    function toggleSaleMethod(method) {
        const salePriceContainer = document.getElementById('sale-price-container');
        var selectedOptionInput = document.getElementById('selectedOption');

        if (method === 'sale') {
            salePriceContainer.style.display = 'flex';
            selectedOptionInput.value = '판매'; // 숨겨진 필드 값 업데이트
            document.getElementById('sale-option').classList.add('selected');
        } 
    }

    $(document).ready(function () {
        $('#sale-option').click(function () {
            toggleSaleMethod('sale');
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
    
    
    // 임시저장
    function tempwriteFun() {
        var title = $('input[name="subject"]').val();

        if (title === "") {
            alert("제목을 입력해주세요.");
            return;
        }

        var option = $('#selectedOption').val();
        var price = $('#price').val();
        var auctionPeriod = $('#auction-period').val();
        var startPrice = $('input[name="start-price"]').val();
        var immediatePrice = $('input[name="immediate-price"]').val();
        var category = $('select[name="category"]').val();
        var content = $('textarea[name="content"]').val();
        var place = $('input[name="place"]').val();

        // FormData 객체 생성
        var formData = new FormData();
        formData.append('option', option);
        formData.append('price', price);
        formData.append('auction-period', auctionPeriod);
        formData.append('start-price', startPrice);
        formData.append('immediate-price', immediatePrice);
        formData.append('category', category);
        formData.append('subject', title);
        formData.append('content', content);
        formData.append('place', place);
        formData.append('draft', 'Y');

        var photos = $('input[name="photos"]').prop('files');
        if (photos.length > 0) {
            formData.append('photos', photos[0]);
        }

        // AJAX 요청 전송
        $.ajax({
            url: '<c:url value="/board/TempSave.ajax"/>',
            type: 'POST',
            data: formData,
            processData: false, // 데이터 처리 방식 설정
            contentType: false, // 컨텐츠 타입 설정
            success: function(response) {
                // 성공 시 알림 표시
                alert('임시 저장되었습니다.');
            },
            error: function(xhr, status, error) {
                // 오류 발생 시 알림 표시
                alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
                console.error(xhr.responseText);
            }
        });
    }



</script>
</body>
</html>
