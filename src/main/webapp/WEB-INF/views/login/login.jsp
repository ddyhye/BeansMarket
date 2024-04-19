<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<meta charset="UTF-8">
<title>Beans 로그인</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    h3{
        font-size: 25px;
    }

    .login_box{
        border: 2px solid #aaa;
        border-radius: 20px;
        padding: 20px;
        width: 600px;
        max-width: 100%;
    }

    .login_box dl{
        display: flex;
    }

    .login_box dl dt{
        width: 100px;
        line-height: 40px;
        font-weight: 600;
        text-align: center;
    }

    .login_box dl dd{
        width: calc(100% - 100px);
        position: relative;
    }

    .login_box input{
        width: 100%;
        border: 1px solid #ccc;
        height: 40px;
        line-height: 40px;
        border-radius: 5px;
        padding: 0 10px;
    }

    .eyes {
        position: absolute;
        right: 5px; 
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
    }

    .login_box p{
        color: #555;
        font-size: 12px;
        text-align: center;
    }

    .login_box .login_btm{
        text-align: center;
    }

    .login_box .login_btm .login_btn{
        padding: 0 50px;
        line-height: 45px;
        height: 45px;
        border: 1px solid #ccc;
        border-radius: 10px;
        margin-bottom: 20px;
        font-size: 16px;
    }

    .login_box .login_btm .link a{
       text-decoration: none;
       padding: 0 10px;
       position: relative;
       color: #555;
    }  

    .login_box .login_btm .link a + a::before{
        width: 1px;
        height: 12px;
        background: #555;
        position: absolute;
        top: 5px;
        left: -4px;
        content: '';
    }

    a{
        text-align : center;
        margin-top: 5px;
    }
</style>
</head>
<body>
    <form action="login" method="post">
        <h3>Beans.로그인</h3>
        <div class="login_box">
		<dl>
    		<dt>ID (EMAIL)</dt>
    		<dd><input type="text" name="email" id="email" placeholder="이메일을 입력해주세요"/></dd>
		</dl>
        <dl>
            <dt>PASSWORD</dt>
            <dd>
                <input type="password" name = "password"id="password" class="form-input" placeholder="비밀번호를 입력해주세요"/>        
                <div class="eyes">
                    <i class="fa fa-eye-slash fa-lg"></i>
                </div>
            </dd>
        </dl>
            <p>* 로그인 실패 5회 시 비밀번호 재설정이 필요합니다.</p>
            <div class="login_btm">
<!--                 <button class="login_btn">LOGIN</button> -->
				<input type="submit" value = "로그인">
                <div class="link">
                    <a href="findEmail">아이디 등록 확인</a>
                    <a href="resetPW01">비밀번호 찾기</a>
                </div>
            </div>
        </div>
    </form>

    <script>
    
    var msg = '${msg}';
    if(msg != ''){
    	alert(msg);
    }
    
    $(function() {
        $('.eyes').click(function() {
            var $password = $('#password');
            var $icon = $(this).find('i');
            if ($password.attr('type') === 'password') {
                $password.attr('type', 'text');
                $icon.removeClass('fa-eye-slash').addClass('fa-eye');
            } else {
                $password.attr('type', 'password');
                $icon.removeClass('fa-eye').addClass('fa-eye-slash');
            }
        });
    });
    </script>
</body>
</html>