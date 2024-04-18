<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
				<div class="goods-photo"></div>
				<div class="goods-subject"></div>
				<div class="goods-price"></div>
				<div class="goods-bottom"></div>
			</div>
		</div>
	</div>

</body>

<script>
</script>
</html>