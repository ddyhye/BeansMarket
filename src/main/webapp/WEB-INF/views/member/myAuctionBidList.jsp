com.beans.market<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/myAuctionBidList.css" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="Auction-top">
				<p id="nic">${name}&nbsp;</p>
				<p>님의 입찰 내역</p>
			</div>
			<div class="Auction-center">
				<table>
					<thead>
						<tr>
							<th class="one">Img</th><th class="two">제목</th><th class="three">나의 입찰가</th><th class="four">경매 마감</th><th class="five">경매 상태</th><th class="six">현재 입찰자</th>
						</tr>
					</thead>
					<tbody id="auctionList">
						<!-- <tr>
							<td>사진</td>
							<td>제목</td>
							<td>나의 입찰가</td>
							<td>경매 마감</td>
							<td>경매 상태</td>
							<td>현재 입찰자</td>
						</tr> -->
					</tbody>
				</table>
			</div>
		</div>
</body>

<script>
	AuctionBidListCall();
	
	function AuctionBidListCall() {
		$.ajax({
			type: 'get',
			url: '<c:url value="/member/myAuctionList.ajax"/>',
			data: {},
			dataType: 'JSON',
			success: function(data) {
				drawBidList(data);
			}, error: function(data){}	
		});
	}
	
	function drawBidList(data){
		$('#auctionList').empty();
		
		var content = '';
		
		if (!data.list || data.list.length === 0) {
			content += '<tr><td colspan = 6>입찰 목록이 없습니다.</td></tr>';
		}
		for (item of data.list) {
			content += '<tr>';
			content += '<td><img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/></td>';
			content += '<td>'+item.subject+'</td>';
			content += '<td>'+item.price+'</td>';
			content += '<td>'+item.close_date+'</td>';
			content += '<td>'+item.bbs_state+'</td>';
			content += '<td>'+item.bidder+'</td>';
			content += '</tr>';
		}
		
		$('#auctionList').append(content);
	}


</script>
</html>