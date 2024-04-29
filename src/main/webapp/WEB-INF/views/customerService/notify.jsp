
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css"
	type="text/css" />
<link rel="stylesheet" href="../resources/css/detail.css"
	type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
	.pagination {
		display: flex;
		justify-content: center;
		align-items: center;
		list-style: none;
		padding: 0;
		margin: 20px 0;
	}
	
	.pagination li {
		margin: 0 5px;
	}
	
	.pagination li a {
		text-decoration: none;
		color: #333;
		padding: 5px 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		transition: background-color 0.3s ease;
	}
	
	.pagination li a:hover {
		background-color: #f0f0f0;
	}
	
	section {
		height: 100%;
		margin-top: 125px;
		padding: 20px;
		border-radius: 10px;
	}
	
	h3 {
		margin-top: 30px;
		margin-left: 100px;
		font-size: 28px;
		color: #333;
	}
	
	hr {
		width: 90%;
		margin: 0 auto;
		border-width: 2px;
		border-color: #ddd;
	}
	
	.notify-list {
		margin: 0 auto;
		width: 90%;
		display: flex;
		align-items: center;
		justify-content: space-between;
		border-bottom: 1px solid #ddd;
		padding: 20px;
	}
	
	.notify-list:last-child {
		border-bottom: none;
	}
	
	.notify-list-title {
		font-size: 18px;
		font-weight: bold;
		color: #333;
		margin-bottom: 10px;
	}
	
	.notify-list-name {
		font-size: 14px;
		color: #777;
		font-weight: bold;
		margin-bottom: 10px;
		width: 20%; /* 너비 조정 */
	}
	
	.notify-list-mark1 {
		padding: 4px 8px;
		border-radius: 4px;
		font-size: 14px;
		display: inline-block;
		color: #fff;
	}
	
	.notify-list-mark1 span {
		font-weight: bold;
	}
	
	.notify-list-date {
		font-size: 14px;
		color: #777;
		display: flex;
		align-items: center;
		width: 30%; /* 너비 조정 */
		margin-right: 20px; /* 날짜와 조회수 간격 조정 */
	}
	
	.notify-list-date span {
		margin-right: 10px;
	}
	
	.notify-list-nhit {
		width: 10%; /* 너비 조정 */
		margin-left: 60px; /* 날짜와 조회수 간격 조정 */
	}
	
	p {
		font-size: 18px;
		color: #777;
		text-align: center;
		margin-top: 20px;
	}
	
	/* 추가된 부분: option의 값에 따라 색상 변경 */
	.notify-list-mark1.normal {
		background-color: orange;
	}
	
	.notify-list-mark1.important {
		background-color: red;
	}
	
	/* 추가된 부분: 검색 입력 필드 스타일 */
	.search {
		text-align: center;
		margin-top: 20px;
	}
	
	#searchInput {
		width: 30%; /* 너비를 조정하여 화면에 잘 맞도록 변경 */
		padding: 10px;
		border-radius: 5px;
		border: 1px solid #ccc;
		font-size: 16px;
	}
	
	#searchButton {
		padding: 10px 20px;
		border-radius: 5px;
		background-color: gray;
		color: #fff;
		border: none;
		cursor: pointer;
		font-size: 16px;
		margin-left: 10px;
	}
	
	#searchButton:hover {
		background-color: #0056b3;
	}
</style>
</head>
<body>
	<jsp:include page="../common.jsp" />
	<section>
		<h3>공지사항</h3>
		<hr>
		<!-- 검색 입력 필드 -->
		<div class="notify"></div>
		<hr>
		<div class="pagination-container">
			<nav aria-label="Page navigation" style="text-align: center">
				<ul class="pagination" id="pagination"></ul>
			</nav>
		</div>
		<div class="search">
			<input type="text" id="searchInput" placeholder="제목을 입력하세요">
			<button id="searchButton">검색</button>
		</div>
	</section>
</body>
<script src="resources/js/jquery.twbsPagination.js"
	type="text/javascript"></script>
