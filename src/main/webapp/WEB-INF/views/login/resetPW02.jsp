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
	body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
 	.pwbox{
        border: 2px solid #aaa;
        border-radius: 20px;
        padding: 20px;
        width: 600px;
        max-width: 100%;
    }
</style>
</head>

<body>
	<form action="newPW">	
		<h3>Beans.새비밀번호 생성</h3>
		<div class = "pwbox">
		<input type="text" id="pw1" oninput="pwCheck()" placeholder="비밀번호">
		<input type="text" id="pw2" oninput="pwCheck()" placeholder="비밀번호 확인"><br>
		<span id="pwConfirm">비밀번호를 입력하세요</span><br>
		<input type="submit" value = "비밀번호 변경">
		</div>

	</form>
</body>

<script>
function pwCheck(){
    if($('#pw1').val() == $('#pw2').val()){
        $('#pwConfirm').text('비밀번호 일치').css('color', 'green')
    }else{
        $('#pwConfirm').text('비밀번호 불일치').css('color', 'red')
    }
}

</script>
</html>