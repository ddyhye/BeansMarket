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
<!--     <div class="draftDiv">
    	<i class="fa-solid fa-bookmark"></i>
    	<p id="draftList">임시저장 리스트</p>
    </div> -->
    <h2 id="writeSubject">중고 물품 판매글 작성</h2>
    <form action="goodsWrite.do" method="POST" enctype="multipart/form-data">
        <div class="salemethod">
        	<div class="form-head">
            	거래방식
            </div>
            <input type="hidden" id="tempwrite" name="draft" value="N" />
            <div class="option-container">
            	<input type="hidden" id="selectedOption" name="option" value="" />
                <div class="option" id="sale-option" onclick="toggleSaleMethod('sale')">나눔/판매</div>
                <div class="option" id="auction-option" onclick="toggleSaleMethod('auction')">경매</div>
            </div>
        </div>

        <!-- 나눔/판매 선택 시 보여질 요소들 -->
        <div class="price-container" id="sale-price-container">
        	<div class="form-head">
            	가격
            </div>
            <input name="price" type="text" id="price" placeholder="가격을 입력해 주세요">
            <p id="price-text">* 나눔의 경우 가격을 0으로 설정해 주세요</p>
        </div>

        <!-- 경매 선택 시 보여질 요소들 -->
        <div class="auction-details" id="auction-details" style="display: none;">
            <div class="auction-period">
            	<div class="form-head">
	                <label for="auction-period">경매 기간</label>
	            </div>
                <select id="auction-period" name="auction-period">
                    <option value="0">선택</option>
                    <option value="3">3일</option>
                    <option value="5">5일</option>
                    <option value="7">7일</option>
                </select>
            </div>
            <div class="auction-start-price">
                <div class="form-head">
	                <label for="start-price">시작 가격</label> 
	            </div>
                <input type="text" name="start-price" id="start-price">
            </div>
            <div class="auction-immediate-price">
            	<div class="form-head">
	                <label for="immediate-price">즉시 낙찰가</label> 
	            </div>
                <input type="text" name="immediate-price" id="immediate-price">
            </div>
        </div>

        <!-- 공통 요소들 -->
        <div class="salecategory">
        	<div class="form-head">
	            <label for="category">카테고리</label>
            </div>
            <select name="category">
                <option value="m001">선택</option>
                <option value="m001">디지털 기기</option>
                <option value="m002">가구/인테리어</option>
                <option value="m003">유아동</option>
                <option value="m004">여성 패션</option>
                <option value="m005">여성 잡화</option>
                <option value="m006">뷰티 미용</option>
                <option value="m007">남성 패션/잡화</option>
                <option value="m008">생활가전</option>
                <option value="m009">생활/주방</option>
                <option value="m010">가공식품</option>
                <option value="m011">스포츠/레저</option>
                <option value="m012">취미/게임/음반</option>
                <option value="m013">식물</option>
                <option value="m014">반려동물 용품</option>
            </select>
        </div>

        <div class="title">
        	<div class="form-head">
	            <label for="title">제목</label> 
            </div>
            <input type="text" name="subject" placeholder="제목을 입력해 주세요">
        </div>

        <div class="photo">
        	<div class="form-head">
	            <label for="photo">사진</label>
            </div>
            <div class="photo-tempo">
            	<p id="photoSelect">사진 선택</p>
            	<p id="photo-text">* 첫번째 사진이 대표사진으로 설정됩니다</p>
            </div>
            <div class="photo-select">
            	<input type="file" multiple="multiple" name="photos">
            	<p id="photoSave">확인</p>
            </div>
        </div>

        <div class="content">
        	<div class="form-head">
 	            <label for="content">설명</label>
            </div>
            <textarea id="content" name="content" placeholder="게시글 내용을 작성해 주세요(1200자 이하)" maxlength='1200'></textarea>
        </div>

        <div class="place">
        	<div class="form-head">
	            <label for="place">거래 희망 장소</label> 
            </div>
            <input type="text" name="place" placeholder="ex.가산역 구디빌딩 근처">
        </div>

        <div class="buttons">
            <!-- <button type="button" onclick="tempwriteFun()" id="temporary-save-button">임시저장</button> -->
            <button type="button" onclick="salewrite()" id="save-button">저장</button>
        </div>
    </form>
</div>

