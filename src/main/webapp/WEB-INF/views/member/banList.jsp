<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/banList.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="ban-top">
				<p id="nic">${name}&nbsp;</p>
				<p>님의 차단 목록</p>
			</div>
			<div class="ban-center">
				<table>
					<thead>
						<tr>
							<th class="one">No</th><th class="two">이메일</th><th class="three">닉네임</th><th class="four">차단</th>
						</tr>
					</thead>
					<tbody id="banListT">
						<%-- <tr>
							<th>1</th>
							<td>${item.email}</td>
							<td>${item.name}</td>
							<td class="four-div"><p id="unravel">해제</p></td>
						</tr> --%>
					</tbody>
				</table>
			</div>
			<div class="banDel">
				<div class="banDel-top">
					<button class="deleteBtn">X</button>
				</div>
				<div class="banDel-center">
					<div class="banDel-center-pDiv">
						<div class="pDiv"><p id="textP"><span id="blockName">묭</span>&nbsp;님을 차단 해제 하시겠습니까?</p></div>
						<p class="unravel" id="unravelAjax">해제</p>
						<p class="unravel" id="back">취소</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	banListCall();

	function banListCall() {
		$.ajax({
			type: 'get', 
			url: '<c:url value="/member/banList.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data) {
				drawBanList(data);
			}, error: function(data){}
		});
	}
	
	function drawBanList(data) {
		$('#banListT').empty();
		
		var content = '';
		var idx = 0;
		
		if (!data.list || data.list.length === 0) {
			content += '<tr><td colspan = 4>차단한 회원이 없습니다.</td></tr>';
		}
		for (item of data.list) {
			idx++;
			content += '<tr>';
			content += '<th><div class="tbodyDiv">'+idx+'</div></th>';
			content += '<td><div class="tbodyDiv">'+item.block_email+'</div></td>';
			content += '<td><div class="tbodyDiv">'+item.block_name+'</div></td>';
			content += '<td><div class="tbodyDiv"><p class="unravel">해제</p></div></td>';
			content += '</tr>';
		}
		
		$('#banListT').append(content);
	}
	
	$('#banListT').on('click', '.unravel', function(event) {
		event.stopPropagation();
		
		var $tr = $(this).closest('tr');
		var blockEmail = $tr.find('td').eq(0).text();
		var blockName = $tr.find('td').eq(1).text();
		
		$('#blockName').text(blockName);
		
		$('.banDel').addClass('active');
		
		$('#unravelAjax').on('click', function() {
			$.ajax({
				type: 'get', 
				url: '<c:url value="/member/banUnravel.ajax"/>',
				data: {
					'blockEmail': blockEmail
				},
				dataType: 'JSON',
				success: function(data) {
					drawBanList(data);
				}, error: function(data){}
			});
			
			$('.banDel').removeClass('active');
		})
		
	});
	$('#back').on('click', function() {
		$('.banDel').removeClass('active');
	})
	$('.deleteBtn').on('click', function() {
		$('.banDel').removeClass('active');
	})
	
	
	

</script>
</html>