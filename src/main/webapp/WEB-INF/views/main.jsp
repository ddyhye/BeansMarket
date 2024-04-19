<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="resources/css/main.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
	<jsp:include page="common.jsp" />

	<div class="container">
		<div class="main-subject">
			<div class="main-subject-left">
				<p id="main-subject-text">&nbsp;&nbsp;Beans Market
					중고거래&nbsp;&nbsp;</p>
			</div>
			<div class="main-subject-center">
				<select name="goodsSort" id="main-subject-sort">
					<option value="최신순">최신순</option>
					<option value="인기순">인기순</option>
				</select>
			</div>
		</div>
		<div class="main-subject-saleOption">
			<input type="checkbox" name="saleOption" class="sellOption-checkbox" id="saleOption1" checked/>나눔/판매&nbsp;&nbsp; 
			<input type="checkbox" name="saleOption" class="sellOption-checkbox" id="saleOption2" checked/>경매&nbsp;&nbsp;
		</div>
		<div class="main-content">
			<div class="main-content-goods">
				<div class="goods-top">
					<div class="goods-top-left">
						<p>나는야판매왕</p>
					</div>
					<div class="goods-top-right">
						<div class="saleOption-Auc">
							<span>경매</span>
						</div>
					</div>
				</div>
				<div class="goods-photo">
					<img src="resources/img/checked.png" alt="경매사진"/>
					<img src="resources/img/unHeart.png" class="clickHeart" alt="찜"/>
				</div>
				<div class="goods-subject">
					<span>2014 A/W 루이비통 레드 이상하게 생긴 가방</span>
				</div>
				<div class="goods-price-1">
					<div class="goods-price-1-left">
						<span>&nbsp;현재가&nbsp;&nbsp;</span><span class="Price">450,000</span>
					</div>
					<div class="goods-price-1-right">
						<span>❤</span><span class="Hit">11&nbsp;</span>
					</div>
				</div>
				<div class="goods-price-2">
					<span>&nbsp;즉구가&nbsp;&nbsp;</span><span class="highPrice">900,000</span>
				</div>
				<div class="goods-bottom">
					<div class="goods-bottom-left">
						<span>&nbsp;입찰자&nbsp;&nbsp;</span><span class="Cnt">0</span>
					</div>
					<div class="goods-bottom-right">
						<span>4/18 23:11&nbsp;</span>
					</div>
				</div>
			</div>
			
			<!-- 게시글 리스트 -->
			<!-- 
			<c:if test="${list.size() < 1}">
				<p> 판매중인 상품이 없습니다.</p>
			</c:if>
			<c:forEach items="${list}" var="item">
				<div class="main-content-goods">
					<div class="goods-top">
						<div class="goods-top-left">
							<p>${item.sellerName}</p>
						</div>
						<div class="goods-top-right">
							<c:if test="${item.option == '경매'}">
								<div class="saleOption-Auc">
									<span>경매</span>
								</div>
							</c:if>
						</div>
					</div>
					<div class="goods-photo">
						<img src="/photo/${item.new_picname}" alt="${item.new_picname}" />
						<img src="resources/img/unHeart.png" id="clickHeart" alt="찜" />
					</div>
					<div class="goods-subject">
						<span>${item.subject}</span>
					</div>
					<div class="goods-price-1">
						<div class="goods-price-1-left">
							<span>&nbsp;현재가&nbsp;&nbsp;</span><span id="Price">${item.price}</span>
						</div>
						<div class="goods-price-1-right">
							<span>❤</span><span id="Hit">11&nbsp;</span>
						</div>
					</div>
					<div class="goods-price-2">
						<c:if test="${item.option == '경매'}">
							<span>&nbsp;즉구가&nbsp;&nbsp;</span>
							<span id="highPrice">${item.successful_bid}</span>
						</c:if>
					</div>
					<div class="goods-bottom">
						<div class="goods-bottom-left">
							<c:if test="${item.option == '경매'}">
								<span>&nbsp;입찰 &nbsp;&nbsp;</span>
								<span id="Cnt">0</span>
							</c:if>
						</div>
						<div class="goods-bottom-right">
							<span>${item.reg_date}&nbsp;</span>
						</div>
					</div>
				</div>
			</c:forEach>
			 -->
		</div>
	</div>
