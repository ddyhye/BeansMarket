<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/adminLogin.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>

<body>
	<div class="admin-login-container">
	    <h3 class="head">BEANS_admin</h3>
	    <form action="adminLogin.do" method="post" id="loginForm">
	        <div class="login_box">
	            <div class="id_box">
	                <p>ID</p>
	                <input type="text" name="id" id="id" placeholder="이메일을 입력해주세요"/>
	            </div>
	            <div class="pw_box">
	                <p>PASSWORD</p>
	                <input type="password" name="pw" id="pw" class="form-input" placeholder="비밀번호를 입력해주세요"/>        
	            </div>
	            <div class="login_btm">
	                <input type="submit" value="로그인">
	            </div>
	        </div>
	    </form>	
	</div>
</body>

<script>
	var msg = '${msg}';
	if(msg != ''){
		alert(msg);
	}
</script>
</html>