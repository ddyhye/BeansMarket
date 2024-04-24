<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/mine.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="mine-top">
				<p id="nic">${name}&nbsp;</p>
				<p>님의 관심 목록</p>
			</div>
			<div class="mine-center">
				<div class="mine-content-goods">
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
				<div class="mine-content-goods"></div>
				<div class="mine-content-goods"></div>
				<div class="mine-content-goods"></div>
				<div class="mine-content-goods"></div>
				<div class="mine-content-goods"></div>
				<div class="mine-content-goods"></div>
			</div>
		</div>
	</div>

</body>

<script>

		
	listCall();	
		
	function listCall() {
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/mineList.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data) {
				drawGoodsList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}

	function drawGoodsList(data) {
		$('.mine-center').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<p> 관심 목록에 넣은 물품이 없습니다. </p>';
		}
		for (item of data.list) {
			content += '<div class="mine-content-goods'+(item.bbs_state === '거래완료' ? ' sold-out' : '')+'">';
			content += '<div class="goods-idx" style="display: none;">'+item.idx+'</div>';
			content += '<div class="mine-content-goods">';
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
			content += '</div>';
		}
		
		$('.main-content').append(content);
	}

</script>
</html>