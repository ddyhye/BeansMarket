<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="../resources/css/report.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<header>
		<jsp:include page="./common.jsp" />
	</header>
	<main>
		<jsp:include page="./nav.jsp"/>
		<section>
			<p class="title">신고 검색</p>
			<div class="search-box">
				<input type="text" name="search-val" id="subject-search" placeholder="신고 대상 이메일 또는 신고 번호를 입력해주세요" />
				<button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
				<input type="checkbox" id="incomplete" /> <p>미처리만 보기</p>
			</div>
			
			<div class="dtn-controller">
				<button class="complete-button" onclick="complete()">처리완료</button>
			</div>		
			
			<table class="report-list">
				<thead>
					<tr>
						<th class="one">선택</th>
						<th class="two">신고 번호</th>
						<th class="three">
							<select id="option">
					                <option value="ALL">구분 번호</option>
					                <option value="RB001">게시글</option> <!-- 이 부분도 원래는 카테고리 DB에서 RB로 된거로 가져와야 하는데 -->
					                <option value="RB002">쪽지</option>
					                <option value="RB003">쪽지 단일</option>
				            </select>
						</th>
						<th class="four">참조 번호</th>
						<th class="six">
				            <select id="report-category">
				                <option value="ALL">신고 분류</option>
				                <option value="r001">도배</option>
				                <option value="r002">욕설</option>
				                <option value="r003">성희롱</option>
				                <option value="r004">불법</option>
				            </select>
						</th>
						<th class="seven">등록일</th>
						<th class="eight">신고자</th>
						<th class="nine">처리자</th>
						<th class="ten">처리여부</th>
					</tr>
				</thead>
				<tbody id="list"></tbody>
			</table>
			
			<div id="contentView">
				<div class="form">
					<div class="top">
						<p>신고번호 <span class="idx">99</span>번의 내용</p>
					</div>
					<div class="content">
						<p>피곤하다</p>			
					</div>
					<div class="btn-controller">
						<button onclick="check()">확인</button>
					</div>
				</div>		
			</div><!--deleteForm 종료-->
		</section>
	</main>
</body>

<script>
	reportListCall('', 'N');
	
	$(".search-btn").click(function() {
		var searchText = $(this).closest('.search-box').find('input[type="text"]').val();
	    var incompleteChecked = $(this).closest('.search-box').find('input[type="checkbox"]').prop('checked');
	    
	    // 체크 됨에 따라서 Y,N으로 구분
	    var incompleteYN = incompleteChecked ? 'Y' : 'N';
	    
	    // console.log("Value of input box:", searchText);
	    // console.log("Checkbox value:", reportYN);
	    reportListCall(searchText, incompleteYN);
	});
	

	function reportListCall(searchText, incompleteYN){
		if(loginCheck()){
			$.ajax({
				type:'GET',
				url:'./reportListCall.ajax',
				data:{
					"searchText" : searchText,
					"incompleteYN" : incompleteYN
				},
				dataType:'JSON',
				success:function(data){
					if (data.result) {
						//console.log(data.list);
						reportDrawList(data.list);			
					}
				},
				error:function(error){
					console.log(error);
				}
			});
		}
	}
	
	function reportDrawList(list){
		var content = '';
		
		for (item of list) {
			content +='<tr onclick="reportDetail(event)" data-value=\''+JSON.stringify(item)+'\'>';
			content +=		'<td><input type="checkbox" class="select" value="'+item.report_idx+'"/></td>';
			content +=		'<td>'+item.report_idx+'</td>';
			content +=		'<td data-value="'+item.option_idx+'">'+item.option_name+'</td>';
			content +=		'<td>'+item.idx+'</td>';
			content +=		'<td data-value="'+item.category_idx+'">'+item.category_name+'</td>';
			content +=		'<td>'+DateToStringTime(item.reg_date)+'</td>';
			content +=		'<td>'+item.reporter_email+'</td>';
			content +=		'<td>'+item.admin_name+'</td>';
			content +=		'<td>'+item.report_complete+'</td>';
			content +='</tr>';
		}
	
		$('#list').html(content);
		
		$(document).ready(function(){
		    $('#list tr').hover(
		        function(){
		            $(this).css('background-color', 'lightgray');
		        },
		        function(){
		            $(this).css('background-color', ''); // 마우스가 벗어나면 원래 색상으로 돌아갑니다.
		        }
		    );
		
		    
		    // 옵션 선택 변경 시 필터링 적용
		    $('#option').change(function() {
		        var selectedOption = $(this).val(); // 선택된 옵션 값 가져오기
		        var selectedCategory = $('#report-category').val(); // 선택된 신고 분류 값 가져오기
		        applyFilters(selectedOption, selectedCategory); // 필터링 함수 호출
		    });
		    
		    // 신고 분류 선택 변경 시 필터링 적용
		    $('#report-category').change(function() {
		        var selectedOption = $('#option').val(); // 선택된 옵션 값 가져오기
		        var selectedCategory = $(this).val(); // 선택된 신고 분류 값 가져오기
		        applyFilters(selectedOption, selectedCategory); // 필터링 함수 호출
		    });
		    
		});
	}

	function complete(params) {
		var completeArr = [];
		$(".select").each(function(index, item) {
			if ($(item).is(":checked")) {
				var val = $(this).val();
				//console.log(val);
				completeArr.push(val);
			}
		});
		
		if (confirm("선택한 신고들을 완료처리 하시겠습니까?")) {
			$.ajax({
		        type:'POST',
		        url:'./complete.ajax',
		        data:{'compleList' : completeArr},
		        dataType:'JSON',
		        success:function(data){
		            if(data.cnt>0){
		            	alert('선택하신'+data.cnt+'개가 처리 완료 되었습니다.');
		            	reportListCall('', 'N');
		            }
		        	console.log(data);
		        }, 
		        error:function(error){ // 통신 실패한 경우
		             console.log(error);
		        }
		     });
		}
	}
	
	function reportDetail(event){
		if(loginCheck()){
			var data = $(event.target).closest('tr').data("value");
			
			$('#contentView span.idx').html(data.report_idx);
			$('#contentView .content p').html(data.content);
			
			check();
		}
	}
	
	// 필터링 용
	function applyFilters(selectedOption, selectedCategory) {
	    // 모든 행 숨기기
	    $('tbody tr').hide();

	    // 선택된 옵션과 신고 분류에 해당하는 행만 보이기
	    $('tbody tr').each(function() {
	        var dataValue = $(this).attr('data-value'); // 해당 행의 data-value 속성 값 가져오기
	        var item = JSON.parse(dataValue); // JSON 문자열을 객체로 변환
	        if ((selectedOption === 'ALL' || item.option_idx === selectedOption) &&
	            (selectedCategory === 'ALL' || item.category_idx === selectedCategory)) {
	            $(this).show(); // 선택된 옵션과 신고 분류에 해당하는 행만 보이기
	        }
	    });
	}
	
	function check() {
		$('#contentView').toggle();
	}
	
</script>
</html>