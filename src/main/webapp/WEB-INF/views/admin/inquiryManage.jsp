<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/userManage.css" type="text/css"/>
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
			<div class="container">
		   		<div class="memberM-top">
		   			<div class="memberM-top-search">
		   				<h4>문의명&nbsp;&nbsp;</h4>
		   				<input type="text" name="memberSearch" id="memberSearch" placeholder="검색할 문의 제목 입력..."/>
		   				<div id="memberSearchBtn">검색</div>
		   			</div>
		   			<div class="memberM-top-option">
		   				<div class="memberM-top-option-skip">
		   					<p>옵션&nbsp;</p>
		   					<i class="fa-solid fa-caret-down"></i>
		   					<i class="fa-solid fa-caret-up"></i>
		   				</div>
		   				<div class="memberM-top-option-detail">
		   					<!-- <div class="memberM-top-option-detail-gender">
		   						<div class="memberM-top-option-detail-head">
			   						<p>&nbsp;성별&nbsp;</p>
		   						</div>
		   						<input type="checkbox" name="genderOption" class="genderOption" id="genderOption1" checked/>전체&nbsp;&nbsp; 
								<input type="checkbox" name="genderOption" class="genderOption" id="genderOption2"/>남자&nbsp;&nbsp;
		   						<input type="checkbox" name="genderOption" class="genderOption" id="genderOption3"/>여자&nbsp;&nbsp;
		   					</div> -->
		   					<div class="memberM-top-option-detail-warning">
		   						<div class="memberM-top-option-detail-head">
			   						<p>&nbsp;문의 옵션&nbsp;</p>
		   						</div>
		   						<select name="warningOption" id="warningOption">
									<option value="all">전체</option>
									<option value="q001">계정</option>
									<option value="q002">시스템</option>
									<option value="q003">경매</option>
									<option value="q004">신고</option>
									<option value="q005">기타</option>
								</select>
		   					</div>
		   					<div class="memberM-top-option-detail-memberState">
		   						<div class="memberM-top-option-detail-head">
			   						<p>&nbsp;처리 상태&nbsp;</p>
		   						</div>
		   						<input type="radio" name="memberStateOption" value="all" class="memberStateOption" id="memberStateOption1" checked/><label for="memberStateOption1">전체</label>&nbsp;&nbsp;
								<input type="radio" name="memberStateOption" value="success" class="memberStateOption" id="memberStateOption2"/><label for="memberStateOption2">처리</label>&nbsp;&nbsp;
		   						<input type="radio" name="memberStateOption" value="unSuccess" class="memberStateOption" id="memberStateOption3"/><label for="memberStateOption3">미처리</label>&nbsp;&nbsp;
		   					</div>
		   				</div>
		   			</div>
		   			<div class="memberM-top-optionReset">
		   				<i class="fa-solid fa-rotate-left"></i><p>&nbsp;옵션 초기화</p>
		   			</div>
		   		</div>
		   		<div class="memberM-center">
		   			<div class="memberM-center-t">
		   				<table>
							<thead>
								<tr>
									<!-- email, name, warn_count, login_banstr, login_banend, dormant(휴먼), secession(탈퇴) -->
									<th class="one">No</th><th class="two">제목</th><th class="three">문의 옵션</th><th class="four">등록일</th><th class="five">문의자</th><th class="six">담당자</th><th class="seven">처리 상태</th>
								</tr>
							</thead>
							<tbody id="memberListT">
								<tr>
									<td>item.inquiry_idx</td>
									<td>item.inquiry_title</td>
									<td>item.category_name</td>
									<td>item.reg_date</td>
									<td>item.enquirer</td>
									<td>item.admin_name</td>
									<td>item.success</td>
								</tr>
							</tbody>
						</table>
		   			</div>
		   			<div class="memberM-center-manage">
		   				<form action="<c:url value='/admin/userManage.do'/>", method="POST">
			   				<div class="memberM-center-manage-subject">
			   					<h3>회원 관리</h3>
			   				</div>
			   				<div class="memberM-center-manage-memberEmail">
				   				<div class="memberM-center-manage-head">
				   					<p>대상 회원</p>
				   				</div>
				   				<input type="text" id="manageMemberEmail" name="memberEmail" value="ahruru@email.com" readonly>
			   				</div>
			   				<div class="memberM-center-manage-option">
			   					<div class="memberM-center-manage-head">
			   						<p>제제 옵션</p>
				   				</div>
				   				<select name="manageOption" id="manageOption">
									<option value="경고 1회 추가">경고 1회 추가</option>
									<option value="경고 1회 차감">경고 1회 차감</option>
									<option value="기간 정지 3일">기간 정지 3일</option>
									<option value="기간 정지 해제">기간 정지 해제</option>
									<option value="영구 정지">영구 정지</option>
								</select>
			   				</div>
			   				<div class="memberM-center-manage-content">
			   					<p>제제 사유</p>
			   					<input type="text" name="manageContent" id="manageContent" placeholder="최대 300자 입력 가능..."/>
			   				</div>
			   				<div class="memberM-center-manage-bottom">
			   					<input type="submit" id="submitBtn" value="확인"/>
			   					<p id="back">취소</p>
			   				</div>
			   			</form>
		   			</div>
		   		</div>
		   	</div>
 		</section>
	</main>
