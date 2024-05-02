<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/messageManage.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<header>
		<jsp:include page="./common.jsp"/>
	</header>
	<main>
		<jsp:include page="./nav.jsp"/>
		<section>
			<div id="room-search">
				<p>쪽지 방 검색</p>
				<div class="search-box">
					<input type="text" name="search-val" id="subject-search" placeholder="게시글 번호를 입력해주세요" />
					<button class="room-search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
					<input type="checkbox" id="reportFilter" /> <p>신고 받은 방만 보기</p>
				</div>
	
				<table class="room-result-box">
					<thead>
						<tr>
							<th>게시글 번호</th>
							<th>제목</th>
							<th>판매자</th>
							<th>구매자</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody id="roomList"></tbody>
				</table>
			</div>
			
			<div class="message-search">
				<p>쪽지 번호 검색</p>
				<div class="search-box">
					<input type="text" id="msg-search" placeholder="쪽지 번호를 입력해주세요" />
					<button class="message-search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
					<input type="checkbox" id="reportFilter" /> <p>신고 받은 쪽지만 보기</p>
				</div>
	
				<table class="message-result-box">
					<thead>
						<tr>
							<th>쪽지 번호</th>
							<th>게시글 번호</th>
							<th>발신자</th>
							<th>수신자</th>
							<th>등록일시</th>
						</tr>
					</thead>
					<tbody id="messageList"></tbody>
				</table>
			</div>

			<!-- 단일 쪽지 상세보기 -->
			<div id="msg-detail">
				<div class="top">
					<button class="escape"><i class="fa-solid fa-x"></i></button>
				</div>
				<table>
					<thead>
						<tr>
							<th>쪽지번호</th>
							<th>내용</th>
							<th>등록일시</th>
							<th>수신자</th>
							<th>수신자삭제</th>
							<th>발신자</th>
							<th>발신자삭제</th>
							<th>읽음여부</th>
							<th>게시물번호</th>
						</tr>
					</thead>
					<tbody id="msg-detail-Info"></tbody>
				</table>		
			</div>
			
			<!-- 쪽지 방 보기 -->
			<div id="room-detail">
				<div class="top">
					<p class="idx">게시글 번호</p>
					<p class="subject">제목</p>
					<button class="escape"><i class="fa-solid fa-x"></i></button>
				</div>
				<div class="user_email">
					<p>판매자 : <span class="seller-email">이메일</span></p>
					<p>구매자 : <span class="buyer-email">이메일</span></p>
				</div>
				<table>
					<thead>
						<tr>
							<th>쪽지번호</th>
							<th>내용</th>
							<th>등록일시</th>
							<th>수신자</th>
							<th>수신자삭제</th>
							<th>발신자</th>
							<th>발신자삭제</th>
							<th>읽음여부</th>
						</tr>
					</thead>
					<tbody id="room-detail-Info"></tbody>
				</table>		
			</div>
		</section>
	</main>
</body>

<script>
// 타임스탬프 형식 문자열로 DateToString();
roomListCall('', 'N');
messageListCall('', 'N');

// 메시지 룸 불러오기
$(".room-search-btn").click(function() {
	var searchText = $(this).closest('.search-box').find('input[type="text"]').val();
    var reportChecked = $(this).closest('.search-box').find('input[type="checkbox"]').prop('checked');
    
    // 체크 됨에 따라서 Y,N으로 구분
    var reportYN = reportChecked ? 'Y' : 'N';
    
    // console.log("Value of input box:", searchText);
    // console.log("Checkbox value:", reportYN);
    roomListCall(searchText, reportYN);
});

function roomListCall(searchText, reportYN){
	$.ajax({
		type:'GET',
		url:'./roomList.ajax',
		data:{
			"searchText" : searchText,
			"reportYN" : reportYN
		},
		dataType:'JSON',
		success:function(data){
			if (data.result) {
				roomDrawList(data.list);			
			}
		},
		error:function(error){
			console.log(error);
		}
	});
}

