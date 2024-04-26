<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.container {
    margin: 0 auto;
    width: 1300px; /* 수정 필요 1 */
    position: absolute;
    top: 50%;
    left: 50%; 
    transform: translate(-50%, -50%); /* 정확한 중앙 정렬을 위해 */
}

table {
    border: 1px solid black;
    border-collapse: collapse;
    max-width: 100%; /* 테이블이 부모 요소 너비를 넘지 않도록 설정 */
    table-layout: fixed; /* 테이블 및 셀의 너비를 고정 */
    width: 100%; /* 테이블 너비를 최대로 설정 */
}

th, td {
    border: 1px solid black;
    padding: 5px 10px;
    word-wrap: break-word; /* 셀 내용이 길어질 경우 자동으로 줄바꿈 */
    max-width: 300px; /* 셀의 최대 너비 설정, 필요에 따라 조절 */
}
.short {
    width: 50px; /* 첫 번째 열의 너비. 4글자에 맞게 조정하세요. */
}

.long {
    width: 250px; /* 두 번째 열의 너비. 내용에 맞게 넉넉하게 조정하세요. */
}


</style>
</head>

<body>
	<jsp:include page="../common.jsp" />
		<div class="container">
		<!--  여기 안에서 작업하기 -->
<table>
    <tr>
        <th class="short">글번호</th>
        <td class="long">${questionDetail.inquiry_idx}</td>
    </tr>
    <tr>
        <th class="short">제목</th>
        <td class="long">${questionDetail.inquiry_title}</td>
    </tr>
	<tr>
	    <th class="short">카테고리</th>
	    <td class="long">
	        <c:choose>
	            <c:when test="${questionDetail.category_idx == 'q001'}">계정</c:when>
	            <c:when test="${questionDetail.category_idx == 'q002'}">시스템</c:when>
	            <c:when test="${questionDetail.category_idx == 'q003'}">경매</c:when>
	            <c:when test="${questionDetail.category_idx == 'q004'}">신고</c:when>
	            <c:otherwise>기타</c:otherwise>
	        </c:choose>
	    </td>
	</tr>
    <tr>
        <th class="short">작성자</th>
        <td class="long">${questionDetail.enquirer}</td>
    </tr>
    <tr>
        <th class="short">내용</th>
        <td class="long">${questionDetail.inquiry_account}</td>
    </tr>
</table>    

<!-- 문의에 대한 답변 출력 -->
<h2>문의에 대한 답변</h2>
<c:if test="${not empty questionDetail.reply}">
    <table border="1">
        <tr>
            <th class="short">답변자</th>
            <th class="long">답변 내용</th>
        </tr>
        <tr>
            <td class="short">${questionDetail.id}</td>
            <td class="long">${questionDetail.reply}</td>
        </tr>
    </table>
</c:if>
<c:if test="${empty questionDetail.reply}">
    <p>답변이 아직 없습니다.</p>
</c:if>
		
		
		
		
		</div>

</body>

<script>
var categoryMap = {
    'q001': '계정',
    'q002': '시스템',
    'q003': '경매',
    'q004': '신고'
};

// 카테고리 코드를 이름으로 변환하는 함수
function getCategoryName(categoryCode) {
    return categoryMap[categoryCode] || '알 수 없음'; // 매핑되지 않은 코드 처리
}


</script>
</html>