</body>

<script>
	//option 펼침/닫힘
	$('.memberM-top-option-skip').on('click', function(){
		var isToggled = $(this).data('toggled');
		
		// $() 특정 요소 명시
	    var $caretDown = $(this).find('.fa-caret-down');
	    var $caretUp = $(this).find('.fa-caret-up');
	    var $details = $('.memberM-top-option-detail');
	
	    if (isToggled) {
	        $caretDown.addClass('active');
	        $caretUp.addClass('active');
	        $details.addClass('active');
	    } else {
	        $caretDown.removeClass('active');
	        $caretUp.removeClass('active');
	        $details.removeClass('active');
	    }
	    
	    $(this).data('toggled', !isToggled);
	});
	
	
	// option 초기값
	var memberSearch = $('#memberSearch').val();
	var warningOption = $('#warningOption').val();
	var memberStateOption = $('input[name="memberStateOption"]:checked').val();

	listCall(memberSearch, warningOption, memberStateOption);
	
	$('#memberSearchBtn').on('click', function() {
		memberSearch = $('#memberSearch').val();
		listCall(memberSearch, warningOption, memberStateOption);
	});
	$('#memberSearch').change(function() {
		memberSearch = $('#memberSearch').val();
		listCall(memberSearch, warningOption, memberStateOption);
	});
	$('#warningOption').change(function() {
		warningOption = $(this).val();
		listCall(memberSearch, warningOption, memberStateOption);
	});
	$('.memberStateOption').change(function() {
	    memberStateOption = $('input[name="memberStateOption"]:checked').val();
	    listCall(memberSearch, warningOption, memberStateOption);
	});
	// 옵션 초기화
	$('.fa-rotate-left').on('click', function() {
		$('#memberSearch').val('');
		$('#warningOption').val('all');
	    $('input[name="memberStateOption"]').prop('checked', false); 
	    $('#memberStateOption1').prop('checked', true); 
	    
	    listCall('', 'all', 'all');
	});
	
	// 1:1 문의 리스트 요청 AJAX
	function listCall(memberSearch, warningOption, memberStateOption){
		$.ajax({
			type: 'get',
			url: '<c:url value="/admin/inquiryList.ajax"/>',
			data: {
				'memberSearch': memberSearch,
				'warningOption': warningOption,
				'memberStateOption': memberStateOption
			},
			dataType: 'JSON',
			success: function(data) {
				drawMemberList(data);
			}, error: function(error) {}
		});
	}
	// 1:1 문의 리스트 그리기
	function drawMemberList(data) {
		$('#memberListT').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<tr><td colspan = 7>검색한 문의 내역이 없습니다.</td></tr>';
		}
		for (item of data.list) {
			content += '<tr class="memberSelect">';
			content += '<td class="inquiry_idx">'+item.inquiry_idx+'</td>';
			content += '<td>'+item.inquiry_title+'</td>';
			content += '<td>'+item.category_name+'</td>';
			dateStr = DateToString(item.reg_date);
			content += '<td>'+dateStr+'</td>';
			content += '<td>'+item.enquirer+'</td>';
			content += '<td>'+item.admin_name+'</td>';
			content += '<td>'+item.success+'</td>';
			content += '</tr>';
		}
		
		$('#memberListT').append(content);
	}
	// timestamp 형식인 거 문자열로 변환하는 함수
   	function DateToString(timesteamp){
      	var date = new Date(timesteamp);
      	var dateStr = date.toLocaleDateString("ko-KR");
      	return dateStr;
   	}
	
	// 1:1 문의 상세보기
	$('#memberListT').on('click', '.memberSelect', function(event) {
		var inquiry_idx = $(this).find('.inquiry_idx').text();
		
		window.location.href = '<c:url value="/admin/inquiryManageDetail.go?inqIdx='+inquiry_idx+'"/>';
	});

</script>
</html>