</body>

<script>
	// 최신순, 인기순 select-option
	var selectedSort = $('#main-subject-sort').val();
	$('#main-subject-sort').change(function() {
		selectedSort = $(this).val();
		console.log("선택된 정렬 옵션: " + selectedSort);
		listCall(selectedSort, sellOptionChk, AuctionOptionChk);
	});
	// 판매, 경매 checkbox
	var sellOptionChk = $('#saleOption1').is(':checked');
	var AuctionOptionChk = $('#saleOption2').is(':checked');
	$('.sellOption-checkbox').change(function() {
		sellOptionChk = $('#saleOption1').is(':checked');
		AuctionOptionChk = $('#saleOption2').is(':checked');
		console.log("나눔/판매 체크: " + sellOptionChk);
	    console.log("경매 체크: " + AuctionOptionChk);
	    listCall(selectedSort, sellOptionChk, AuctionOptionChk);
	});
	

	listCall(selectedSort, sellOptionChk, AuctionOptionChk);
	
	// 물품 리스트 출력
	function listCall(selectedSort, sellOptionChk, AuctionOptionChk) {
		console.log('click!!!');
		$.ajax({
			type: 'get',
			url: './list.ajax',
			data: {
				'selectedSort': selectedSort,
				'sellOptionChk': sellOptionChk,
				'AuctionOptionChk': AuctionOptionChk
			},
			dataType: 'JSON',
			success: function(data) {
				drawGoodsList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	// drawList 함수 : 물품 그리기
	function drawGoodsList(data) {
		$('.main-content').empty();
		
		var content = '';
		
		if (data.list == null) {
			content += '<p> 판매중인 상품이 없습니다. </p>';
		}
		for (item of data.list) {
			content += '<div class="main-content-goods">';
			content += '<div class="goods-top">';
			content += '<div class="goods-top-left"><p>'+item.sellerName+'</p></div>';
			content += '<div class="goods-top-right">';
			content += item.option == '경매'? '<div class="saleOption-Auc"><span>경매</span></div>':'';
			content += '</div></div>';
			content += '<div class="goods-photo">';
			content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
			content += '<img src="resources/img/unHeart.png" class="clickHeart" alt="찜"/></div>';
			content += '<div class="goods-subject"><span>'+item.subject+'</span></div>';
			content += '<div class="goods-price-1">';
			content += '<div class="goods-price-1-left">';
			content += '<span>&nbsp;현재가&nbsp;&nbsp;</span><span id="Price">'+item.price+'</span></div>';
			content += '<div class="goods-price-1-right"><span>❤</span><span class="Hit">&nbsp;</span></div>';
			content += '</div>';
			content += '<div class="goods-price-2">';
			content += item.option == '경매'? '<span>&nbsp;즉구가&nbsp;&nbsp;</span><span class="highPrice">'+item.successful_bid+'</span>':'';
			content += '</div>';
			content += '<div class="goods-bottom">';
			content += '<div class="goods-bottom-left">';
			content += item.option == '경매'? '<span>&nbsp;입찰 &nbsp;&nbsp;</span><span class="Cnt">0</span></div>':'</div>';
			content += '<div class="goods-bottom-right">';
			content += '<span>'+item.reg_date+'&nbsp;</span>';
			content += '</div></div></div>';
		}
		
		$('.main-content').append(content);
	}
	
	
	
	// 관심물품 등록/삭제
	$('.main-content').on('click', '.clickHeart', function() {
		var isToggled = $(this).data('toggled');
		
		if (!isToggled) {
			$(this).attr('src', 'resources/img/heart.png');
		} else {
			$(this).attr('src', 'resources/img/unHeart.png');
		}
		
		$(this).data('toggled', !isToggled);
	});

</script>
</html>