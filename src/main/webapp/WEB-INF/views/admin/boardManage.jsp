<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="../resources/css/boardManage.css" type="text/css"/>
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
<p class="title">게시글 검색</p>
	<div class="container">
		<div class="manager-search">
		<table>
		<tr>
	        <td colspan="2" class="search">
	        <input type="text" name="search" id="text-search" placeholder="검색할 제목 또는 게시글 번호를 입력해주세요"/>
	        <button class="button-search">검색</button>
	        </td>
	        <td colspan="2" class="category">
	            <label for="category">카테고리</label>
	            <select name="category" id="category-search">
	                <option value="m001">선택</option>
	                <option value="m001">디지털 기기</option>
	                <option value="m002">가구/인테리어</option>
	                <option value="m003">유아동</option>
	                <option value="m004">여성 패션</option>
	                <option value="m005">여성 잡화</option>
	                <option value="m006">뷰티 미용</option>
	                <option value="m007">남성 패션/잡화</option>
	                <option value="m008">생활가전</option>
	                <option value="m009">생활/주방</option>
	                <option value="m010">가공식품</option>
	                <option value="m011">스포츠/레저</option>
	                <option value="m012">취미/게임/음반</option>
	                <option value="m013">식물</option>
	                <option value="m014">반려동물 용품</option>
           		</select>
           	</td>
        </tr>
		<tr>
	        <td class="state">
	            <label for="state">거래 상태</label>
	            <select id="state" id="state-search">
	                <option value="0">전체</option>
	                <option value="1">거래 가능</option>
	                <option value="2">예약 중</option>
	                <option value="3">거래 완료</option>
	            </select>
	        </td>
	        <td class="date">등록일</td>
	        <td class="blind">
	            <label for="blind">블라인드 여부</label>
	            <select id="blind" id="blind-search">
	                <option value="ALL">전체</option>
	                <option value="Y">Y</option>
	                <option value="N">N</option>
           		</select>
			</td>
        	<td class="tempsave">
	            <label for="tempsave">임시저장 여부</label>
	            <select id="tempsave" id="temp-save">
	                <option value="ALL">전체</option>
	                <option value="Y">Y</option>
	                <option value="N">N</option>
	            </select>
			</td>
		</tr>
		</table>
		</div>
		
		<div class="buttons">
		<button class="Auction-cancel">경매 취소</button>
		<button class="Blind-button">블라인드</button>
		</div>
		
		<!-- 버튼 모달창 -->
		<div id="auctionCancelModal" class="modal" style="display: none;">
			<p>선택하신 내용을 블라인드 처리하시겠습니까?</p>
			<button>확인</button>
			<button>취소</button>
		</div>
		<div id="BlindModal" class="modal">
			<p>해당 게시물 경매를 취소시키겠습니까?</p>
			<p style="font-size: 12px; color: red;">*입찰금은 마지막 입찰자에게 반환됩니다.</p>
			<button>확인</button>
			<button>취소</button>
		</div>
			
			
		<div class="search-list">
		<table>
			<thead>
			  <tr>
				<th class="one">선택</th>
				<th class="two">게시글 번호</th>
				<th class="three">
			            <select id="deal" id="deal-state">
			                <option value="ALL">전체</option>
			                <option value="Y">판매</option>
			                <option value="N">경매</option>
		            </select>
				</th>
				<th class="four">거래 상태</th>
				<th class="five">제목</th>
				<th class="six">가격(입찰가)</th>
				<th class="seven">판매자</th>
				<th class="eight">등록일</th>
				<th class="nine">블라인드</th>
			  </tr>
			</thead>
			<tbody id="list">
			  <tr>
				<td class="one"><input type="checkbox"/></td>
				<td class="two">게시글 번호</td>
				<td class="three">전체</td>
				<td class="four">거래 상태</td>
				<td class="five">제목</td>
				<td class="six">가격(입찰가)</td>
				<td class="seven">판매자</td>
				<td class="eight">등록일</td>
				<td class="nine">블라인드</td>
			  </tr>	
			</tbody>
		</table>
		
		</div>
	</div>
</section>
</main>
</body>

<script>
	
	// 입력 검색
	var textVal = $('text-search').val();
	$('.button-search').on('click'), function() {
		textVal = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedBlind,selectedTempsave);
	}
	
	// 카테고리 검색
	var selectedCategory = $('#category-search').val();
	$('#category-search').change(function() {
		selectedCategory = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedBlind,selectedTempsave);
	});
	
	// 거래 상태 검색
	var selectedState = $('#state-search').val();
	$('#state-search').change(function() {	
		selectedState = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedBlind,selectedTempsave);
	});
	
	// 등록일 검색
	var selectedDate = $('#date-search').val();
	$('#date-search').change(function() {
		selectedDate = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedBlind,selectedTempsave);
	});
	
	// 블라인드 검색
	var selectedBlind = $('#blind-search').val();
	$('#blind-search').change(function() {	
		selectedBlind = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedBlind,selectedTempsave);
	});
	
	// 임시저장 검색
	var selectedTempsave = $('#temp-search').val();
	$('#temp-search').change(function() {
		selectedTempsave = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedBlind,selectedTempsave);
	});
	
	// 게시글 리스트 출력
	function listCall(textVal,selectedCategory,selectedState,selectedBlind,selectedTempsave) {
		
		$.ajax({
			type: 'get',
			url: './list.ajax',
			data: {
				'textVal': textVal,
				'selectedCategory': selectedCategory,
				'selectedState': selectedState,
				'selectedBlind': selectedBlind,
				'selectedTempsave': selectedTempsave
			},
			dataType: 'JSON',
			success: function(data) {
				drawBoardlist(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	
	// drawBoardlist 함수 : 게시글 그리기
	
	
	
	
	
	
	

</script>
</html>