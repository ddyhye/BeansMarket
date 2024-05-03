<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="../resources/css/report.css" type="text/css"/>
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
<p class="title">신고 검색</p>
	<div class="container">
		<table class="report-manager">
		<tr>
	        <td colspan="2" class="search">
	        <input type="text" name="search" id="text-search" placeholder="검색할 제목 또는 신고 번호를 입력해주세요"/>
	        <button class="button-search">검색</button>
	        </td>
        </tr>
        <tr>
        	<td class="incomplete">
				<input type="radio" name="incomplete" value="incomplete" class="radioOption"/>미처리만 보기
           	</td>
	        <td class="report-category">
	            <label for="report">신고 분류</label>
	            <select id="report-category">
	                <option value="all">전체</option>
	                <option value="욕설및비방">욕설 및 비방</option>
	                <option value="판매금지물품판매">판매금지 물품 판매</option>
	            </select>
	        </td>
	     </tr>
		</table>
		
		<button class="complete-button">처리완료</button>
		
		<div class="search-list">
		<table>
			<thead>
			<tr>
				<th class="one">선택</th>
				<th class="two">신고번호</th>
				<th class="three">
					<select id="deal" id="deal-state">
			                <option value="ALL">전체</option>
			                <option value="RB001">게시글</option>
			                <option value="RB002">쪽지</option>
			                <option value="RB003">쪽지 단일</option>
		            </select>
				</th>
				<th class="four">참조 번호</th>
				<th class="five">내용</th>
				<th class="six">신고 분류</th>
				<th class="seven">등록일</th>
				<th class="eight">신고자</th>
				<th class="nine">처리자</th>
				<th class="ten">처리여부</th>
			</tr>
			</thead>
			<tbody id="list">
			<tr>
				<td class="one"><input type="checkbox"/></td>
				<td class="two">신고 번호</td>
				<td class="three">전체</td>
				<td class="four">참조 번호</td>
				<td class="five">내용</td>
				<td class="six">신고 분류</td>
				<td class="seven">등록일</td>
				<td class="eight">신고자</td>
				<td class="nine">처리자</td>
				<td class="ten">처리여부</td>
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