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
				<p id="nic">아루루&nbsp;</p>
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
</script>
</html>