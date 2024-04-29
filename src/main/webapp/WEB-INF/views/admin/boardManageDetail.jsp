<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="../resources/css/boardManageDetail.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
<header>
	<jsp:include page="./common.jsp" />
</header>
<main>
<jsp:include page="./nav.jsp"/>
<section>
<p class="title">게시글 상세보기</p>
	<div class="container">
		<div class="manager-boarddetail1">
		<table>
			<thead>
			  <tr>
				<th class="one">글번호</th>
				<th class="two">판매자 이메일</th>
				<th class="three">판매 옵션</th>
				<th class="four">거래 상태</th>
				<th class="five">조회수</th>
				<th class="six">위치</th>
				<th class="seven">등록일시</th>
			  </tr>
			</thead>
			<tbody id="list1">
			  <tr>
				<td class="one">글번호</td>
				<td class="two">판매자 이메일</td>
				<td class="three">판매 옵션</td>
				<td class="four">거래 상태</td>
				<td class="five">조회수</td>
				<td class="six">가격(입찰가)</td>
				<td class="seven">등록일시</td>
			  </tr>	
			</tbody>
		</table>
		</div>
		
		<div class="manager-boarddetail2">
		<table>
			<thead>
			  <tr>
				<th class="eight">블라인드</th>
				<th class="nine">숨기기</th>
				<th class="ten">카테고리 물품 번호</th>
				<th class="eleven">임시저장</th>
				<th class="twelve">가격</th>
				<th class="thirteen">예약자 이메일</th>
			  </tr>
			</thead>
			<tbody id="list2">
			  <tr>
				<td class="eight">블라인드</td>
				<td class="nine">숨기기</td>
				<td class="ten">카테고리 물품 번호</td>
				<td class="eleven">임시저장</td>
				<td class="twelve">가격</td>
				<td class="thirteen">예약자 이메일</td>
			  </tr>	
			</tbody>
		</table>
		</div>
		
		<!-- 경매일 때만 보여지는 추가 정보 -->
		<div class="manager-auction-boarddetail1">
		<table>
			<thead>
			  <tr>
				<th class="auction-one">현재입찰가</th>
				<th class="auction-two">시작 가격</th>
				<th class="auction-three">즉시 낙찰가</th>
				<th class="auction-four">경매 기간</th>
				<th class="auction-four">종료 일시</th>
			  </tr>
			</thead>
			<tbody id="auction-list1">
			  <tr>
				<td class="auction-one">현재입찰가</td>
				<td class="auction-two">시작 가격</td>
				<td class="auction-three">즉시 낙찰가</td>
				<td class="auction-four">경매 기간</td>
				<td class="auction-four">종료 일시</td>
			  </tr>	
			</tbody>
		</table>
		</div>
		
		<a href="<c:url value="/admin/bidHistory.go"/>">더보기</a>
		
		<div class="manager-auction-boarddetail2">
		<table>
			<thead>
			  <tr>
				<th class="auction-eight">입찰번호</th>
				<th class="auction-nine">등록 일시</th>
				<th class="auction-ten">대상 회원</th>
				<th class="auction-eleven">금액</th>
			  </tr>
			</thead>
			<tbody id="auction-list2">
			  <tr>
				<td class="eight">입찰번호</td>
				<td class="nine">등록 일시</td>
				<td class="ten">대상 회원</td>
				<td class="eleven">금액</td>
			  </tr>	
			</tbody>
		</table>
		</div>
		
	</div>

</section>




</main>




</body>

<script>
</script>
</html>