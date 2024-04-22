<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Beans 회원가입</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>	
.password-input {
    position: relative;
}

.password-input input {
    padding-right: 30px; /* 아이콘 공간 확보 */
}

.password-input .eyes {
    position: absolute;
    top: 50%;
    right: 10px;
    transform: translateY(-50%);
    cursor: pointer;
}
body, html {
    height: 100%;
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
}

section {
    display: flex;	
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin-top: 90px; /* 적절한 값을 조정해주세요 */
}

.joinbox {
    border: 2px solid #aaa;
    border-radius: 20px;
    padding: 20px;
    width: 700px;
    max-width: 100%;
}

.joinbox dl {
    display: flex;
    flex-direction: column;
}

.joinbox dl dt {
    margin-top: 10px;
    font-weight: 600;
}

.joinbox dl dd {
    margin-bottom: 10px;
}

input[type="text"], input[type="password"], textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

button, input[type="submit"], input[type="button"] {
    width: auto;
    padding: 10px 20px;
    border-radius: 10px;
    border: none;
    cursor: pointer;
}

input[type="submit"]:hover, input[type="button"]:hover {
    background-color: gray;
}

#pwConfirm {
    font-size: 12px;
}

</style>
</head>
<body>
<jsp:include page="../common.jsp"/>
<form id="joinForm" action="join.do" method="post" enctype="multipart/form-data">
<section>
    <div class="joinbox">
    <h3>Beans.회원가입</h3>
    <dl>
        <dt>이메일 :</dt>
        <dd>
            <input type="text" name="email" id="email" placeholder="이메일을 입력해주세요."/>
            <input type="button" id="emailbutton" value="이메일 인증" onclick="sendVerificationEmail()" disabled/>
            &nbsp;<input type="button" value="중복체크" onclick="emailOverlay()"/>
        </dd>
        <dt>인증코드를 입력하세요. :</dt>
		<dd>
		    <input type="text" name="confirmcode" id="confirmcode" placeholder="코드를 입력해주세요."/>
		    <input type="button" id="code" value="확인" onclick="verifyCode()"/>
		</dd>
        <dt>비밀번호 :</dt>
        <dd>
            <div class="password-input">
                <input type="password" name="pw1" id="pw1" oninput="pwCheck()" placeholder="비밀번호를 입력해주세요.">
                <div class="eyes">
                    <i class="fa fa-eye-slash fa-lg"></i>
                </div>
            </div>
        </dd>
        <dt>비밀번호 확인 :</dt>
        <dd>
            <input type="password" name="pw" id="pw" oninput="pwCheck()" placeholder="비밀번호를 입력해주세요.">
            <span id="pwConfirm">비밀번호를 입력하세요.</span>
        </dd>
        <dt>닉네임 :</dt>
        <dd>            
            <input type="text" name="name" id="name" placeholder="닉네임을 입력해주세요.">
        </dd>
        <dt>프로필사진 등록 : <input type="file" id="file" name="file" multiple /> </dt>
        <dt>생년월일 :</dt>
        <dd>
            <input type="text" name="birth" id="birth" placeholder="0000-00-00.">
        </dd>
        <dt>주소 :</dt>
        <dd> 
        	<input type="text" name="location" id="location" placeholder="주소를 입력해주세요.(예:서울 관악구 신사동)"/>
        </dd>
        <dt>거래범위 :</dt>
        	<dd>
        	 <input type="text" name="scope" id="scope" placeholder="거래범위를 작성해주세요(예:서울)"/>
        	</dd>	
        
        <dt>성별 :</dt>
        <dd>
            <input type="radio" name="gender" value="남"/>남자&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="gender" value="여"/>여자
        </dd>
        <dt>[필수약관동의]<input type="radio" name="agree"/></dt> 
    </dl>
    <textarea>여러분을 환영합니다.빈즈마켓(이하"빈즈")을 이용해 주셔서 감사합니다. 본 약관은 다양한 빈즈의 이용과 관련하여 빈즈 서비스를 제공하는 빈즈와 이를 이용하는 빈즈 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 빈즈 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</textarea>
    <button type="button" onclick="validateAndSubmit()">회원가입</button>
    </div>
</section>
</form>

