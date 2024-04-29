<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="resources/css/detail.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>

<body>
    <form action="adminLogin.do" method="post" id="loginForm">
        <h3>Beans.로그인</h3>
        <div class="login_box">
            <dl>
                <dt>ID</dt>
                <dd><input type="text" name="id" id="id" placeholder="이메일을 입력해주세요"/></dd>
            </dl>
            <dl>
                <dt>PASSWORD</dt>
                <dd>
                    <input type="password" name="pw" id="pw" class="form-input" placeholder="비밀번호를 입력해주세요"/>        
                </dd>
            </dl>
            <div class="login_btm">
                <input type="submit" value="로그인">
            </div>
        </div>
    </form>
</body>

<script>
	var msg = '${msg}';
	if(msg != ''){
		alert(msg);
	}
</script>
</html>