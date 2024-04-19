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
			<input type="checkbox" name="saleOption" class="seleOption-checkbox"
				id="saleOption1" />나눔/판매&nbsp;&nbsp; <input type="checkbox"
				name="saleOption" class="seleOption-checkbox" id="saleOption2" />경매&nbsp;&nbsp;
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
					<img src="resources/img/unHeart.png" id="clickHeart" alt="찜"/>
				</div>
				<div class="goods-subject">
					<span>2014 A/W 루이비통 레드 이상하게 생긴 가방</span>
				</div>
				<div class="goods-price-1">
					<div class="goods-price-1-left">
						<span>&nbsp;현재가&nbsp;&nbsp;</span><span id="Price">450,000</span>
					</div>
					<div class="goods-price-1-right">
						<span>❤</span><span id="Hit">11&nbsp;</span>
					</div>
				</div>
				<div class="goods-price-2">
					<span>&nbsp;현재가&nbsp;&nbsp;</span><span id="highPrice">900,000</span>
				</div>
				<div class="goods-bottom">
					<div class="goods-bottom-left">
						<span>&nbsp;입찰자&nbsp;&nbsp;</span><span id="Cnt">0</span>
					</div>
					<div class="goods-bottom-right">
						<span>4/18 23:11&nbsp;</span>
					</div>
				</div>
			</div>
			<div class="main-content-goods"></div>
			<div class="main-content-goods"></div>
			<div class="main-content-goods"></div>
			<div class="main-content-goods"></div>
			<div id="test"></div>
		</div>
	</div>
</body>

<script>
	// 관심물품 등록/삭제
	$('#clickHeart').on('click', function() {
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