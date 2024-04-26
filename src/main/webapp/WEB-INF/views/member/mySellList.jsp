<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/mySellList.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="sell-top">
				<p id="nic">${name}&nbsp;</p>
				<p>님의 판매 내역&nbsp;&nbsp;</p>
				<select name="listSort" id="sell-top-sort">
					<option value="전체보기">전체보기</option>
					<option value="판매 중">판매 중</option>
					<option value="거래 완료">거래 완료</option>
					<option value="숨김">숨김</option>
				</select>
			</div>
			<div class="sell-center">
				<!-- <div class="sell-center-list">
					<div class="sell-center-list-left">
						<img src="/photo/juka.png"/>
					</div>
					<div class="sell-center-list-center">
						<div class="sell-center-list-center-content">
							<p>주카의 사진 1000원부터&nbsp;&nbsp;&nbsp;</p>
							<div class="sell-center-list-center-mark1"><span>경매</span></div>
						</div>
						<div class="sell-center-list-center-price">
							<p>450,000원&nbsp;&nbsp;&nbsp;</p> 판매면판매가, 경매면 현재가 근데 둘다 price로 똑같
							<div class="sell-center-list-center-mark2"><span>거래완료</span></div>
						</div>
					</div>
					<div class="sell-center-list-right">
						<i class="fa-solid fa-ellipsis"></i>
						<div class="moreOption">
							<p>숨김</p>
							<p>삭제</p>
						</div>
					</div>
				</div>
				<div class="sell-center-list">
					<div class="sell-center-list-left hide">
						<img src="/photo/juka.png"/>
						<i class="fa-solid fa-eye-slash"></i>
					</div>
					<div class="sell-center-list-center">
						<div class="sell-center-list-center-content">
							<p>주카의 사진 1000원부터&nbsp;&nbsp;&nbsp;</p>
							<div class="sell-center-list-center-mark1"><span>경매</span></div>
						</div>
						<div class="sell-center-list-center-price">
							<p>450,000원&nbsp;&nbsp;&nbsp;</p> 판매면판매가, 경매면 현재가 근데 둘다 price로 똑같
							<div class="sell-center-list-center-mark2"><span>거래완료</span></div>
						</div>
					</div>
					<div class="sell-center-list-right">
						<i class="fa-solid fa-ellipsis"></i>
						<div class="moreOption">
							<p>숨김</p>
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

	//최신순, 인기순 select-option
	var selectedSort = $('#sell-top-sort').val();
	$('#sell-top-sort').change(function() {
		selectedSort = $(this).val();
		
		listCall(selectedSort);
	});

	listCall(selectedSort);	
	
	function listCall(selectedSort) {
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/mySellList.ajax"/>',
			data: {
				'selectedSort': selectedSort
			},
			dataType: 'JSON',
			success: function(data) {
				drawSellList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	
	function drawSellList(data) {
		$('.sell-center').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<p> 판매 내역이 없습니다. </p>';
		}
		for (item of data.list) {
			content += '<div class="sell-center-list">';
			content += '<div class="sell-center-list-idx" style="display: none;">'+item.idx+'</div>';
			content += '<div class="sell-center-list-left'+(item.hidden === 'Y' ? ' hide':'')+'">';
			content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
			content += (item.hidden === 'Y' ? '<i class="fa-solid fa-eye-slash"></i>':'');
			content += '</div>';
			content += '<div class="sell-center-list-center">';
			content += '<div class="sell-center-list-center-content">';
			content += '<p>'+item.subject+'&nbsp;&nbsp;&nbsp;</p>';
			content += (item.option === '경매'? '<div class="sell-center-list-center-mark1"><span>경매</span></div>':'');
			content += '</div>';
			content += '<div class="sell-center-list-center-price">';
			content += '<p>'+item.price+'$&nbsp;&nbsp;&nbsp;</p>';
			content += (item.bbs_state === '거래완료' ? '<div class="sell-center-list-center-mark2"><span>거래완료</span></div>' : '');
			content += '</div></div>';
			content += '<div class="sell-center-list-right">';
			content += '<i class="fa-solid fa-ellipsis"></i>';
			content += '<div class="moreOption">';
			content += (item.hidden === 'Y' ? '<p>숨김 해제</p>' : '<p>숨김</p>');
			content += '<p>삭제</p>';
			content += '</div>';
			content += '</div>';
			content += '</div>';
		}
		
		$('.sell-center').append(content);
	}
	
	// 글 숨기기, 삭제 보이기
	$('.sell-center').on('click', '.fa-ellipsis', function(event){
		event.stopPropagation();
		
		$(this).closest('.sell-center-list-right').find('.moreOption').toggle();
	});
	// 글 숨기기, 삭제
	$('.sell-center').on('click', '.moreOption p', function(event){
		event.stopPropagation();
		
		var idx = $(this).closest('.sell-center-list').find('.sell-center-list-idx').text();
		var pText = $(this).text();
		
		console.log(pText);
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/mySellManage.ajax"/>',
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
	$('.sell-center').on('click', '.sell-center-list', function() {
		var idx = $(this).find('.sell-center-list-idx').text().trim();
		
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