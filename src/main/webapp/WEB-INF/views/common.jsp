<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- <link rel="stylesheet" href="/resources/css/common_top.css" type="text/css"/> -->
<link rel="stylesheet" href="<c:url value='/resources/css/common_top.css'/>" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	.fa-magnifying-glass, .fa-house, .fa-bell, .fa-paper-plane {
		margin: 0 10px;
		font-size: 30px;
		color: black;
	}
</style>
</head>

<body>
	<div class="top-first">
		<div class="top-first-left">
			<p id="top-first-left-projectName">BEANS.</p>
		</div>
		<div class="top-first-center">
			<input type="text" name="search" id="top-first-center-search" />
			<i class="fa-solid fa-magnifying-glass"></i>
			<!-- <img src="../resources/img/sorearch.png" alt="Search" id="top-first-center-icon" /> -->
		</div>
		<div class="top-first-right">
			<!-- <a href="" id="alarmIcon"><img src="../html/alarm.png" alt="알림"/></a> -->
			<i class="fa-solid fa-bell" id="alarmIcon"></i>
			<div class="unRead2"></div>
			<div class="alarm">
				<div class="alarm-delete">
					<button class="deleteBtn">X</button>
				</div>
				<div class="alarm-subject">
					<p>최근 알림</p>
				</div>
				<div class="alarm-content">
					<!-- <div class="alarm-content-list">
						<div class="alarm-content-list-left">
							<i class="fa-regular fa-envelope"></i>
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
					</div> -->
				</div>
				<div class="alarm-bottom">
					<p>알림은 6개월 보관 후 삭제됩니다.</p>
				</div>
			</div>
			<a href="<c:url value="/message/noteMessage.go"/>"><i class="fa-solid fa-paper-plane"></i></a> 
			<a href="/main"><i class="fa-solid fa-house"></i></a>
			
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
					<p class="top-second-left-body-category">디지털 기기</p>
					<p class="top-second-left-body-category">가구/인테리어</p>
					<p class="top-second-left-body-category">유아동</p>
					<p class="top-second-left-body-category">여성 패션</p>
					<p class="top-second-left-body-category">여성 잡화</p>
					<p class="top-second-left-body-category">뷰티/미용</p>
					<p class="top-second-left-body-category">남성 패션/잡화</p>
					<p class="top-second-left-body-category">생활가전</p>
					<p class="top-second-left-body-category">생활/주방</p>
					<p class="top-second-left-body-category">가공식품</p>
					<p class="top-second-left-body-category">스포츠/레저</p>
					<p class="top-second-left-body-category">취미/게임/음반</p>
					<p class="top-second-left-body-category">식물</p>
					<p class="top-second-left-body-category">반려동물 용품</p>
				</div>
			</div>
		</div>

		<div class="top-second-center">
			<div>
				<a href="<c:url value='/member/login.go'/>" class="top-second-center-link" id="top-second-center-link-log">로그인</a>
			</div>
			<div>
				<a href="<c:url value='/member/join.go'/>" class="top-second-center-link">회원가입</a>
			</div>
			<div class="top-second-center-parent">
				<div class="top-second-center-head">
					<a href="" class="top-second-center-link"
						id="top-second-center-down">고객센터</a>
				</div>
				<div class="top-second-center-body">
					<a href="/main/notify.go">공지사항</a> <a href="">자주 묻는 질문</a> <a href="">1:1 문의하기</a>
				</div>
			</div>
		</div>
		<div class="top-second-right">
			<div class="top-second-right-border">
				<div class="top-second-right-border-top">
					<p>Member</p>
					<p>Service</p>
				</div>
				<!-- <i class="fa-solid fa-square-caret-down"></i> -->
				<img src="<c:url value='/resources/img/detailIcon.png'/>"
					class="top-second-right-border-bottom-icon" /> 
			</div>
		</div>
	</div>
	<div class="recentLook">
		<div class="recentLook-delete">
			<button class="deleteBtn">X</button>
		</div>
		<div class="recentLook-subject">
			<i class="fa-solid fa-bag-shopping"></i>
			<p>&nbsp;최근 본 물품&nbsp;</p>
			<i class="fa-solid fa-bag-shopping"></i>
		</div>
		<div class="recentLook-content">
			<div class="recentLook-content2">
				<!-- AJAX -->
			</div>
		</div>
	</div>
</body>

