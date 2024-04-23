<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/profileUpdate.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<!-- <div class="profileUpdateDiv"> -->
				<form action="<c:url value='/member/profileUpdate.do'/>", method="POST" enctype="multipart/form-data">
					<div class="profileUpdate-top">
						<img src="/photo/ahruru.png" />
						<p>프로필 수정</p>
					</div>
					<div class="profileUpdate-center">
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>닉네임</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="name"/>
							</div>
						</div>
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>비밀번호</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="pw"/>
							</div>
						</div>
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>주소</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="location"/>
							</div>
						</div>
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>생년월일</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="birth_date"/>
							</div>
						</div>
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>성별</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="gender"/>
							</div>
						</div>
					</div>
					<div class="profileUpdate-bottom">
						<input type="submit" value="UPDATE"/>
					</div>
				</form>
			<!-- </div> -->
		</div>
	</div>
</body>

<script>
</script>
</html>