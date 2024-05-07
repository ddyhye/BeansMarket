<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<c:url value='/resources/css/inquireWrite.css'/>" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="../common.jsp" />
	
	<div class="container">
		<h2>1:1 문의하기</h2>
		<form action="<c:url value='/customerService/inquireWrite.do'/>" method="POST" enctype="multipart/form-data">
	        <div class="inquire-subject">
	        	<div class="form-head">
	            	제목
	            </div>
	            <input name="inquireSubject" type="text" id="inquireSubject" placeholder="제목을 입력해 주세요...">
	        </div>
	        
	        <div class="photo">
	        	<div class="form-head">
		            <label for="photo">사진</label>
	            </div>
	            <div class="photo-tempo">
	            	<p id="photoSelect">사진 선택</p>
	            </div>
	            <div class="photo-select">
	            	<input type="file" multiple="multiple" name="photos">
	            	<p id="photoSave">확인</p>
	            </div>
	        </div>
	
	        <div class="salecategory">
	        	<div class="form-head">
		            <label for="category">문의 옵션</label>
	            </div>
	            <select name="category" id="selectCategory">
	                <option value="q001">계정</option>
	                <option value="q002">시스템</option>
	                <option value="q003">경매</option>
	                <option value="q004">신고</option>
	                <option value="q005">기타</option>
	            </select>
	        </div>
	        
	        <div class="inquire-pw">
	        	<div class="form-head">
	            	비밀번호
	            </div>
	            <input name="inquirePw" type="password" id="inquirePw"/>
	        </div>
	
	        <div class="content">
	        	<div class="form-head" id="form-head-content">
	 	            <label for="content">설명</label>
	            </div>
	            <textarea id="content" name="content" placeholder="게시글 내용을 작성해 주세요"></textarea>
	        </div>
	        
	        <div class="inquire-button">
	        	<button type="button" onclick="inquireWrite()" id="save-button">저장</button>
	        </div>
	
	    </form>
	</div>


</body>

<script>
	//사진의 new_picname을 담을 전역 배열 선언
	var tempoPhotoArr = []; 


	function inquireWrite() {
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
        
        var formData = new FormData($('form')[0]);

        // tempoPhotoArr 배열을 FormData에 추가
        tempoPhotoArr.forEach(function(photoName) {
            formData.append('tempoPhotoNames[]', photoName);
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
                window.location.href="/main/customerService/inquire.go";
            },
            error: function(xhr, status, error) {
                alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
                console.error(xhr.responseText);
            }
        });
    }
	
	
	//사진 추가를 클릭했을 때,
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
		    	url: '<c:url value="/customerService/tempoPhotoAnother.ajax"/>',
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
	    		url: '<c:url value="/customerService/tempoPhoto.ajax"/>',
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
	
	
	// 사진 삭제
    $('.photo-tempo').on('click', '.fa-trash', function() {
    	var pic_idx = $(this).closest('.photo-select-photo').find('.tempoPhotoIdx').val();
    	var tempoBbsIdx = $(this).closest('.photo-select-photo').find('.tempoBbsIdx').val();
    	
    	$.ajax({
    		url: '<c:url value="/customerService/tempoPhotoDel.ajax"/>',
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
</html>