<script>
	// 로그인했으면 로그아웃으로 변경
	// 서버 사이드에서 저장한 로그인 세션 가져오기
	// 아래는 토글로 되어있음... 페이지를 새로고침할때마다 달라지기 때문에, 서버사이드에서 가져와야 함. 나중에
	/*
	$('#top-second-center-link-log').on('click', function() {
		var isToggled = $(this).data('toggle');
		
		if (!isToggled) {
			// 로그인 상태가 false이면 로그인 링크
			$('#top-second-center-link-log').attr('href', 'login.go').text('로그인');
		} else {
			// 로그인 상태가 ftrue이면 로그아웃 링크
			$('#top-second-center-link-log').attr('href', 'logout.go').text('로그아웃');
		}
		
		#(this).data('toggle') = !isToggled;
	}); */
	loggedIn();
	
	function loggedIn() {
		$.ajax({
			type: 'get',
			url: '<c:url value="/loggedIn.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data) {
				// 로그인 중이라면, 로그아웃 기능이 있어야 함.
				if (data.logged === 'on') {
					$('#top-second-center-link-log').attr('href', '#').attr('onclick', 'logout(); return false;').text('로그아웃');
				} else {
					$('#top-second-center-link-log').attr('href', '<c:url value="/member/login.go"/>').removeAttr('onclick').text('로그인');
				}
			}, error: function(data){}
		});
	}
	
	function logout(){
		$.ajax({
			type: 'get',
			url: '<c:url value="/logout.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function() {
				$('#top-second-center-link-log').attr('href', '<c:url value="/member/login.go"/>').removeAttr('onclick').text('로그인');
				window.location.href = '<c:url value="/"/>';
			}, error: function(data){}
		});
	}
	
	var msg = '${msg}';
	if(msg != ''){
	    alert(msg);
	}
	
	newAlarm();

	// 게시글 검색
	$('.fa-magnifying-glass').on('click', function() {
		var textVal = $('#top-first-center-search').val();

		// 검색어 세션에 저장
		sessionStorage.setItem('recentSearch', textVal);
		// 리스트 출력을 위해 메인 페이지로 이동
		window.location.href = '<c:url value="/"/>';
	});
	// 카테고리 검색
	$('.top-second-left-body-category').on('click', function() {
		var textVal = $(this).text();

		// 검색어 세션에 저장
		sessionStorage.setItem('categoryName', textVal);
		// 리스트 출력을 위해 메인 페이지로 이동
		window.location.href = '<c:url value="/"/>';
	});

	
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
	$('.top-second-right-border-bottom-icon').on('click',function() {
		// 요소의 토글 상태를 저장
		var isToggled = $(this).data('toggled');
		// .top-second-right-border를 변수에 저장
		var borderDiv = $('.top-second-right-border');

		if (isToggled) {
			$(this).attr('src', '<c:url value="/resources/img/detailIcon.png"/>');
			borderDiv.css('height', '90px');
			borderDiv.find('.memberService').remove();
		} else {
			$(this).attr('src','<c:url value="/resources/img/reverseDetailIcon.png"/>');
			borderDiv.css('height', '520px');
			borderDiv.append('<div class="memberService"><i class="fa-solid fa-user"></i><p>마이페이지</p></div>');
			borderDiv.append('<div class="memberService"><i class="fa-solid fa-heart"></i><p>관심</p></div>');
			borderDiv.append('<div class="memberService"><i class="fa-solid fa-box-archive"></i><p>물품팔기</p></div>');
			borderDiv.append('<div class="memberService"><i class="fa-solid fa-rectangle-list"></i><p>판매리스트</p></div>');
			borderDiv.append('<div class="memberService"><i class="fa-solid fa-clock-rotate-left"></i><p>최근 본 물품</p></div>');
		}

		// 요소의 토글 업데이트
		$(this).data('toggled', !isToggled);
	});

	// 고객서비스 별 기능
	$('.top-second-right-border').on('click', '.memberService', function() {
		var serviceName = $(this).find('p').text();

		if (serviceName === '마이페이지') {
			window.location.href = '<c:url value="/member/myPage.go"/>';
		} else if (serviceName === '관심') {
			window.location.href = '<c:url value="/member/minePage.go"/>';
		} else if (serviceName === '물품팔기') {
			window.location.href = '<c:url value="/board/goodsWrite.go"/>';
		} else if (serviceName === '판매리스트') {
			window.location.href = '<c:url value="/member/mySellList.go"/>';
		} else if (serviceName === '최근 본 물품') {
			$('.recentLook').addClass('active');
			
			// 세션에 저장된 최근 본 게시글 idx 받아오기 (저장된 거 없으면 0)
			var currLookArr = sessionStorage.getItem('recentLookIdx');
			currLookArr = currLookArr ? JSON.parse(currLookArr) : [0, 0, 0, 0, 0, 0, 0, 0, 0];
			
			while(currLookArr.length < 9) {
				currLookArr.push(0);
			}
			
			$.ajax({
				type: 'get',
				url: '<c:url value="/recentBBS.ajax"/>',
				data: {
					'currLookArr': currLookArr
				},
				dataType: 'JSON',
				success: function(data) {
					$('.recentLook-content2').empty();
					
					var content = '';
					
					for (item of data.list) {
						content += '<div class="recentLook-content-goods'+(item.bbs_state === '거래완료' ? ' sold-out' : '')+'">';
						
						if (item.idx == 0) {
							content += '<i class="fa-solid fa-eye-slash"></i>';
							content += '</div>';
							
							continue;
						} else {
							content += '<div class="recentLook-content-goods-top">';
							var mark = item.bbs_state === '거래완료'? '<div class="goods-top-right-mark1"><span>Sold Out</span></div>': (item.option === '경매'? '<div class="goods-top-right-mark2"><span>경매</span></div>':'');
							content += mark;
							content += '</div>';
							content += '<div class="recentLook-content-goods-center">';
							content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
							content += '</div>';
							content += '<div class="recentLook-content-goods-bottom">';
							content += '<span>'+item.subject+'</span>';
							content += '</div>';
						}
						content += '</div>';
					}
					
					$('.recentLook-content2').append(content);
				}, error: function(error) {
				}
			});
			
			
		}
	});
	
	// 고객서비스 - 최근 본 물품 닫기
	$('.recentLook-delete').find('.deleteBtn').on('click', function() {
		$('.recentLook').removeClass('active');
	});
	

	
	// 알림 표시
	function newAlarm() {
		$.ajax({
			type: 'get',
			url: '<c:url value="/newAlarm.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data){
				if (data.newCnt > 0) {
					$('.unRead2').addClass('active');
				} else {
					$('.unRead2').removeClass('active');
				}
			}, error: function(data){}
		});
	}
	$('#alarmIcon').on('click', function() {
		$('.alarm').addClass('active');
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/alarm.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data) {
				drawAlarmList(data);
			},
			error : function(error) {
			}
		});

	});
	// 알림창
	$('.alarm-content').on('click', '.alarm-content-list', function() {
		var idx = $(this).find('.alarm-idx').text();
		console.log(idx);
		
		$.ajax({
			type: 'get',
			url: '<c:url value="/alarmRead.ajax"/>',
			data: {
				'idx': idx
			},
			dataType: 'JSON',
			success: function(data) {
				drawAlarmList(data);
				// data.link가 있다면 링크 이동,,
			},
			error : function(error) {
			}
		});
	});
	function drawAlarmList(data) {
		$('.alarm-content').empty();

		var content = '';

		if (!data.list || data.list.length === 0) {
			content += '<p> 로그인이 필요한 서비스 입니다... </p>';
		}
		for (item of data.list) {
			content += '<div class="alarm-content-list">';
			content += '<div class="alarm-idx" style="display: none;">'+item.idx+'</div>';
			content += '<div class="alarm-content-list-left">';
			var readImg = item.checked === 'Y'? '<c:url value="/resources/img/read.png"/>':'<c:url value="/resources/img/unRead.png"/>';
			content += '<img src="'+readImg+'" alt="읽음여부"/>';
			content += '</div>';
			content += '<div class="alarm-content-list-center">';
			content += '<span>'+item.content+'</span>';
			content += '</div>';
			content += '<div class="alarm-content-list-right">';
			content += item.checked === 'Y'? '<div class="unRead" style="display: none;"></div>':'<div class="unRead"></div>';
			content += '<div class="unRead-div"></div>';
			/* 알람테이블 날짜 */
			dateStr = DateToString(item.reg_date);
			content += '<span>'+dateStr+'</span>';
			/* content += '<span>22:20</span>'; */
			content += '</div>';
			content += '<div class="alarm-content-list-new">';
			content += '</div>';
			content += '</div>';
		}
		
		$('.alarm-content').append(content);
	}
	// timestamp 형식인 거 문자열로 변환하는 함수
	function DateToString(timesteamp){
		var date = new Date(timesteamp);
		var dateStr = date.toLocaleDateString("ko-KR");
		return dateStr;
	}
	$('.alarm-delete').find('.deleteBtn').on('click', function() {
		$('.alarm').removeClass('active');
		newAlarm();
	});
</script>
</html>