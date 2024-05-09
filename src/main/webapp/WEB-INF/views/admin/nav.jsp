<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>
<body>
	<nav>
          <div class="nav_items">
            <ul>
              <li><a href="<c:url value='/admin/userManage.go'/>">회원 관리</a></li>
              <li><a href="<c:url value='/admin/boardManage.go'/>">게시물 관리</a></li>
              <li><a href="<c:url value='/admin/messageManage.go'/>">쪽지 관리</a></li>
              <li><a href="<c:url value='/admin/inquiryManage.go'/>">1 : 1 문의 관리</a></li>
              <li><a href="<c:url value='/admin/report.go'/>">신고 내역 관리</a></li>
              <!-- <li><a href="<c:url value='/admin/notice.go'/>">공지사항 관리</a></li>  -->
              <li><a href="<c:url value='/admin/category.go'/>">카테고리 관리</a></li>
              <!-- <li><a href="<c:url value='/admin/question.go'/>">자주 묻는 질문 관리</a></li> -->
           	  <li class="history-item">히스토리 관리
			      <ul class="sub-menu">
			        <li><a href="<c:url value='/admin/panaltyHistory.go'/>">경고 및 제재</a></li>
			        <li><a href="<c:url value='/admin/reportHistory.go'/>">신고처리</a></li>
			        <li><a href="<c:url value='/admin/payHistory.go'/>">입출금 내역</a></li>
			        <li><a href="<c:url value='/admin/bidHistory.go'/>">경매 입찰</a></li>
			        <li><a href="<c:url value='/admin/approHistory.go'/>">거래 승인</a></li>
			        <li><a href="<c:url value='/admin/dealHistory.go'/>">거래 내역</a></li>
			        <li><a href="<c:url value='/admin/comentHistory.go'/>">거래 후기</a></li>
			        <li><a href="<c:url value='/admin/alarmHistory.go'/>">알림</a></li>
			      </ul>
			  </li>
            </ul>
          </div>
	</nav>
</body>
<script>
	$(document).ready(function(){
	    $(".nav_items li").click(function(){
	        window.location.href = $(this).find("a").attr("href");
	    });
	});
</script>
</html>