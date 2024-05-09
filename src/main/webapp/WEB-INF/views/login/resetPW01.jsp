<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>BeansPassword찾기(Email인증)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        section {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0 auto;
            width: 100%;
        }

        section h3 {
            font-size: 25px;
        }

        section .Email_box {
            border: 2px solid #aaa;
            border-radius: 20px;
            padding: 20px;
            width: 600px;
            max-width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        section .Email_box dl {
            display: flex;
            width: 100%;
        }

        section .Email_box dl dt {
            width: 100px;
            line-height: 40px;
            font-weight: 600;
            text-align: center;
        }

        section .Email_box dl dd {
            width: calc(100% - 100px);
            position: relative;
        }

        section .Email_box input {
            width: 100%;
            border: 1px solid #ccc;
            height: 40px;
            line-height: 40px;
            border-radius: 5px;
            padding: 0 10px;
        }

        section .Email_box span {
            display: block;
            width: 100%;
            color: #555;
            font-size: 12px;
            text-align: center;
            margin-top: 10px;
        }

        section input[type="submit"] {
            padding: 0px 20px;
            border: none;
            background-color: gray;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        section button {
            padding: 5px 15px;
            border: 2px solid gray;
            background-color: white;
            color: gray;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 5px;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<jsp:include page="../common.jsp" />
<section>
    <form action="updatepw.do" method="post" id="resetPWForm">
        <h3>BeansPassword변경(Email인증)</h3>
        <div class="Email_box">
            <dl>
                <dt>ID(EMAIL) :</dt>
                <dd>
                    <input type="text" name="email" id="email" placeholder="이메일을 입력해주세요"/>
                    <button type="button" id="emailsend" name="emailsend">이메일 인증</button>
                </dd>
            </dl>
            <dl>
                <dt>인증코드 :</dt>
                <dd>
                    <input type="text" name="code" id="code" placeholder="인증코드를 입력해주세요" disabled/>
                    <button type="button" id="codeconfirm" name="codeconfirm" disabled>확인</button>
                </dd>
            </dl>

            <dl>
                <dt>새 비밀번호 :</dt>
                <dd>
                    <input type="password" name="pw1" id="pw1" oninput="pwCheck()" placeholder="비밀번호" disabled>
                </dd>
            </dl>
            <dl>
                <dt>비밀번호 확인 :</dt>
                <dd>
                    <input type="password" name="password" id="password" oninput="pwCheck()" placeholder="비밀번호 확인" disabled>
                </dd>
            </dl>
            <span id="pwConfirm">비밀번호를 입력하세요</span>
            <input type="submit" value="비밀번호 변경" disabled/>
        </div>
    </form>
</section>
<script>
    $(document).ready(function() {
        $('#emailsend').click(function() {
            var email = $('#email').val();
            if (email === "") {
                alert('이메일을 입력하세요.');
                return;
            }
            alert('이메일 인증 요청을 보냈습니다.');
            $('#code').prop('disabled', false);
            $('#codeconfirm').prop('disabled', false);
        });

        $('#codeconfirm').click(function() {
            var code = $('#code').val();
            if (code === "123456") {
                alert('확인되었습니다.');
                $('#pw1').prop('disabled', false);
                $('#password').prop('disabled', false);
                $('input[type="submit"]').prop('disabled', false);
            } else {
                alert('다시 확인해주세요.');
            }
        });

        // 비밀번호 일치 확인
        $('#pw1, #password').on('input', pwCheck);
    });

    // 비밀번호 변경 폼 submit 이벤트
    $('#resetPWForm').submit(function(event) {
        event.preventDefault(); // 기본 이벤트 동작 중단

        // FormData 객체 생성
        var formData = new FormData();
        var email = $('#email').val();
        var password = $('#pw1').val();

        // FormData에 필드 추가
        formData.append('email', email);
        formData.append('password', password);

        // 비밀번호 변경 Ajax 요청
        $.ajax({
            url: 'updatepw.do',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert("비밀번호가 변경되었습니다.!");
                location.href = "login.go";
            },
            error: function(xhr, status, error) {
                alert("비밀번호 변경에 실패했습니다: " + error);
            }
        });
    });

    // 비밀번호 일치 확인 함수
    function pwCheck() {
        var pw1 = $('#pw1').val();
        var pw = $('#password').val();

        if (pw1 === pw && pw1 !== '' && pw !== '') {
            $('#pwConfirm').text('비밀번호 일치').css('color', 'green');
        } else {
            $('#pwConfirm').text('비밀번호 불일치').css('color', 'red');
        }
    }
</script>
</body>
</html>