<script>
	// 중복 체크 여부 변수 추가
	var isEmailChecked = false;
	
	// 비밀번호 체크
	function pwCheck() {
	    if ($('#pw1').val() == $('#pw').val()) {
	        $('#pwConfirm').text('비밀번호 일치').css('color', 'green');
	    } else {
	        $('#pwConfirm').text('비밀번호 불일치').css('color', 'red');
	    }
	}
	
	// 비밀번호 보기 숨기기 기능
	$(document).ready(function() {
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
	
	// 비밀번호 확인
		$('#pw1, #pw').on('input', function() {
	        pwCheck();
	    });
	});

	// 이메일 중복체크
	function emailOverlay() {
	    var email = $('input[name="email"]').val();
	    if (email === "") {
	        alert('이메일을 입력하세요.');
	        return;
	    }
	    $.ajax({
	        type: 'post',
	        url: 'joinoverlay.do',
	        data: { 'email': email },
	        success: function(data) {
	            console.log(data);
	            if (data.use > 0) {
	                alert('이미 사용중인 아이디 입니다.');
	                $('input[name="email"]').val('');
	                // 중복 체크 실패 시, 인증 버튼 비활성화
	                $('#emailbutton').prop('disabled', true);
	                isEmailChecked = false; // 중복 체크 여부를 false로 변경
	            } else {
	                alert('사용 가능한 아이디 입니다.');
	                // 중복 체크 성공 시, 인증 버튼 활성화
	                $('#emailbutton').prop('disabled', false);
	                isEmailChecked = true; // 중복 체크 여부를 true로 변경
	            }
	        },
	        error: function(error) {
	            console.log(error);
	        }
	    });
	}
	// 이메일 인증 요청
	function sendVerificationEmail() {
	    var email = $('#email').val();
	    if (email === "") {
	        alert('이메일을 입력하세요.');
	        return;
	    }
	    alert('이메일 인증 요청을 보냈습니다.');
	    // 인증 요청 후, 확인 버튼 활성화
	    $('#code').prop('disabled', false);
	}
	
	// 인증코드 확인
	function verifyCode() {
	    var code = $('#confirmcode').val();
	    if (code === "123456") {
	        alert('확인되었습니다.');
	        // 인증번호가 맞으면 회원가입 버튼 활성화
	        $('button[type="button"]').prop('disabled', false);
	    } else {
	        alert('다시 확인해주세요');
	        // 인증번호가 틀리면 회원가입 버튼 비활성화
	        $('button[type="button"]').prop('disabled', true);
	    }
	}

	// 회원가입 유효성 검사 및 제출
	function validateAndSubmit() {
	    // 필수 항목들을 확인하고 비어 있으면 알림 후 제출을 막음
	    var $email = $('input[name="email"]');
	    var $pw = $('input[name="pw"]');
	    var $name = $('input[name="name"]');
	    var $birth = $('input[name="birth"]');
	    var $location = $('input[name="location"]');
	    var $scope = $('input[name="scope"]');
	    var $gender = $('input[name="gender"]:checked');
	    var $agree = $('input[name="agree"]:checked');
	    
	    if ($email.val() == '') {
	        alert('이메일을 입력해주세요.');
	    } else if ($pw.val() == '') {
	        alert('비밀번호를 입력해주세요.');
	    } else if ($name.val() == '') {
	        alert('닉네임을 입력해주세요.');
	    } else if ($birth.val() == '') {
	        alert('생년월일을 입력해주세요.');
	    } else if ($gender.length === 0) {
	        alert('성별을 선택해주세요.');
	    } else if(!$location.val()){
	        alert('주소를 입력해주세요.(예: 서울 관악구 신사동)')
	    } else if($scope.val()== ''){
	    	alert('거래범위를 입력해주세요.(예: 서울)')
	   }else {
	        // 모든 필수 항목이 입력되었을 때 폼 제출
	        $('#joinForm').submit();
	    }
	}

	$(document).ready(function() {
	    // 회원가입 페이지로 이동 시, 인증 확인 버튼 비활성화
	    var pathname = window.location.pathname;
	    if (pathname === "/join.do") {
	        $('#code').prop('disabled', true);
	    }
	});
</script>
</body>
</html>