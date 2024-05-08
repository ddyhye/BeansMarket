<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<c:url value='/resources/css/inquire.css'/>" type="text/css"/>
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
			<div class="container-admin">
		   		<div class="top">
					<i class="fa-solid fa-arrow-left"></i>
				</div>
				
				<div class="enquire">
					<div class="enquire-title">
						<c:if test="${success eq 'N'}">
						    <p class="inquire-mark">처리중</p>
						</c:if>
						<c:if test="${success eq 'Y'}">
						    <p class="inquire-mark">처리 완료</p>
						</c:if>
						<h3>${inquiry_title}</h3>
					</div>
					<div class="enquire-info">
						<div class="enquire-info-1">
							<div class="enquire-info-head">문의 번호</div>
							<p id="inquiry_idx">${inquiry_idx}</p>
						</div>
						<div class="enquire-info-1">
							<div class="enquire-info-head">문의자</div>
							<p>${enquirer}</p>
						</div>
						<div class="enquire-info-2">
							<div class="enquire-info-head">문의 옵션</div>
							<p>${category_name}</p>
						</div>
						<div class="enquire-info-3">
							<div class="enquire-info-head">비밀번호</div>
							<p>${inquiry_pw}</p>
						</div>
						<div class="enquire-info-4">
							<div class="enquire-info-head">등록일</div>
							<p>${reg_date}</p>
						</div>
					</div>
					<div class="enquire-img">
						<c:forEach items="${photos}" var="photo">
							<img src="/photo/${photo.new_picname}" name="inquirePhoto"/>
						</c:forEach>
					</div>
					<div class="enquire-content">
						<p>${inquiry_account}</p>
					</div>
				</div>
				
				<div class="admin">
					<div class="enquire-info-head">답변</div>
					<div class="enquire-info-body-admin">
						<input type="hidden" id="admin_id" value="${id}"/>
						<c:if test="${reply ne 'NULL..'}">
						    <p id="adminName">${admin_name}</p>
						    <div class="admin-reply-admin">${reply}</div>
						</c:if>
						<c:if test="${reply eq 'NULL..'}">
						    <p id="adminName">${admin_name}</p>
						    <textarea rows="20" cols="135" id="admin_reply"></textarea>
						    <p id="adminReplyBtn">답변 완료</p>
						</c:if>
					</div>
				</div>
		   	</div>
 		</section>
	</main>
</body>

<script>
	// 뒤로가기
	$('.fa-arrow-left').on('click', function() {
		window.location.href='<c:url value="/admin/inquiryManage.go"/>';
	});
	
	// 답변 저장 
	$('#adminReplyBtn').on('click', function() {
		var adminReplyContent = $('#admin_reply').val();
		var inquiry_idx = $('#inquiry_idx').text();
		var adminID = $('#admin_id').val();
		
		var result = confirm('문의 답변을 저장하시겠습니까?');
        if (result) {
        	$.ajax({
    			type: 'POST',
    			url: '<c:url value="/admin/inquiryReply.ajax"/>',
    			data: {
    				'adminID': adminID,
    				'inquiry_idx': inquiry_idx,
    				'adminReplyContent': adminReplyContent
    			},
    			dataType: 'JSON',
    			success: function(data) {
    				alert('문의 답변이 완료 되었습니다...');
    				location.reload(true);
    			}, error: function(error) {
    			}
    		});
        }
	})
</script>
</html>