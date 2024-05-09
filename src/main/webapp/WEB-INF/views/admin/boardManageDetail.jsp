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
		
		<div class="buttons">
			<button class="Blind-button">블라인드</button>
		</div>
		
<%--  		<!-- 버튼 모달창 -->
		<div id="auctionCancelModal">
			<form action="<c:url value='/admin/bbsAuction.do'/>">
				<p>해당 게시물 경매를 취소시키겠습니까?</p>
				<p style="font-size: 12px; color: red;">*입찰금은 마지막 입찰자에게 반환됩니다.</p>
				<div class="auc-button">
					<!-- <button id="auctionCancelModal-del1" onclick="Adel()">확인</button> -->
					<input type="hidden" name="idx1" value="${idx}"/>
					<input type="submit" id="auctionCancelModal-del1" value="확인"/>
					<button id="auctionCancelModal-del2">취소</button>
				</div>
			</form>
		</div> --%>
		<div id="BlindModal">
			<form action="<c:url value='/admin/bbsBlind.do'/>">
				<p>해당 게시글을 블라인드 처리하시겠습니까?</p>
				<div class="bli-button">
					<input type="hidden" name="idx" value="${idx}"/>
					<input type="submit" id="BlindModal-del1" value="확인"/>
					<button id="BlindModal-del2">취소</button>
				</div>
			</form>
		</div>
		<div id="BlindModalDel">
			<form action="<c:url value='/admin/bbsBlindDel.do'/>">
				<p>해당 게시글을 블라인드 해제하시겠습니까?</p>
				<div class="bliDel-button">
					<input type="hidden" name="idx" value="${idx}"/>
					<input type="submit" id="BlindModalDel-del3" value="확인"/>
					<button id="BlindModalDel-del4">취소</button>
				</div>
			</form>
		</div>
		<div class="manager-boarddetail1">
		<table>
			<thead>
			  <tr>
				<th class="one">글번호</th>
				<th class="two">판매자 이메일</th>
				<th class="three">판매 옵션</th>
				<th class="four">거래 상태</th>
				<th class="five">위치</th>
				<th class="six">등록일시</th>
			  </tr>
			</thead>
			<tbody id="list1">
			  <tr>
				<td class="one">${idx}</td>
				<td class="two">${email}</td>
				<td class="three">${option}</td>
				<td class="four">${bbs_state}</td>
				<td class="five">${location}</td>
				<td class="six">${reg_date}</td>
			  </tr>	
			</tbody>
		</table>
		</div>
		
		<div class="manager-boarddetail2">
		<table>
			<thead>
			  <tr>
				<th class="seven">블라인드</th>
				<th class="eight">숨기기</th>
				<th class="nine">카테고리 물품 번호</th>
				<th class="ten">임시저장</th>
				<th class="eleven">가격</th>
				<th class="twelve">예약자 이메일</th>
			  </tr>
			</thead>
			<tbody id="list2">
			  <tr>
				<td class="seven">${blind}</td>
				<td class="eight">${hidden}</td>
				<td class="nine">${category_name}</td>
				<td class="ten">${draft}</td>
				<td class="eleven">${price}</td>
				<td class="twelve">${reserve_email}</td>
			  </tr>	
			</tbody>
		</table>
		</div>
		
	</div>

</section>




</main>
</body>

<script>

	var reg_date = DateToStringTime('${reg_date}');
	$('td.one:contains(${idx})').siblings('.six').text(reg_date);
	
	// 경매 취소
/* 	$('.Auction-cancel').on('click', function(){
		$('#auctionCancelModal').addClass('active');
	});
	
	$('#auctionCancelModal-del1').on('click', function(){
		$('#auctionCancelModal').removeClass('active');
	});
	
	$('#auctionCancelModal-del2').on('click', function(){
		$('#auctionCancelModal').removeClass('active');
	}); */
	
	// 블라인드 처리
/* 	$('.Blind-button').on('click', function() {
	    $('#BlindModal').addClass('active');
	}); */
	

	$('#list1').on('click', '.one', function(){
		var boardIdx = $(this).text();
		console.log(boardIdx);
		
	    var url = '<c:url value="/board/detail.go"/>' + '?idx=' + boardIdx;
	    window.location.href = url;
	});


	$('.Blind-button').on('click', function() {
	    var blindValue = "${blind}";

	    if (blindValue === 'Y') {
	    	$('#BlindModalDel').addClass('active');
	        window.location.href = '<c:url value="/admin/bbsBlindDel.do"/>'; // 블라인드가 Y일 때
	    } else if (blindValue === 'N') {
	    	$('#BlindModal').addClass('active');
	        window.location.href = '<c:url value="/admin/bbsBlind.do"/>'; // 블라인드가 N일 때
	    }
	});
	
	$('#BlindModal-del1').on('click', function() {
	    $('#BlindModal').removeClass('active');
	    
	});
	
	$('#BlindModal-del2').on('click', function() {
	    $('#BlindModal').removeClass('active');
	});
	
	$('#BlindModal-del3').on('click', function() {
	    $('#BlindModalDel').removeClass('active');
	    
	});
	
	$('#BlindModal-del4').on('click', function() {
	    $('#BlindModalDel').removeClass('active');
	});
	
	
</script>
</html>