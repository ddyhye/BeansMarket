<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원차단</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../resources/css/otherMemberProfile.css" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
    </style>
</head>


<body>
    <jsp:include page="../common.jsp"/>
    	<div class="container">
    		<div class="other-top">
    			<div class="other-top-left">
    				<img src="/photo/${photo}"/>
    			</div>
    			<div class="other-top-center">
    				<div class="other-top-center-nic">
	    				<h2 class="nic">${name}</h2>
	    				<input type="hidden" class="otherEmail" value="${email}"/>
    				</div>
    				<div class="other-top-center-comment">
    					<i class="fa-regular fa-face-laugh-squint"></i>
						<p>&nbsp;${posiCnt}&nbsp;&nbsp;&nbsp;&nbsp;</p>
						<i class="fa-regular fa-face-rolling-eyes"></i>
						<p>&nbsp;${negaCnt}</p>
    				</div>
    			</div>
    			<div class="other-top-right">
    				<p id="banBtn">차단하기</p>
    			</div>
    		</div>
    		
   			<div class="other-center-title">
   				<p id="nic">${name}&nbsp;</p>
				<p>님의 판매 상품</p>
   			</div>
   			
    		<div class="other-center">
	    		<div class="other-content-goods">
					<div class="goods-top">
						<div class="goods-top-left">
							<p>&nbsp;나는야판매왕</p>
						</div>
						<div class="goods-top-right">
							<div class="saleOption-Auc">
								<span>경매</span>
							</div>
						</div>
					</div>
					<div class="goods-photo">
						<img src="resources/img/checked.png" alt="경매사진" /> <img
							src="resources/img/unHeart.png" class="clickHeart" alt="찜" />
					</div>
					<div class="goods-subject">
						<span>2014 A/W 루이비통 레드 이상하게 생긴 가방</span>
					</div>
					<div class="goods-price">
						<span class="Price">450,000</span>
					</div>
				</div>
				<div class="other-content-goods"></div>
				<div class="other-content-goods"></div>
				<div class="other-content-goods"></div>
				<div class="other-content-goods"></div>
				<div class="other-content-goods"></div>
				<div class="other-content-goods"></div>
    		</div>
    	</div>
    </div>
</body>


<script>	
	listCall();	
	
	function listCall() {
		var otherEmail = $('.otherEmail').val();
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/otherGoodsList.ajax"/>',
			data: {
				'otherEmail': otherEmail
			},
			dataType: 'JSON',
			success: function(data) {
				drawGoodsList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	
	function drawGoodsList(data) {
		$('.other-center').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<p> 판매중인 상품이 없습니다. </p>';
		}
		for (item of data.list) {
			content += '<div class="other-content-goods'+(item.bbs_state === '거래완료' ? ' sold-out' : '')+'">';
			content += '<div class="goods-idx" style="display: none;">'+item.idx+'</div>';
			content += '<div class="goods-top">';
			content += '<div class="goods-top-left">';
			content += '<p>&nbsp;'+item.sellerName+'</p></div>';
			content += '<div class="goods-top-right">';
			var mark = item.bbs_state === '거래완료'? '<div class="goods-top-right-mark1"><span>Sold Out</span></div>': (item.option === '경매'? '<div class="goods-top-right-mark2"><span>경매</span></div>':'');
			content += mark;
			content += '</div></div>';
			content += '<div class="goods-photo">';
			content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
			var heart_img_path = item.mine == 1? '<c:url value="/resources/img/heart.png"/>': '<c:url value="/resources/img/unHeart.png"/>';
			content += '<img src="'+heart_img_path+'" class="clickHeart" alt="찜"/></div>';
			content += '<div class="goods-subject">';
			content += '<span>'+item.subject+'</span>';
			content += '</div>';
			content += '<div class="goods-price">';
			content += '<span class="Price">'+item.price+'</span>';
			content += '</div></div>';
		}
		
		$('.other-center').append(content);
	}
	
	// 고객서비스 - 관심물품 등록/삭제
	$('.other-center').on('click', '.clickHeart', function(event) {
		// 이벤트 버블링 방지 (하트 누를 때 게시글 이동 방비)
		event.stopPropagation();
		
		var idx = $(this).closest('.other-content-goods').find('.goods-idx').text();
		var currImg = $(this).attr('src');
		
		var isHearted = currImg.includes('heart.png');
		var isToggled = !isHearted
		
		// 사진 및 토글 상태 업데이트
		var newImg = isToggled ? '<c:url value="/resources/img/heart.png"/>':'<c:url value="/resources/img/unHeart.png"/>';
		$(this).attr('src', newImg);
		$(this).data('toggled', isToggled);
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/clickHeart2.ajax"/>',
			data: {
				'idx': idx,
				'isToggled': isToggled
			},
			dataType: 'JSON',
			success: function(data) {
				if (data.msg != '') {
					alert(data.msg);
				}
			}, error: function(error) {
			}
		});
	});
	
	// 고객서비스 - 최근 본 물품 추가하기 && 게시글 디테일 보기
	$('.other-center').on('click', '.other-content-goods', function() {
		var idx = $(this).find('.goods-idx').text().trim();
		
		// 세션 스토리지에 저장된 idx 목록 불러오기 (없으면 말고)
		var currIdxArr = sessionStorage.getItem('recentLookIdx');
		currIdxArr = currIdxArr ? JSON.parse(currIdxArr) : [];
		
		// 방금 본 게시글이 최근 본 목록에 있으면 세션 기록에서 삭제
		var idxPosition = currIdxArr.indexOf(idx);
		if (idxPosition > -1) {
			currIdxArr.splice(idxPosition, 1);
		}
		
		currIdxArr.unshift(idx);
		
		if (currIdxArr.length > 9) {
			currIdxArr.pop();
		}
		
		sessionStorage.setItem('recentLookIdx', JSON.stringify(currIdxArr));
		
		// 남은 자리수가 있다면,9까지 0으로 채우기
	    while (currIdxArr.length < 9) {
	        currIdxArr.push(0);
	    }
	    
	   	// 게시글 디테일로 이동
	   	window.location.href = '<c:url value="/board/detail.go?idx='+idx+'"/>';
	});
	
	
	// 차단하기
	$('#banBtn').on('click', function() {
		var otherEmail = $('.otherEmail').val();
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/otherBan.ajax"/>',
			data: {
				'otherEmail': otherEmail
			},
			dataType: 'JSON',
			success: function(data) {
				if (data.msg != '') {
					alert(data.msg);
				}
			}, error: function(error) {
				console.log(error);
			}
		});
	});
	
	
	
</script>

</html>