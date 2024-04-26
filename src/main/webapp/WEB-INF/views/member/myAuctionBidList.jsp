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
							<th class="one">Img</th><th class="two">제목</th><th class="three">입찰가</th><th class="four">차단</th>
						</tr>
					</thead>
					<tbody id="auctionListT">
						<%-- <tr>
							<th>1</th>
							<td>${item.email}</td>
							<td>${item.name}</td>
							<td class="four-div"><p id="unravel">해제</p></td>
						</tr> --%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
			
			
			
			<!-- 
			<div class="myAuction">${name}님의 입찰 목록</div>
			<div class="myAuctionList">
			<table>
			<thead>
				<tr>
					<th>Img</th>
					<th>제목</th>
					<th>나의 입찰가</th>
					<th>경매 마감</th>
					<th>경매 상태</th>
					<th>현재 입찰자</th>
				</tr>
<%--    			<c:forEach>
				<tr>
					<th>Img</th>
					<th>${subject}</th>
					<th>${price}</th>
					<th>${close_date}</th>
					<th>경매 상태</th>
					<th>현재 입찰자</th>
				</tr>
			</c:forEach> --%>
			</thead>
<!-- 			<tbody id="list">
			<tr>
				<td colspan=6>
				<div class="container">
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
				</td>
			</tr>
			</tbody> 
			</table>
			</div>
		
		</div>-->

</body>

<script>
var showPage = 1;


</script>
</html>