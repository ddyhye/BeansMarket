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
				<div class="picUpdate">
					<div class="picUpdate-top">
						<button class="deleteBtn">X</button>
					</div>
					<div class="picUpdate-center">
						<div class="picUpdate-center-pDiv">
							<p id="basicPic">기본 사진</p><p id="pHidden">&nbsp;기본 사진.jpg</p>
						</div>
						<input type="file" name="photo" id="newPic"/>
					</div>
					<div class="picUpdate-bottom">
						<p id="picUpdateSucc">완료</p>
					</div>
				</div>
				<form action="<c:url value='/member/profileUpdate.do'/>", method="POST" enctype="multipart/form-data">
					<div class="profileUpdate-top">
						<img src="/photo/${photo}" id="profilePicture"/>
						<p id="picUpdateBtn">프로필 사진 수정</p>
						<input type="hidden" name="realPicPath" value="${photo}" id="realPicPath"/>
					</div>
					<div class="profileUpdate-center">
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>닉네임</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="name" value="${name}"/>
							</div>
						</div>
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>비밀번호</h3>
							</div>
							<div class="profileUpdate-center-body">
								<p id="pwReset">비밀번호 재설정</p>
							</div>
						</div>
						<!-- <div class="pwResetDiv">
							<div class="spwResetDiv-top">
								<button class="deleteBtn2">X</button>
							</div>
							<div class="pwResetnDiv-center">
								<dl>
									<dt>비밀번호</dt>
							        <dd>
							            <div class="password-input">
							                <input type="password" name="pw1" id="pw1" oninput="pwCheck()" placeholder="비밀번호를 입력해주세요.">
							                <div class="eyes">
							                    <i class="fa fa-eye-slash fa-lg"></i>
							                </div>
							            </div>
							        </dd>
							        <dt>비밀번호 확인</dt>
							        <dd>
							            <input type="password" name="pw" id="pw" oninput="pwCheck()" placeholder="비밀번호를 입력해주세요.">
							            <span id="pwConfirm">비밀번호를 입력하세요.</span>
							        </dd>
						        </dl>
							</div>
							<div class="pwResetDiv-bottom">
								<p id="pwUpdate">확인</p>
							</div>
						</div> -->
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>주소</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="location" value="${location}"/>
							</div>
						</div>
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>생년월일</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="birth_date" value="${birth_date}"/>
							</div>
						</div>
						<div class="profileUpdate-center-column">
							<div class="profileUpdate-center-head">
								<h3>성별</h3>
							</div>
							<div class="profileUpdate-center-body">
								<input type="text" name="gender" value="${gender}"/>
							</div>
						</div>
					</div>
					<div class="profileUpdate-bottom">
						<input type="submit" value="완료"/>
						<p><span>*</span> 완료를 누르기 전에 페이지를 나가면, 변경 사항이 반영되지 않습니다.</p>
					</div>
				</form>
			<!-- </div> -->
		</div>
	</div>
</body>

<script>
	// 프로필 사진 업데이트 모달차
	$('#picUpdateBtn').on('click', function() {
		$('.picUpdate').addClass('active');
	});
	$('.deleteBtn').on('click', function() {
		$('.picUpdate').removeClass('active');
	});
	// 프로필 사진 - 기본 이미지로 변경
	$('#basicPic').on('click', function() {
		$('#newPic').val('');
		$('#pHidden').addClass('active');
	});
	// 프로필 사진 - 새 이미지로 변경
	$('#newPic').on('change', function() {
		if ($(this).val()) {
			$('#pHidden').removeClass('active');
		}
	});
	// 프로필 사진 - 변경
	$('#picUpdateSucc').on('click', function() {
		var formData = new FormData();
		var filePath = $('#newPic')[0];
		
		if ($(filePath).val()) {
			formData.append('photo', filePath.files[0]);
			
			$.ajax({
				type: 'POST',
				url: './newPicPath.ajax',
				data: formData,
				processData: false,
				contentType: false,
				success: function(data) {
					console.log(data.newFileName);
					$('#profilePicture').attr('src', '/photo/'+data.newFileName);
					$('#realPicPath').val(data.newFileName);
					console.log($('#realPicPath').val());
				}, error: function(data){}
			});
		} else {
			$('#profilePicture').attr('src', '/photo/user.png');
			$('#realPicPath').val('user.png');
		}
		
		$('.picUpdate').removeClass('active');
	});
</script>
</html>