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
			<div class=leftArea>
				<div class="left-subject">
					<p>쪽지함</p>
				</div>
				<div class="room-select">
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
			</div>
			<div class="view-room" data-value="1">
				<!-- 아무것도 없을 때는 메시지 이모티콘 하나 띄우기 -->
				<p class="no-message">메시지를 선택해주세요 <i class="fa-solid fa-message"></i></p>			
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
			<div id="reportForm">
                <div class="form">
                    <div class="option">
                        <p>신고 분류</p>
                        <select id="report_option" name="category_idx">
                            <option value="r001">도배</option>
                            <option value="r002">욕설</option>
                            <option value="r003">성희롱</option>
                        </select>
                    </div>
                    <div class="content">
                        <p>신고 사유를 입력해주세요</p>
                        <textarea name="content"></textarea>
                    </div>
                    <input type="hidden" name="option_idx" value="RB002">
                    <div class="btn-controller">
                        <button class="ok" onclick="report()">확인</button>
                        <button type="button" class="reportCancel">취소</button>
                    </div>
                </div>
            </div><!--reportForm 종료-->
        	<div id="dealForm">
				<div class="top">
					<button class="escape"><i class="fa-solid fa-x"></i></button>
				</div>
				<!-- 경매일 경우 예약 취소 막히게 -> 문의로 해제 가능하다고 적어두자 -->
				<div class="form">
					<p>거래 창</p>
					<button class="reserve-toggle" onclick="reserve()">예약</button>
					<button class="approve">거래 승인</button>	
				</div>
				<p class="msg">*경매의 경우에는 예약 취소가 불가능합니다.</p>			
			</div><!--dealForm 종료-->
            <div class="menu"><!-- 신고 메뉴 -->
            	<button onclick="reportDo('message')">이 쪽지 신고하기</button>
            </div>
		</div> <!-- container 종료 -->
	</section>
