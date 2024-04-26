com.beans.market<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/myBuyList.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="sell-top">
            <p id="nic">${name}&nbsp;</p>
            <p>님의 판매 내역&nbsp;&nbsp;</p>
            <select name="listSort" id="sell-top-sort">
               <option value="전체보기">전체보기</option>
               <option value="판매 중">판매 중</option>
               <option value="거래 완료">거래 완료</option>
               <option value="숨김">숨김</option>
            </select>
         </div>
         <div class="sell-center">
            <div class="sell-center-list">
               <div class="sell-center-list-left">
                  <img src="/photo/juka.png"/>
               </div>
               <div class="sell-center-list-center">
                  <div class="sell-center-list-center-content">
                     <p>주카의 사진 1000원부터&nbsp;&nbsp;&nbsp;</p>
                     <div class="sell-center-list-center-mark1"><span>경매</span></div>
                  </div>
                  <div class="sell-center-list-center-price">
                     <p>450,000원&nbsp;&nbsp;&nbsp;</p> 판매면판매가, 경매면 현재가 근데 둘다 price로 똑같
                     <div class="sell-center-list-center-mark2"><span>거래완료</span></div>
                  </div>
               </div>
               <div class="sell-center-list-right">
                  <i class="fa-solid fa-ellipsis"></i>
                  <div class="moreOption">
                     <p>숨김</p>
                     <p>삭제</p>
                  </div>
               </div>
            </div>
            <div class="sell-center-list">
               <div class="sell-center-list-left hide">
                  <img src="/photo/juka.png"/>
                  <i class="fa-solid fa-eye-slash"></i>
               </div>
               <div class="sell-center-list-center">
                  <div class="sell-center-list-center-content">
                     <p>주카의 사진 1000원부터&nbsp;&nbsp;&nbsp;</p>
                     <div class="sell-center-list-center-mark1"><span>경매</span></div>
                  </div>
                  <div class="sell-center-list-center-price">
                     <p>450,000원&nbsp;&nbsp;&nbsp;</p> 판매면판매가, 경매면 현재가 근데 둘다 price로 똑같
                     <div class="sell-center-list-center-mark2"><span>거래완료</span></div>
                  </div>
               </div>
               <div class="sell-center-list-right">
                  <i class="fa-solid fa-ellipsis"></i>
                  <div class="moreOption">
                     <p>숨김</p>
                     <p>삭제</p>
                  </div>
               </div>
            </div> 
         </div>
         
         <div class=""></div>
		</div>
	</div>
</body>

<script>
</script>
</html>