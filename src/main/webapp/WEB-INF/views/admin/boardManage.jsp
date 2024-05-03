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
	        <td colspan="3" class="search">
	        <input type="text" name="search" id="text-search" placeholder="검색할 제목 또는 게시글 번호를 입력해주세요"/>
	        <button class="button-search">검색</button>
	        </td>
        </tr>
		<tr>
			<td class="category">
	            <label for="category">카테고리</label>
	            <select name="category" id="category-search">
	                <option value="all">전체</option>
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
	        <td class="state">
	            <label for="state">거래 상태</label>
	            <select id="state-search">
	                <option value="all">전체</option>
	                <option value="거래가능">거래 가능</option>
	                <option value="예약중">예약 중</option>
	                <option value="거래완료">거래 완료</option>
	            </select>
	        </td>
	        <td class="blind-tempsave">
				    <input type="radio" name="blind-tempsave" value="blind" class="radioOption"/>블라인드
      				<input type="radio" name="blind-tempsave" value="tempsave" class="radioOption"/>임시저장
			</td>
		</tr>
		</table>
		</div>
			
		<div class="search-list">
		<table>
			<thead>
			  <tr>
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
	var textVal = $('#text-search').val();
	$('.button-search').on('click'), function() {
		textVal = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedRadio);
	}
	
	// 카테고리 검색
	var selectedCategory = $('#category-search').val();
	$('#category-search').change(function() {
		selectedCategory = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedRadio);
	});
	
	// 거래 상태 검색
	var selectedState = $('#state-search').val();
	$('#state-search').change(function() {	
		selectedState = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedRadio);
	});
	
	// 블라인드, 임시저장 선택
	var selectedRadio = $('input[name="blind-tempsave"]:checked').val();
	$('input[name="blind-tempsave"]').change(function() {
		selectedRadio = $(this).val();
		
		listCall(textVal,selectedCategory,selectedState,selectedRadio);
	});

	listCall(textVal,selectedCategory,selectedState,selectedRadio);
	
	// 게시글 리스트 출력
	function listCall(textVal,selectedCategory,selectedState,selectedRadio) {
		$.ajax({
			type: 'get',
			url: '<c:url value="/admin/bbsList.ajax"/>',
			data: {
				'textVal': textVal,
				'selectedCategory': selectedCategory,
				'selectedState': selectedState,
				'selectedRadio': selectedRadio,
			},
			dataType: 'JSON',
			success: function(data) {
				drawBbsList(data);
			}, error: function(error) {}
		});
	}
	
	// drawBbsList 함수 : 게시글 그리기
	function drawBbsList(data) {
		$('#list').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<tr><td colspan = 8>검색한 회원이 없습니다.</td></tr>';
		}
		for (item of data.list) {
			content += '<tr>';
			content += '<td class="two">'+item.idx+'</td>';
			content += '<td class="three">'+item.option+'</td>';
			content += '<td class="four">'+item.bbs_state+'</td>';
			content += '<td class="five">'+item.subject+'</td>';
			content += '<td class="six">'+item.price+'</td>';
			content += '<td class="seven">'+item.email+'</td>';
			content += '<td class="eight">'+item.reg_date+'</td>';
			content += '<td class="nine">'+item.blind+'</td>';
			content += '</tr>';
		}
		
		$('#list').append(content);
	}
	
	$('#list').on('click', '.two', function(){
		var boardIdx = $(this).text();
		console.log(boardIdx);
		
		window.location.href = '<c:url value="/board/detail.go?idx='+boardIdx+'"/>';
	});
	
	
	$('#list').on('click', '.five', function(){
		var boardIdx = $(this).closest('tr').find('.two').text();
		console.log(boardIdx);
		
		window.location.href = '<c:url value="/admin/boardManageDetail.go?idx='+boardIdx+'"/>';
	});
	


</script>
</html>