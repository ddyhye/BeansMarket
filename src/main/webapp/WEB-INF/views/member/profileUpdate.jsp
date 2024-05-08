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
				<div class="pwUpdate">
					<div class="pwUpdate-top">
						<button class="deleteBtn">X</button>
					</div>
					<div class="pwUpdate-center">
						<div class="pwUpdate-center-1Div">
							<div class="pwHead">
								<p>비밀번호</p>
							</div>
							<div class="pwBody">
								<input type="password" name="pw1" id="pw1" oninput="pwCheck()" placeholder="">
								<div class="eyes">
				                    <i class="fa fa-eye-slash fa-lg"></i>
				                </div>
			                </div>
						</div>
						<div class="pwUpdate-center-2Div">
							<div class="pwHead">
								<p>비밀번호 확인</p>
							</div>
							<div class="pwBody2">
								<input type="password" name="pw2" id="pw2" oninput="pwCheck()" placeholder="">
					        </div>
						</div>
						<div class="pwUpdate-center-2Div">
							<div class="pwHead">
							</div>
							<div class="pwBody2">
								<span id="pwConfirm">* 비밀번호를 입력하세요.</span>
					        </div>
						</div>
					</div>
					<div class="pwUpdate-bottom">
						<p id="pwUpdateSucc">완료</p>
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
							<div class="profileUpdate-center-body pw">
								<p id="pwUpdateBtn">비밀번호 재설정</p>
							</div>
							<input type="hidden" name="pwReset" id="pwReset" value="${pw}"/>
						</div>
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
							<div class="profileUpdate-center-body pw">
								<%-- <input type="text" name="gender" value="${gender}"/> --%>
								<c:if test="${gender eq '남'}">
								    <input type="radio" name="gender" value="남" checked/>남&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="gender" value="여"/>여
								</c:if>
								<c:if test="${gender eq '여'}">
								    <input type="radio" name="gender" value="남"/>남&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="gender" value="여" checked/>여
								</c:if>
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
	// 프로필 사진 업데이트 모달창
	$('#picUpdateBtn').on('click', function() {
		$('.picUpdate').addClass('active');
	});
	$('.deleteBtn').on('click', function() {
		$('.picUpdate').removeClass('active');
		$('.pwUpdate').removeClass('active');
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
			
			formData.append('photoName', $('#realPicPath').val());
			
			$.ajax({
				type: 'POST',
				url: './newPicPath.ajax',
				data: formData,
				processData: false,
				contentType: false,
				success: function(data) {
					console.log($('#realPicPath').val());
				}, error: function(data){}
			});
		}
		
		$('.picUpdate').removeClass('active');
	});
	
	
	// 비밀번호 재설정 모달창
	$('#pwUpdateBtn').on('click', function() {
		$('.pwUpdate').addClass('active');
	});
	// 비밀번호 보이기
	$('.eyes').click(function() {
        var $password = $('#pw1');
        var $icon = $(this).find('i');
        if ($password.attr('type') === 'password') {
            $password.attr('type', 'text');
            $icon.removeClass('fa-eye-slash').addClass('fa-eye');
        } else {
            $password.attr('type', 'password');
            $icon.removeClass('fa-eye').addClass('fa-eye-slash');
        }
    });
	// 비밀번호 체크
	function pwCheck() {
	    if ($('#pw1').val() == $('#pw2').val()) {
	        $('#pwConfirm').text('* 비밀번호 일치').css('color', '#377520');
	    } else {
	        $('#pwConfirm').text('* 비밀번호 불일치').css('color', '#cf4e51');
	    }
	}
	// 비밀번호 완료
	$('#pwUpdateSucc').click(function() {
        var password = $('#pw1').val(); // pw1 필드에서 값을 가져옵니다.
        $('#pwReset').val(password); // pwReset 히든 필드에 값을 설정합니다.
        $('.pwUpdate').removeClass('active');
    });
</script>
</html>