<script>
	var showPage = 1; // 현재 페이지를 저장할 변수
	
	$(document).ready(function() {
	    // 검색 버튼 클릭 이벤트 핸들러
	// 검색 버튼 클릭 이벤트 핸들러
	$('#searchButton').on('click', function() {
	    var searchText = $('#searchInput').val(); // 검색 입력란의 값 가져오기
	    // 검색어가 비어있는지 확인
	    if (searchText.trim() !== '') {
	        // 검색어가 비어있지 않으면 검색 실행
	        searchByTitle(searchText, showPage); // 현재 페이지 번호를 함께 전달
	    } else {
	        // 검색어가 비어있으면 현재 페이지를 기준으로 공지사항을 다시 불러옴
	        listCall(showPage);
	    }
	});
	    
	    // 초기 페이지 로드시 공지사항 목록 출력
	    listCall(1);
	
	    // 페이지당 게시물 수 변경 시
	    $('#pagePerNum').on('change', function() {
	        $('#pagination').twbsPagination('destroy');
	        listCall(showPage);
	    });
	});
	
	// 제목으로 검색하는 함수
	function searchByTitle(title, page) { // 페이지 번호를 인수로 추가
	    $.ajax({
	        type: 'GET',
	        url: 'searchByTitle.ajax', // 서버의 검색 처리 기능을 호출하는 URL
	        data: {
	            'textval': title, // 검색할 제목을 전달
	            'page': page // 페이지 번호도 함께 전달
	        },
	        dataType: 'JSON',
	        success: function(data) {
	            drawnotifyList(data); // 검색 결과를 화면에 출력
	        },
	        error: function(error) {
	            console.log('검색 실패:', error);
	        }
	    });
	}
	
	// 공지사항 목록을 가져와 화면에 출력하는 함수
	function listCall(page) {
	    $.ajax({
	        type: 'GET',
	        url: 'notifyList.ajax',
	        data: {
	            'page': page,
	            'cnt': $('#pagePerNum').val()
	        },
	        dataType: 'JSON',
	        success: function(data) {
	            drawnotifyList(data); // 공지사항 목록을 화면에 출력
	            var startPage = data.currPage > data.totalPages ? data.totalPages : data.currPage;
	            $('#pagination').twbsPagination({
	                startPage: startPage, // 시작페이지
	                totalPages: data.totalPages, // 전체 페이지 수
	                visiblePages: 5, // 보여줄 페이지 수
	                onPageClick: function(evt, pg) {
	                    showPage = pg; // 페이지를 클릭할 때마다 현재 페이지 업데이트
	                    listCall(pg); // 선택한 페이지의 공지사항을 불러옴
	                }
	            });
	        },
	        error: function(error) {
	            console.log('공지사항 리스트 출력 실패:', error);
	        }
	    });
	}
	
	// 공지사항 목록을 화면에 출력하는 함수
	function drawnotifyList(data) {
	    $('.notify').empty();
	    var content = '';
	    if (!data.list || data.list.length === 0) {
	        content += '<p>현재 공지사항이 없습니다.</p>';
	    } else {
	        for (let item of data.list) {
	            content += '<div class="notify-list">';
	            content += '<div class="notify-list-idx" style="display:none;">' + item.notice_idx + '</div>';
	            content += (item.notice_option ? '<div class="notify-list-mark1 ' + (item.notice_option === "일반" ? 'normal' : 'important') + '"><span>' + item.notice_option + '</span></div>' : '');
	            content += '<div class="notify-list-title">' + (item.notice_option ? '' : '일반') + item.notice_title + '</div>';
	            content += '<div class="notify-list-name">' + item.admin_name + '</div>';
	            content += '<div class="notify-list-date">';
	            var date = new Date(item.notice_date);
	            var dateStr = date.toLocaleDateString("ko-KR", { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\./g, '').replace(/\s/g, '. ') + '.';
	            content += '<span>' + dateStr + '</span>';
	            content += '<div class="notify-list-nhit">' + item.nHit + '</div>';
	            content += '</div>';
	            content += '</div>';
	        }
	    }
	    $('.notify').append(content);
	}
	
	// 공지사항 클릭시 디테일 페이지로 이동
	$('.notify').on('click', '.notify-list', function() {
	    var idx = $(this).find('.notify-list-idx').text().trim();
	    window.location.href = '<c:url value="/customerService/notifyDetail.go?notice_idx=' + idx + '"/>';
	});
	</script>
</html>