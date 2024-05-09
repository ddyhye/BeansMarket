<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/inquire.css'/>" type="text/css"/>
<link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="../common.jsp" />
	
	<div class="containerR">
		<div class="inquire-top">
			<div class="inquire-top-head">
				<h2>1:1 문의하기</h2>
			</div>
			<div class="inquire-top-body">
				<i class="fa-solid fa-pen-to-square"></i>
			</div>
		</div>
		
		
		<div class="inquire-center">
			<div class="inquire-center-inquire">
				<div class="inquire-one">
					<p class="inquire-mark">처리중</p>
					<p>문의 제목,,</p>
				</div>
				<div class="inquire-two">
					<p>비회원</p>
				</div>
				<div class="inquire-three">
					<p>2024.12.23</p>
				</div>
			</div>
			
			<div class="inquire-center-inquire">
				<div class="inquire-one">
					<p class="inquire-mark2">처리완료</p>
					<p>문의 제목,ㅇㄹㄷㄹㄷㄹㅈㄷㄱ,</p>
				</div>
				<div class="inquire-two">
					<p>비회원</p>
				</div>
				<div class="inquire-three">
					<p>2024.12.23</p>
				</div>
			</div>
		</div>
		<div class="inquire-center-inquire-pw">
			<div class="pw-top">
				<p class="deleteBtn2">X</p>
			</div>
			<div class="pw1">
				<p>비밀번호를 입력해 주세요.</p>
			</div>
			<div class="pw2">
				<input type="text" name="pw" class="pwInput"/>
				<p class="pwBtn">확인</p>
			</div>
		</div>
		
		
		<div class="inquire-paging">
			<table>
				<tr>
					<td colspan="5">
						<div class="container">
							<nav aria-label="Page navigation" style="text-align: center">
								<ul class="pagination" id="pagination"></ul>
							</nav>
						</div>
					</td>
				</tr>
			</table>
		</div>
		
		
		<div class="inquire-bottom">
			<select name="inquireSort" id="inquireSort">
				<option value="all">전체</option>
				<option value="subject">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="inquireSearch" id="inquireSearch" />
			<p id="inquireSearchBtn">검색</p>
		</div>
		
		
	</div>

</body>

<script>

	//정렬
	var inquireSort = $('#inquireSort').val();
	$('#inquireSort').change(function() {
		selectedSort = $(this).val();
		
		listCall(inquireSort);
	});
	// 검색
	var inquireSearch = $('#inquireSearch').val();
	$('#inquireSearchBtn').on('click', function() {
		inquireSearch = $('#inquireSearch').val();
		listCall(inquireSort, inquireSearch);
	});
	
	listCall(inquireSort, inquireSearch);	
	
	function listCall(inquireSort, inquireSearch) {
		$.ajax({
			type: 'get',
			url: '<c:url value="/customerService/inquireList.ajax"/>',
			data: {
				'inquireSort': inquireSort, 
				'inquireSearch': inquireSearch
			},
			dataType: 'JSON',
			success: function(data) {
				drawInquireList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	
	function drawInquireList(data) {
		$('.inquire-center').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<p> 문희 내용히 없습니닷 </p>';
		}
		for (item of data.list) {
			content += '<div class="inquire-center-inquire">';
			content += '<div class="inquire-idx" style="display: none;">'+item.inquiry_idx+'</div>';
			content += '<div class="inquire-pw" style="display: none;">'+item.inquiry_pw+'</div>';
			content += '<div class="inquire-one">';
			content += (item.success === 'Y' ? '<p class="inquire-mark2">처리완료</p>':'<p class="inquire-mark">처리중</p>');
			content += '<p>'+item.inquiry_title+'</p>';
			content += '</div>';
			content += '<div class="inquire-two">';
			content += (item.enquirer === '비회원' ? '<p>비회원</p>':'<p>회원</p>');
			content += '</div>';
			content += '<div class="inquire-three">';
			dateStr = DateToString(item.reg_date);
			content += '<p>'+dateStr+'</p>';
			content += '</div>';
			content += '</div>';
		}
		
		$('.inquire-center').append(content);
	}
	// timestamp 형식인 거 문자열로 변환하는 함수
   	function DateToString(timesteamp){
      	var date = new Date(timesteamp);
      	var dateStr = date.toLocaleDateString("ko-KR");
      	return dateStr;
   	}
	
	// 문의 상세보기
	$('.inquire-center').on('click', '.inquire-center-inquire', function() {
		
		$('.inquire-center-inquire-pw').addClass('active');
		
		var inquiry_idx = $(this).find('.inquire-idx').text();
		var inquiry_pw = $(this).find('.inquire-pw').text();
		
		$('.pwBtn').on('click', function() {
			var inputPw = $('.pwInput').val();
			
			if (inquiry_pw === inputPw) {
				window.location.href = '<c:url value="/customerService/inquireDetail.go?inquiry_idx='+inquiry_idx+'"/>';
			} else {
				alert('비밀번호가 틀렸습니다...');
			}
			$('.pwBtn').off('click');
			$('.pwInput').val('');
			console.log();
			$('.inquire-center-inquire-pw').removeClass('active');
		});
	});
	$('.deleteBtn2').on('click', function() {
		$('.pwBtn').off('click');
		$('.pwInput').val('');
		$('.inquire-center-inquire-pw').removeClass('active');
	});


	// 문의하기 이동
	$('.fa-pen-to-square').on('click', function() {
		window.location.href = '<c:url value="/customerService/inquireWrite.go"/>';
	});
	
</script>

</html>