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
	<jsp:include page="../common.jsp" />
</header>

<section>
	<div class="container">
		<p>게시글 검색</p>
		<div class="manager-search">
		<table>
		<tr>
	        <td colspan="2" class="search">검색</td>
	        <td colspan="2" class="category">
	            <label for="category">카테고리</label>
	            <select name="category">
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
	            <select id="state" name="state">
	                <option value="0">전체</option>
	                <option value="1">거래 가능</option>
	                <option value="2">예약 중</option>
	                <option value="3">거래 완료</option>
	            </select>
	        </td>
	        <td class="date">등록일</td>
	        <td class="blind">
	            <label for="blind">블라인드 여부</label>
	            <select id="blind" name="blind">
	                <option value="ALL">전체</option>
	                <option value="Y">Y</option>
	                <option value="N">N</option>
           		</select>
			</td>
        	<td class="tempsave">
	            <label for="tempsave">임시저장 여부</label>
	            <select id="tempsave" name="tempsave">
	                <option value="ALL">전체</option>
	                <option value="Y">Y</option>
	                <option value="N">N</option>
	            </select>
			</td>
		</tr>
		</table>
		</div>
		<div class="buttons">
		<button>경매 취소</button>
		<button>블라인드</button>
		</div>
		<div class="search-list">
		<table>
			<thead>
			  <tr>
				<th class="one">선택</th>
				<th class="two">게시글 번호</th>
				<th class="three">전체</th>
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
				<td class="one">선택</td>
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
</body>

<script>
</script>
</html>