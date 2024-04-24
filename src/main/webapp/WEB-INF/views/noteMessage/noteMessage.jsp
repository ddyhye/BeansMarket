<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="../resources/css/message.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>
<body>
	<header>
		<jsp:include page="../common.jsp"/>
	</header>
	<section>
		<div class="container">
			<div class="room-select">
				<div class="left-subject">
					<p>쪽지함</p>
				</div>
				<div id="room-list">
					<!--
					<div class="room">
						<img class="circle-img" src="../resources/img/unRead.png" alt="n번 게시물 대표 사진">
						<div class="room-info">
							<p class="room-subject">제목</p>
							<p class="room-last-content">마지막 내용</p>
						</div>
						<p class="last-conversation">2024-04-10 10:03</p>
					</div>
					-->
				</div>
			</div><!-- 쪽지방 선택 (room-select) 끝 -->
			<div class="view-room" data-value="1">
				<!-- 아무것도 없을 때는 메시지 이모티콘 하나 띄우기 -->
				<div id="view-subject">
				<!-- 
					<div class="left">
						<button id="back"><i class="fa-solid fa-rotate-left"></i></button>
						<div id="deal">
							<button id="deal-btn">거래가능</button>
							<p id="reserve-icon"><i class="fa-solid fa-handshake-simple"></i></p>
						</div>
					</div>
					<div class="center">
						<img class="circle-img" src="../resources/img/unRead.png" alt="n번 게시물 대표 사진">
						<div class="room-info">
							<p class="room-subject">자전거 중고 거래aaaaaaaaaaaa</p>
							<p class="price">153,000원</p>
						</div>
					</div>
					<div class="right">
						<div class="btn-controller">
							<button class="report">신고하기</button>
							<button class="delete"><i class="fa-solid fa-trash-can"></i></button>
						</div>
					</div>
				-->
				</div>
				<div id="view-content">
					<!--
					<div class="to-day">
						<p>0000.00.00</p>
					</div>
					// contextmenu : 오른쪽 마우스 버튼을 클릭 했을 때
					<div class="receive-msg-info" data-value="42">
						<div class="size-cut">
							<img class="circle-img" src="../resources/img/unHeart.png" alt="상대방 프로필 사진">
							<div class="message-info">
								<p class="name">닉네임</p>
								<p class="content">마! 내가 이거 사면 안돼나!!</p>
									<img class="photo" src="../resources/img/unHeart.png" alt="이미지 사진">
							</div>
							<div class="sendTime">
								<p>12:30</p>
							</div>
						</div>
					</div>
					<div class="send-msg-info">
						<div class="size-cut">
							<div class="sendTime">
								<p>12:30</p>
							</div>
							<div class="message-info">
								<p class="content">마! 내가 이거 사면 안돼나!!</p>
							</div>
						</div>
					</div>
				-->
				</div>
				<div id="send-form">
					<button id="photoBtn"><i class="fa-solid fa-paperclip"></i></button>
					<input type="text" id="sendText"/>
					<button id="sendBtn"><i class="fa-solid fa-paper-plane"></i></button>
				</div>
			</div><!-- view-room 종료 -->
		</div> <!-- container 종료 -->
	</section>
