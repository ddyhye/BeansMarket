<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/myApproveList.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="approve-top">
				<p id="nic">${name}&nbsp;</p>
				<p>님의 거래 미승인 리스트&nbsp;&nbsp;</p>
			</div>
			<div class="approve-center">
				<div class="approve-center-list">
					<div class="approve-center-list-left">
						<img src="/photo/juka.png"/>
						<p>주카의 사진 1000원부터</p>
						<div class="approve-center-list-center-mark1"><span>경매</span></div>
					</div>
					<div class="approve-center-list-center">
						<div class="approvel-center-list-center-subject">
							<h2>주카의 사진 1000원부터</h2>
						</div>
						<div class="approve-center-list-center-content">
							<p>상대방 거래 승인일 : item.reg_date</p>
							<p id="approveBtn">거래 승인</p>
						</div>
					</div>
				</div>
			</div>
			<div class="approve-bottom">
			</div>
		</div>
	</div>

</body>

<script>
	listCall();	
	
	function listCall() {
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/myApproveList.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data) {
				drawApproveList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	
	function drawApproveList(data) {
		$('.approve-center').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<p> 예약 중인 모든 거래를 승인하였습니다. </p>';
		}
		for (item of data.list) {
			content += '<div class="approve-center-list">';
			content += '<div class="approve-center-list-idx" style="display: none;">'+item.idx+'</div>';
			content += '<div class="approve-center-list-left">';
			content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
			content += '<p>'+item.subject+'</p>';
			content += (item.option === '경매'? '<div class="buy-center-list-center-mark1"><span>경매</span></div>':'');
			content += '</div>';
			content += '<div class="approve-center-list-center">';
			content += '<div class="approvel-center-list-center-subject">';
			content += '<h2>'+item.subject+'</h2>';
			content += '</div>';
			content += '<div class="approve-center-list-center-content">';
			dateStr = DateToString(item.reg_date);
			content += '<p>상대방 거래 승인일 :&nbsp;'+dateStr+'</p>';
			content += '<p id="approveBtn">거래 승인</p>';
			content += '</div>';
			content += '</div>';
			content += '</div>';			
		}
		
		$('.approve-center').append(content);
	}
	// timestamp 형식인 거 문자열로 변환하는 함수
   	function DateToString(timesteamp){
      	var date = new Date(timesteamp);
      	var dateStr = date.toLocaleDateString("ko-KR");
      	return dateStr;
   	}
	// 승인 버튼
	$('.approve-center').on('click', '#approveBtn', function(event) {
		event.stopPropagation();
		
		var idx = $(this).closest('.approve-center-list').find('.approve-center-list-idx').text();
		
		window.location.href = '<c:url value="/message/noteMessage.go?idx='+idx+'"/>';
				
// 		$.ajax({
// 			type: 'get',
// 			url: '<c:url value="/member/myApproveClick.ajax"/>',
// 			data: {
// 				'idx': idx
// 			},
// 			dataType: 'JSON',
// 			success: function(data) {
// 				listCall();
// 			}, error: function(error) {
// 				console.log(error);
// 			}
// 		});
	});
	
	
	// 게시글로 이동
	$('.approve-center').on('click', '.approve-center-list', function() {
		var idx = $(this).closest('.approve-center-list').find('.approve-center-list-idx').text();
	
		window.location.href = '<c:url value="/board/detail.go?idx='+idx+'"/>';
	});
</script>
</html>