<script>
	// 사진의 new_picname을 담을 전역 배열 선언
	var tempoPhotoArr = []; 

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
            salePriceContainer.style.display = 'flex';
            auctionDetails.style.display = 'none';
            selectedOptionInput.value = '판매'; // 숨겨진 필드 값 업데이트
            document.getElementById('sale-option').classList.add('selected');
            document.getElementById('auction-option').classList.remove('selected');
        } else if (method === 'auction') {
            salePriceContainer.style.display = 'none';
            auctionDetails.style.display = 'flex';
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
    
    document.getElementById('start-price').addEventListener('blur', function () {
        const priceInput = document.getElementById('start-price');
        const enteredValue = parseInt(priceInput.value.replace(/\D/g,''));
        if (priceInput.value % 1000 !== 0) {
        	alert("1,000원 단위로 설정 가능합니다.");
        	priceInput.value = '';
        }
    });
    
    document.getElementById('immediate-price').addEventListener('blur', function () {
        const priceInput = document.getElementById('immediate-price');
        const enteredValue = parseInt(priceInput.value.replace(/\D/g,''));
        if (priceInput.value % 1000 !== 0) {
        	alert("1,000원 단위로 설정 가능합니다.");
        	priceInput.value = '';
        }
    });
    
    function salewrite() {
        var option = $('#selectedOption').val();
        var price = $('#price').val();
        var auctionPeriod = $('#auction-period').val();
        var startPrice = $('input[name="start-price"]').val();
        var immediatePrice = $('input[name="immediate-price"]').val();
        var category = $('select[name="category"]').val();
        var title = $('input[name="subject"]').val();
        //var photos = $('input[name="photos"]').eq(0).prop('files');
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
        } else if (tempoPhotoArr.length === 0) {
	        alert("사진을 선택해주세요");
	        return;
	    } else if (content == "") {
            alert("내용을 입력해주세요");
            return;
        } else if (place == "") {
            alert("거래 희망 장소를 입력해주세요");
            return;
        }
        
        if (option === '경매') {
            if (confirm("경매 게시글의 경우 수정이 불가합니다. 정말로 저장하시겠습니까?")) {
                sendSaleWriteRequest();
            }
        } else {
            sendSaleWriteRequest();
        }

	}
    
    function sendSaleWriteRequest() {
    	
        var formData = new FormData($('form')[0]);

        // tempoPhotoArr 배열을 FormData에 추가
        tempoPhotoArr.forEach(function(photoName) {
        	console.log(photoName);
            formData.append('tempoPhotoNames[]', photoName);
            console.log(formData);
        });        

        //$('form').submit();
        $.ajax({
            url: $('form').attr('action'),
            type: $('form').attr('method'),
            data: formData,
            processData: false, 
            contentType: false,
            success: function(response) {
                alert('글이 성공적으로 작성되었습니다.');
                window.location.href="/main";
            },
            error: function(xhr, status, error) {
                alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
                console.error(xhr.responseText);
            }
        });
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
    
    
    
    
    // 사진 추가를 클릭했을 때,
    $('.photo-tempo').on('click', '#photoSelect', function() {
    	$('.photo-select').addClass('active');
    });
    // 사진 저장 클릭
    $('#photoSave').on('click', function() {
    	// 사진의 개수가 10개가 넘는지 확인
    	
    	// FormData 객체를 활용하여 파일을 전송
    	var formData = new FormData();
    	var photos = $('input[name="photos"]')[0].files;
    	for (var i = 0; i < photos.length; i++) {
    		console.log(photos[i]);
			formData.append('photos', photos[i]);
		}
    	
    	// .tempoBbsIdx가 존재하는지 확인 (즉, 사진을 추가한 것인지?)
    	var tempoBbsIdx = $('.photo-tempo .tempoBbsIdx').val();
    	if (tempoBbsIdx) {
    		formData.append('tempoBbsIdx', tempoBbsIdx);
    		console.log(tempoBbsIdx);
    		
    	    // 만약 .tempoBbsIdx가 존재한다면 다른 ajax 실행
    	    $.ajax({
    	    	url: '<c:url value="/board/tempoPhotoAnother.ajax"/>',
    	        type: 'POST',
    	        data: formData,
    	        contentType: false,
    	        processData: false,
    	        enctype: 'multipart/form-data',
    	        success: function(response) {
    	        	drawTempoPhotoList(response);
    	        }
    	    });
    	} else {
	    	$.ajax({
	    		url: '<c:url value="/board/tempoPhoto.ajax"/>',
	    		type: 'POST',
	    		data: formData,
	    		contentType: false,
	    		processData: false,
	    		enctype: 'multipart/form-data',
	    		success: function(response) {
	    			drawTempoPhotoList(response);
	    		}
	    	});
	    }
    	
    	$('.photo-select').removeClass('active');
    });
    // drawTempoPhotoList
    function drawTempoPhotoList(data) {
    	$('.photo-tempo').empty();
    	
    	var content = '';
    	
    	var listIdx = 0;
    	
    	// tempoPhotoArr 초기화
    	tempoPhotoArr = [];
    	
    	for (var item of data.list) {
    		tempoPhotoArr.push(item);
    		
    		content += '<div class="photo-select-photo">';
			content += '<img src="/photo/'+(item)+'"/>';
			content += '<i class="fa-solid fa-trash"></i>';
    		content += '<input type="hidden" class="tempoPhotoIdx" value="'+data.list2[listIdx]+'"/>';
    		content += '<input type="hidden" class="tempoBbsIdx" value="'+data.photoTempoIdx+'"/>';
			content += '</div>';
			listIdx ++;
		}   		
   		
    	content += '<p id="photoSelect">사진 선택</p>';
    	
    	$('.photo-tempo').append(content);
    }
    // 사진 이름 저장하기,,, 폐기
    /* function setTempoPhotoNames(formData) {
	    var tempoPhotoNames = [];
	    $('.tempoPhotoNames').each(function() {
	        tempoPhotoNames.push($(this).val());
	    });
	    $('input[name="tempoPhotoNames[]"]').remove();
	    tempoPhotoNames.forEach(function(tempoPhotoName) {
	        $('<input>').attr({
	            type: 'hidden',
	            name: 'tempoPhotoNames[]',
	            value: tempoPhotoName
	        }).appendTo('form');
	        formData.append('tempoPhotoNames[]', tempoPhotoName);
	    });
	} */
    
    // 사진 삭제
    $('.photo-tempo').on('click', '.fa-trash', function() {
    	var pic_idx = $(this).closest('.photo-select-photo').find('.tempoPhotoIdx').val();
    	var tempoBbsIdx = $(this).closest('.photo-select-photo').find('.tempoBbsIdx').val();
    	
    	$.ajax({
    		url: '<c:url value="/board/tempoPhotoDel.ajax"/>',
    		type: 'POST',
    		data: {
    			'pic_idx': pic_idx,
    			'tempoBbsIdx': tempoBbsIdx
    		},
    		dataType: 'JSON',
    		success: function(response) {
    			drawTempoPhotoList(response);
    		}
    	});
    });
    


</script>
</body>
</html>
