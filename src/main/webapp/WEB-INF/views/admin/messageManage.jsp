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
					<input type="text" name="search-val" id="subject-search" placeholder="검색할 제목 또는 게시글 번호를 입력해주세요" />
					<button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
				</div>
	
				<table class="room-result-box">
					<thead>
						<tr>
							<th>게시글 번호</th>
							<th>제목</th>
							<th>판매자</th>
							<th>구매자</th>
							<th>등록일</th>
							<th>내용 확인</th>
						</tr>
					</thead>
					<tbody id="roomList">
						<tr>
							<td>게시글 번호</td>
							<td>제목</td>
							<td>판매자</td>
							<td>구매자</td>
							<td>등록일</td>
							<td>내용 확인</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="message-search">
				<p>쪽지 번호 검색</p>
				<div class="search-box">
					<input type="text" id="msg-search" placeholder="쪽지 번호를 입력해주세요" />
					<button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
					<input type="checkbox" id="reportFilter" /> <p>신고 받은 쪽지만 보기</p>
				</div>
	
				<table class="message-result-box">
					<thead>
						<tr>
							<th>게시글 번호</th>
							<th>쪽지 번호</th>
							<th>발신자</th>
							<th>수신자</th>
							<th>등록일시</th>
						</tr>
					</thead>
					<tbody id="messgeList">
						<tr>
							<td>게시글 번호</td>
							<td>쪽지 번호</td>
							<td>발신자</td>
							<td>수신자</td>
							<td>등록일시</td>
						</tr>
					</tbody>
				</table>
			</div>

		</section>
	</main>
</body>

<script>
// messageRoomListCall();
// messageListCall();

$(".search-btn").click(function() {
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
			// messageDrawList(data.list);
		},
		error:function(error){
			console.log(error);
		}
	});
}

function messageDrawList(list){
	var content = '';
	
	for (item of list) {
		/* 추가하는 사항에 el 태그를 사용하면 속도차이로 값이 안나올수 있어 사용에 주의해야한다. -> 변수로 사용 */
		console.log(item);
		content += '<tr>';
		content +=	'<td><input type="checkbox" name="del" value="'+item.idx+'" /></td>';
		content +=	'<td>'+item.idx+'</td>';
		content +=	'<td>';
		
		var img = item.img_cnt > 0 ? 'image.png' : 'no_image.png';
		content +=	'<img class="icon" src="resources/img/'+img+'"/>';
		
		content +=	'</td>';
		content +=	'<td>'+item.subject+'</td>';
		content +=	'<td>'+item.user_name+'</td>';
		content +=	'<td>'+item.bHit+'</td>';
		
		// java.sql.Date 는 javascript 에서는 ms 로 변환하여 표시한다.
		// 방법 1. Back-end : DTO 의 반환 날짜 타입을 문자열로 변경
		// content +=	'<td>'+item.reg_date+'</td>';
		
		// 방법 2. Front-end : js 에서 직접 변환
		var date = new Date(item.reg_date);
		var dateStr = date.toLocaleDateString("ko-KR"); // en-US - 그 지역의 표준시로 보여달라
		
		content += '<td>'+dateStr+'</td>';
		
		content +='</tr>';
	}

	$('#list').html(content);
}


</script>
</html>