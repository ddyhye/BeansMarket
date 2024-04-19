<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="resources/css/common_top.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<div class="top-first">
		<div class="top-first-left">
			<p id="top-first-left-projectName">BEANS.</p>
		</div>
		<div class="top-first-center">
			<input type="text" name="search" id="top-first-center-search" /> <a
				href=""><img src="resources/img/search.png" alt="Search"
				id="top-first-center-icon" /></a>
		</div>
		<div class="top-first-right">
			<!-- <a href="" id="alarmIcon"><img src="../html/alarm.png" alt="알림"/></a> -->
			<img id="alarmIcon" src="resources/img/alarm.png" alt="알림" />
			<div class="alarm">
				<div class="alarm-delete">
					<button id="deleteBtn">X</button>
				</div>
				<div class="alarm-subject">
					<p>최근 알림</p>
				</div>
				<div class="alarm-content">
					<div class="alarm-content-list">
						<div class="alarm-content-list-left">
							<img src="resources/img/unRead.png" alt="안읽음" />
						</div>
						<div class="alarm-content-list-center">
							<span>안녕하세요반가워요잘지내요</span>
						</div>
						<div class="alarm-content-list-right">
							<div class="unRead"></div>
							<div class="unRead-div"></div>
							<span>2024-04-10</span> <span>22:20</span>
						</div>
						<div class="alarm-content-list-new"></div>
					</div>
				</div>
				<div class="alarm-bottom">
					<p>알림은 6개월 보관 후 삭제됩니다.</p>
				</div>
			</div>
			<a href=""><img src="resources/img/noteMessage.png" alt="쪽지" /></a> 
			<a href="main"><img src="resources/img/home.png" alt="홈페이지" /></a>
		</div>
	</div>

	<div class="top-second">
		<div class="top-second-left">
			<div class="top-second-left-border">
				<div class="top-second-left-head">
					<p class="top-second-left-down">▤</p>
					<p>&nbsp;&nbsp;카테고리</p>
					<!-- <p class="top-second-left-down">▼</p> -->
				</div>
				<div class="top-second-left-body">
					<a href="">디지털 기기</a> <a href="">가구/인테리어</a> <a href="">유아동</a> <a
						href="">여성 의류</a> <a href="">여성 잡화</a> <a href="">뷰티/미용</a> <a
						href="">남성 패션/잡화</a> <a href="">생활가전</a> <a href="">생활/주방</a> <a
						href="">가공식품</a> <a href="">스포츠/레저</a> <a href="">취미/게임/음반</a> <a
						href="">식물</a> <a href="">반려동물 용품</a>
				</div>

			</div>
		</div>

		<div class="top-second-center">
			<div>
				<a href="login.go" class="top-second-center-link">로그인</a>
			</div>
			<div>
				<a href="join.go" class="top-second-center-link">회원가입</a>
			</div>
			<div class="top-second-center-parent">
				<div class="top-second-center-head">
					<a href="" class="top-second-center-link"
						id="top-second-center-down">고객센터</a>
				</div>
				<div class="top-second-center-body">
					<a href="">공지사항</a> <a href="">자주 묻는 질문</a> <a href="">1:1 문의하기</a>
				</div>
			</div>
		</div>
		<div class="top-second-right">
			<div class="top-second-right-border">
				<div class="top-second-right-border-top">
					<p>Member</p>
					<p>Service</p>
				</div>
				<img src="resources/img/detailIcon.png"
					class="top-second-right-border-bottom-icon" />
			</div>
		</div>
	</div>
</body>

<script>
//카테고리 펼침/닫힘
$('.top-second-left-head').on('mouseenter', function() {
    $('.top-second-left-body').addClass('active');
});
$('.top-second-left-border').on('mouseleave', function() {
    $('.top-second-left-body').removeClass('active');
});

// 고객센터 펼침/닫힘
$('#top-second-center-down').on('mouseenter', function() {
    $('.top-second-center-body').addClass('active');
});
$('.top-second-center-parent').on('mouseleave', function() {
    $('.top-second-center-body').removeClass('active');
});

// 고객서비스 펼침/닫힘
$('.top-second-right-border-bottom-icon').on('click', function() {
    // 요소의 토글 상태를 저장
    var isToggled = $(this).data('toggled');
    // .top-second-right-border를 변수에 저장
    var borderDiv = $('.top-second-right-border');

    if (isToggled) {
        $(this).attr('src','resources/img/detailIcon.png');
        borderDiv.css('height', '150%');
        borderDiv.find('.memberService').remove();
    } else {
        $(this).attr('src','resources/img/reverseDetailIcon.png');
        borderDiv.css('height', '600%');
        borderDiv.append('<div class="memberService"><a href="">마이페이지</a></div>');
        borderDiv.append('<div class="memberService"><a href="">관심</a></div>');
        borderDiv.append('<div class="memberService"><a href="">물품팔기</a></div>');
        borderDiv.append('<div class="memberService"><a href="">판매리스트</a></div>');
        borderDiv.append('<div class="memberService"><a href="">최근 본 물품</a></div>');
    }
    
    // 요소의 토글 업데이트
    $(this).data('toggled', !isToggled);
});


// 알림
$('#alarmIcon').on('click', function() {
    $('.alarm').addClass('active');
});
$('#deleteBtn').on('click', function() {
    $('.alarm').removeClass('active');
});
</script>
</html>