</body>
<script>
	var chat_user = '';
	var chat_idx = 0;
	var message_idx = 0;
	var my_email = '${loginInfo.email}';

	loginCheck();
	
	$('#send-form').hide();
	
	var callPage = '${callPage}';
	if(callPage != ''){
		subjectCall(parseInt(callPage));
	}
	
	// 쪽지 단일 신고 메뉴 숨기게 하기
	$(document).on('click', function(event) {
		console.log($(event.target).closest('.menu').length);
	    if (!$(event.target).closest('.menu').length) {
	        $('.menu').css({'display': 'none'});
	    }
	});
	
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
				//console.log(data);
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
				$('#send-form').show();
				$('.no-message').hide();
				chat_idx = data.bbs_idx;
				drawSubject(data);
				if (chat_user === '') {
					chat_user = data.other_email;
					messageCall(chat_idx, '${loginInfo.email}',chat_user);
				}
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	
	function drawSubject(data) {
		$('#view-subject').empty();

		var content = '';
		
		content += '<div class="left">';
		content += 		'<button id="back" onclick="backDo()"><i class="fa-solid fa-rotate-left"></i></button>';
		content += 		'<div id="deal">';
		content += 			'<button id="deal-btn" onclick="dealForm()">'+data.roomSubject.bbs_state+'</button>';
		
		if(data.roomSubject.reserve_email === '${loginInfo.email}' || (data.roomSubject.email == '${loginInfo.email}' && data.roomSubject.reserve_email == chat_user)) {
			content +='<p id="reserve-icon"><i class="fa-solid fa-handshake-simple"></i></p>';
		}
		
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
		content +=				'<button class="report" onclick="reportDo(\'room\')">신고하기</button>';
		content += 			'<button class="delete"><i class="fa-solid fa-trash-can"></i></button>';
		content += 		'</div>';
		content += '</div>';

		$('#view-subject').append(content);
		$('#view-subject').css({
											'background-color':'white',
											'border-bottom': '1px solid gray'
		});
		
		$('#deal-btn').prop('disabled', true);
		$('.reserve-toggle').prop('disabled', true);	
		$('.approve').prop('disabled', true);
		
		// 예약자가 없으면 판매자만 거래버튼 활성화
		if(data.roomSubject.reserve_email == null){
			if(data.roomSubject.email === my_email){
				$('#deal-btn').prop('disabled', false);
				$('.reserve-toggle').prop('disabled', false);	
			}
		} else{ // 예약자가 있으면
			if(data.roomSubject.reserve_email === my_email || data.roomSubject.email === my_email){
				$('#deal-btn').prop('disabled', false);
				$('.reserve-toggle').prop('disabled', false);	
				$('.approve').prop('disabled', false);
			}
		}
		
		if (data.roomSubject.bbs_state == '예약중') {
			$('.reserve-toggle').text('예약 취소');
		} else if (data.roomSubject.bbs_state == '거래완료') {
			$('#deal-btn').prop('disabled', true);
		} else if (data.roomSubject.bbs_state == '거래가능'){
			$('.reserve-toggle').text('예약');
		}
	
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
		chat_idx = idx;
		chat_user = other_email;
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
			content += '<p class="no-message">아무것도 없따... <i class="fa-solid fa-message"></i></p>';	
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

		$('.receive-msg-info .size-cut').on('contextmenu', function(event) {
			event.preventDefault();
			
			var menu = $('.menu');
			var posX = event.pageX;
		    var posY = event.pageY;
		    
		    menu.css({
		        top: posY + 'px',
		        left: posX + 'px',
		        display: 'block'
		    });
			
			handleClick($(this).parent());
		});

	}

	function handleClick(element) {
        var data = $(element).data("value");
		message_idx = data; // 특정 쪽지를 신고하게 끔 바꾸기 위해서
    }

	function sendMessage(idx, other_email) {
		var content = $('#sendText').val();
		if(content == '') return alert("빈 내용은 전송할 수 없습니다.");
		if(idx === 0 || other_email === '') return alert("시스템 에러");
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
	    setTimeout(function() {
			messageCall(chat_idx, '${loginInfo.email}', chat_user);
			roomListCall('${loginInfo.email}');
		}, 100);
	    $('#sendText').val('');
	});

	// 채팅방 나가기
	function backDo(){
		$('#view-subject').empty();
		$('#view-content').empty();
		$('#view-subject').css({
											'background-color':'',
											'border-bottom': 'none'
										});
		$('.no-message').show();
		$('#sendText').val('');
		$('#send-form').hide();
		var chat_user = '';
		var chat_idx = 0;
	}

	// 신고 버튼 클릭 시 - 쪽지 - 게시글 번호로 신고
	function reportDo(option) {
		if(loginCheck()){
			$('textarea[name="content"]').val('');
			$('#reportForm').hide();
			$('.menu').css({'display': 'none'});
            $('#reportForm').show();
            
			if (option == 'message') {
				$('input[name="option_idx"]').val('RB003');
			} else {
				$('input[name="option_idx"]').val('RB002');
			}
        }
	}
	$('.reportCancel').click(function() {
		$('#reportForm').hide();
	});
	
    // 신고 ajax - 쪽지
    function report(){
		var category_idx = $('select[name="category_idx"]').val();
        var content = $('textarea[name="content"]').val();
        var option_idx = $('input[name="option_idx"]').val();
        
		var idx = chat_idx;
		if (option_idx === 'RB003') {
			idx = message_idx;
		}
		
        console.log(category_idx, content, option_idx, chat_user, idx);
        // 쪽지로 신고를 한거면 chat_idx에 들어갈거가 message_idx가 들어가도록
		$.ajax({
			type:'POST',
			url:'../report/report.do',
			data:{
                'category_idx':category_idx,
                'content':content,
                'option_idx':option_idx,
                'perpet_email':chat_user,
                'idx':idx
            },
            dataType:'JSON',
			success:function(data){
				alert(data.msg);
				$('#reportForm').toggle();
				$('textarea[name="content"]').val('');
			}, 
			error:function(error){
				console.log(error);
			} 
		});
    }
	
    function dealForm() {
		$('#dealForm').show();
	}
    
    $('.escape').click(function() {
        $(this).closest('.top').parent().hide();
    });

    /*
	function reserve() {
		var reserve = $('.reserve-toggle').text();
		$.ajax({
			type:'POST',
			url:'../report/report.do',
			data:{
                'reserve':reserve,
                'email':chat_user,
                'idx':chat_idx
            },
            dataType:'JSON',
			success:function(data){
				alert(data.msg);
				$('#reportForm').toggle();
				$('textarea[name="content"]').val('');
			}, 
			error:function(error){
				console.log(error);
			} 
		});
	}
    */
</script>
</html>