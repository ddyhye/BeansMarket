<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Beans 아이디 등록 확인</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    body, html {
        height: 100%;
        margin: 0;
        font-family: Arial, sans-serif;
    }

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

    section .login_box {
        border: 2px solid #aaa;
        border-radius: 20px;
        padding: 20px;
        width: 600px;
        max-width: 100%;
    }

    section .login_box dl {
        display: flex;
    }

    section .login_box dl dt {
        width: 100px;
        line-height: 40px;
        font-weight: 600;
        text-align: center;
    }

    section .login_box dl dd {
        width: calc(100% - 100px);
        position: relative;
    }

    section .login_box input[type="text"] {
        width: calc(100% - 20px);
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 5px 10px;
    }

    section .login_box input[type="button"] {
        width: 100%; /* 버튼을 전체 너비로 설정 */
        margin-top: 15px; /* 버튼과 상단 간격 설정 */
        padding: 10px 0; /* 버튼 내부 패딩 설정 */
        border-radius: 5px;
        border: none;
        cursor: pointer;
        background-color: #888; /* 회색으로 변경 */
        color: #fff; /* 텍스트 색상 변경 */
        font-size: 16px; /* 폰트 크기 변경 */
    }

    section .login_box input[type="button"]:hover {
        background-color: #777; /* 호버 시 배경색 어둡게 변경 */
    }
</style>
</head>
<body>
<jsp:include page="../common.jsp" />
<section>
    <form>
        <h3>Beans.아이디 등록 확인</h3>
        <div class="login_box">
            <dl>
                <dt>ID(Email)</dt>
                <dd>
                    <input type="text" name="find" id="find" placeholder="이메일을 입력해주세요"/>
                </dd>
            </dl>
            <input type="button" value="확인" onclick="overlay()"/>
        </div>
    </form>
</section>

<script>
    var overChk = false;
    var msg = '${msg}'; // 쿼터 빠지면 넣은 문구가 변수로 인식됨.
    if (msg != '') {
        alert(msg);
    }

    function overlay() {
        var id = $('#find').val();
        $.ajax({
            type: 'post',
            url: 'overlay.do',
            data: {'id': id},
            success: function (data) {
                console.log(data);
                if (data.use > 0) {
                    alert('등록된 아이디입니다.');
                    $('#find').val('');
                } else {
                    alert('등록되지 않은 아이디입니다.');
                    overChk = true;
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
</script>
</body>
</html>