function roomDrawList(list){
	var content = '';
	
	for (item of list) {
		content +='<tr onclick="roomDetail(event)" data-value=\''+JSON.stringify(item)+'\'>';
		content +=		'<td>'+item.idx+'</td>';
		content +=		'<td>'+item.subject+'</td>';
		content +=		'<td>'+item.receive_email+'</td>';
		content +=		'<td>'+item.sender_email+'</td>';
		content +=		'<td>'+DateToString(item.reg_date)+'</td>';
		content +='</tr>';
	}

	$('#roomList').html(content);
}

// 메시지 리스트 불러오기
$(".message-search-btn").click(function() {
    var searchText = $(this).closest('.search-box').find('input[type="text"]').val();
    var reportChecked = $(this).closest('.search-box').find('input[type="checkbox"]').prop('checked');
    
    // 체크 됨에 따라서 Y,N으로 구분
    var reportYN = reportChecked ? 'Y' : 'N';
    
    // console.log("Value of input box:", searchText);
    // console.log("Checkbox value:", reportYN);
    messageListCall(searchText, reportYN);
});

function messageListCall(searchText, reportYN){
	$.ajax({
		type:'GET',
		url:'./messageList.ajax',
		data:{
			"searchText" : searchText,
			"reportYN" : reportYN
		},
		dataType:'JSON',
		success:function(data){
			if (data.result) {
				messageDrawList(data.list);			
			}
		},
		error:function(error){
			console.log(error);
		}
	});
}

function messageDrawList(list){
	var content = '';
	
	for (item of list) {
		content +='<tr onclick="msgDetail(event)" data-value=\''+JSON.stringify(item)+'\'>';
		content +=		'<td>'+item.message_idx+'</td>';
		content +=		'<td>'+item.idx+'</td>';
		content +=		'<td>'+item.sender_email+'</td>';
		content +=		'<td>'+item.receive_email+'</td>';
		content +=		'<td>'+DateToString(item.reg_date)+'</td>';
		content +='</tr>';
	}

	$('#messageList').html(content);
}

// 상세 보기
$('.escape').click(function() {
    $(this).closest('.top').parent().hide();
});

function msgDetail(event){
	var data = $(event.target).closest('tr').data("value");
	$('#msg-detail').show();

	var content = '';
	content +='<tr>';
	content +=		'<td>'+data.message_idx+'</td>';
	content +=		'<td>'+data.content+'</td>';
	content +=		'<td>'+DateToString(data.reg_date)+'</td>';
	content +=		'<td>'+data.receive_email+'</td>';
	content +=		'<td>'+data.receive_del+'</td>';
	content +=		'<td>'+data.sender_email+'</td>';
	content +=		'<td>'+data.sender_del+'</td>';
	content +=		'<td>'+data.read_check+'</td>';
	content +=		'<td>'+data.idx+'</td>';
	content +='</tr>';

	$('#msg-detail-Info').html(content);
}

function roomDetail(event){
	var data = $(event.target).closest('tr').data("value");
	
	$.ajax({
		type:'GET',
		url:'./roomDetailCall.ajax',
		data:{
			"idx" : data.idx,
			"seller" : data.receive_email,
			"buyer" : data.sender_email
		},
		dataType:'JSON',
		success:function(data){
			if (data.result) {
				$('#room-detail').show();
			
				var content = '';
				var subject = '';
				for (item of data.list) {
					content +='<tr>';
					content +=		'<td>'+item.message_idx+'</td>';
					content +=		'<td>'+item.content+'</td>';
					content +=		'<td>'+DateToString(item.reg_date)+'</td>';
					content +=		'<td>'+item.receive_email+'</td>';
					content +=		'<td>'+item.receive_del+'</td>';
					content +=		'<td>'+item.sender_email+'</td>';
					content +=		'<td>'+item.sender_del+'</td>';
					content +=		'<td>'+item.read_check+'</td>';
					content +='</tr>';
					
					subject = item.subject;
				}
				$('.seller-email').html(data.seller);
				$('.buyer-email').html(data.buyer);
				$('.idx').html(data.idx);
				$('.subject').html(subject);
				
				$('#room-detail-Info').html(content);		
				
			}
		},
		error:function(error){
			console.log(error);
		}
	});
}

// 선택하면 선택 요소 색상 변경
</script>
</html>