</body>
<script>
	var chat_user;
	var chat_idx;
	// 로그인을 안했으면 alert 창 출력 후 로그인으로 이동 - 체크는 서버 측에서도 한번더 하면 좋을거 같음
	function loginCheck() {
	    var login = true;
	    if('${loginInfo}' == ''){
	        alert('로그인이 필요한 서비스 입니다.');
	        location.href='<c:url value="/member/login.go"/>';
	        login = false;
	    }
	    return login;
	}
	loginCheck();
	roomListCall('${loginInfo.email}');

	// 방 리스트 불러오기
	function roomListCall(email) {
		$.ajax({
			type: 'POST',
			url: './roomListCall.ajax',
			data: {
				'email': email
			},
			dataType: 'JSON',
			success: function(data) {
				console.log("성공");
				console.log(data);
				drawRoomList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}

	// 방 제목 불러오기
	function subjectCall(idx) {
		$.ajax({
			type: 'POST',
			url: './subjectCall.ajax',
			data: {
				'idx': idx
			},
			dataType: 'JSON',
			success: function(data) {
				console.log("성공");
				console.log(data);
				drawSubject(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	
	function drawSubject(data) {
		$('#view-subject').empty();

		var content = '';
		
		content += '<div class="left">';
		content += 		'<button id="back"><i class="fa-solid fa-rotate-left"></i></button>';
		content += 		'<div id="deal">';
		content += 			'<button id="deal-btn">'+data.roomSubject.bbs_state+'</button>';
		/*
		if(data.roomSubject.reserve_email === '{loginInfo.email}' || (data.roomSubject.email === '{loginInfo.email}' && data.roomSubject.reserve_email != null)) { 대화상대가 reserve_email일 경우
			content +='<p id="reserve-icon"><i class="fa-solid fa-handshake-simple"></i></p>';
		}
		*/
		content += 		'</div>';
		content += '</div>';
		content += '<div class="center">';
		content +=		'<img class="circle-img" src="/photo/'+data.roomPhoto+'" alt="'+data.roomSubject.idx+'번 게시물 대표 사진">';
		content += 		'<div class="room-info">';
		content += 			'<p class="room-subject">'+data.roomSubject.subject+'</p>';
		content += 			'<p class="price">'+data.roomSubject.price+'원</p>';
		content += 		'</div>';
		content += '</div>';
		content += '<div class="right">';
		content += 		'<div class="btn-controller">';
		content += 			'<button class="report">신고하기</button>';
		content += 			'<button class="delete"><i class="fa-solid fa-trash-can"></i></button>';
		content += 		'</div>';
		content += '</div>';

		$('#view-subject').append(content);

	}
	
	
	
	function drawRoomList(data) {
		$('#room-list').empty();
		var content = '';
		if (!data.roomList || data.roomList.length === 0) {
			content += '<p> 대화방이 없습니다. </p>';
		}
		
		for (item of data.roomList) {
			content +='<div class="room" onclick="viewRoomContent(\'' + item.idx + '\', \'' + item.other_email + '\')">'; 
			content +=		'<img class="circle-img" src="/photo/'+item.new_picname+'" alt="'+item.idx+'번 게시물 대표 사진">';
			content +=		'<div class="room-info">';
			content +=			'<p class="room-subject">'+item.other_email+'</p>';
			content +=			'<p class="room-last-content">'+item.content+'</p>';
			content +=		'</div>';
			content +=		'<p class="last-conversation">'+DateToString(item.reg_date)+'</p>';
			content +=	'</div>';	
		}
		
		$('#room-list').append(content);
	}
	
	function viewRoomContent(idx, other_email){
		subjectCall(idx);
		messageCall(idx, '${loginInfo.email}', other_email);
		
		chat_user = other_email;
		chat_idx = idx;
	}


	// 특정 방 message 출력
	function messageCall(idx, email, otherEmail) {
		$.ajax({
			type: 'POST',
			url: './messageCall.ajax',
			data: {
				'idx': idx,
				'email': email,
				'otherEmail': otherEmail
			},
			dataType: 'JSON',
			success: function(data) {
				console.log("성공");
				drawMessage(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}

	// timestamp 형식인 거 문자열로 변환하는 함수
	function DateToString(timesteamp){
		var date = new Date(timesteamp);
		var dateStr = date.toLocaleDateString("ko-KR");
		return dateStr;
	}

	var checkDate;
	// drawMessage : 주고 받은 쪽지 불러오기
	function drawMessage(data) {
		var email = '${loginInfo.email}';
		var checkHours = 0;
		var checkMinutes = 0;
		
		$('#view-content').empty();

		var content = '';

		if (!data.messageList || data.messageList.length === 0) {
			content += '<p> 쪽지를 선택해주세요 </p>';
		}
		for (item of data.messageList) {
			var date = new Date(item.reg_date);
			var dateStr = date.toLocaleDateString("ko-KR");
			var hours = date.getHours();
			var minutes = date.getMinutes();

			if(dateStr != checkDate || content == ''){
				content += '<div class="to-day">';
				content += 		'<p>'+dateStr+'</p>';
				content += '</div>';
				checkDate = dateStr;
			}
			
			if(email === item.receive_email) {
				content +=	'<div class="receive-msg-info" data-value="'+item.message_idx+'">';
				content +=		'<div class="size-cut">';
				if(checkHours != hours || checkMinutes != minutes){
					content +=			'<img class="circle-img" src="../resources/img/unHeart.png" alt="상대방 프로필 사진">';
					content +=			'<div class="message-info">';
					content +=				'<p class="name">'+item.sender_email+'</p>';
					content +=				'<p class="content">'+item.content+'</p>';
					content +=			'</div>';
					checkHours = hours;
					checkMinutes = minutes;
				} else {
					content +=			'<div class="term"><p></p></div>';
					content +=			'<div class="message-info">';
					content +=				'<p class="content">'+item.content+'</p>';
					content +=			'</div>';
				}
				content +=			'<div class="sendTime">';
				content +=				'<p>'+hours + ':' + (minutes < 10 ? '0' : '') + minutes+'</p>';
				content +=			'</div>';
				content +=		'</div>';
				content +=	'</div>';
			} else if (email === item.sender_email) {
				content +=	'<div class="send-msg-info">';
				content +=		'<div class="size-cut">';
				content +=			'<div class="sendTime">';
				content +=				'<p>'+hours + ':' + (minutes < 10 ? '0' : '') + minutes+'</p>';
				content +=			'</div>';
				content +=			'<div class="message-info">';
				content +=				'<p class="content">'+item.content+'</p>';
				content +=			'</div>';
				content +=		'</div>';
				content +=	'</div>';
			}
			
		}
		
		$('#view-content').append(content);
	
		// 스크롤 가장 마지막으로 내리기
		$('#view-content').scrollTop($('#view-content')[0].scrollHeight);

	}

	function sendMessage(idx, other_email) {
		var content = $('#sendText').val();
		if(content == '') return alert("빈 내용은 전송할 수 없습니다.");
		$.ajax({
			type: 'POST',
			url: './messageSend.ajax',
			data: {
				'idx': idx,
				'email': '${loginInfo.email}',
				'otherEmail' : other_email,
				'content': content
			},
			dataType: 'JSON',
			success: function(data) {
				console.log(data.result);
			}, error: function(error) {
				console.log(error);
			}
		});
	}

	$('#sendBtn').click(function() {
	    sendMessage(chat_idx, chat_user);
	    messageCall(chat_idx, '${loginInfo.email}', chat_user);
	    $('#sendText').val('');
	});
</script>
</html>