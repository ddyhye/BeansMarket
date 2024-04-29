	com.beans.market<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/myBuyList.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="buy-top">
				<p id="nic">${name}&nbsp;</p>
				<p>님의 구매 내역&nbsp;&nbsp;</p>
			</div>
			<div class="buy-center">
				<!-- <div class="buy-center-list">
					<div class="buy-center-list-left">
						<img src="/photo/juka.png"/>
					</div>
					<div class="buy-center-list-center">
						<div class="buy-center-list-center-content">
							<p>주카의 사진 1000원부터&nbsp;&nbsp;&nbsp;</p>
							<div class="buy-center-list-center-mark1"><span>경매</span></div>
						</div>
						<div class="buy-center-list-center-price">
							<p>450,000원&nbsp;&nbsp;&nbsp;</p>
							<div class="buyl-center-list-center-mark2"><span>거래완료</span></div>
						</div>
					</div>
					<div class="buy-center-list-right">
						<i class="fa-solid fa-ellipsis"></i>
						<div class="moreOption">
							<p>삭제</p>
						</div>
					</div>
				</div> -->
			</div>
			
			<div class=""></div>
		</div>
	</div>
</body>

<script>
	listCall();	
	
	function listCall() {
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/myBuyList.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data) {
				drawBuyList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	
	function drawBuyList(data) {
		$('.buy-center').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<p> 구매 내역이 없습니다. </p>';
		}
		for (item of data.list) {
			content += '<div class="buy-center-list">';
			content += '<div class="buy-center-list-idx" style="display: none;">'+item.idx+'</div>';
			content += '<div class="buy-center-list-left'+(item.hidden === 'Y' ? ' hide':'')+'">';
			content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
			content += (item.hidden === 'Y' ? '<i class="fa-solid fa-eye-slash"></i>':'');
			content += '</div>';
			content += '<div class="buy-center-list-center">';
			content += '<div class="buy-center-list-center-content">';
			content += '<p>'+item.subject+'&nbsp;&nbsp;&nbsp;</p>';
			content += (item.option === '경매'? '<div class="buy-center-list-center-mark1"><span>경매</span></div>':'');
			content += '</div>';
			content += '<div class="buy-center-list-center-price">';
			content += '<p>'+item.price+'$&nbsp;&nbsp;&nbsp;</p>';
			content += (item.bbs_state === '거래완료' ? '<div class="buy-center-list-center-mark2"><span>거래완료</span></div>' : '');
			content += '</div></div>';
			content += '<div class="buy-center-list-right">';
			content += '<i class="fa-solid fa-ellipsis"></i>';
			content += '<div class="moreOption">';
			content += '<p>삭제</p>';
			content += '</div>';
			content += '</div>';
			content += '</div>';
		}
		
		$('.buy-center').append(content);
	}
	
	// 글 숨기기, 삭제 보이기
	$('.buy-center').on('click', '.fa-ellipsis', function(event){
		event.stopPropagation();
		
		$(this).closest('.buy-center-list-right').find('.moreOption').toggle();
	});
	// 글 숨기기, 삭제
	$('.buy-center').on('click', '.moreOption p', function(event){
		event.stopPropagation();
		
		var idx = $(this).closest('.buy-center-list').find('.buy-center-list-idx').text();
		var pText = $(this).text();
		
		console.log(pText);
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/myBuyManage.ajax"/>',
			data: {
				'idx' : idx,
				'pText': pText
			},
			dataType: 'JSON',
			success: function(data){
				drawSellList(data);
			}, error: function(data){}
		});
		
	});
	// 고객서비스 - 최근 본 물품 추가하기 && 게시글 디테일 보기
	$('.buy-center').on('click', '.buy-center-list', function() {
		var idx = $(this).find('.buy-center-list-idx').text().trim();
		
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
</script>
</html>