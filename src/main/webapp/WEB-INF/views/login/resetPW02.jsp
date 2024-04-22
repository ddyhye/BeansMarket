<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.UUID" %>
<%
    // 세션으로부터 이메일 값을 가져옴
    String email = (String) session.getAttribute("resetEmail");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Beans.새비밀번호 생성</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="resources/css/common.css" type="text/css"/>
    <link rel="stylesheet" href="resources/css/detail.css" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        section {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .pwbox {
            border: 2px solid #aaa;
            border-radius: 20px;
            padding: 20px;
            width: 600px;
            max-width: 100%;
        }
        .pwbox input[type="text"], 
        .pwbox input[type="submit"] {
            width: 100%;
            height: 40px;
            line-height: 40px;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
        #pwConfirm {
            color: green;
        }
    </style>
</head>
<jsp:include page="../common.jsp" />
<body>
    <section>
        <form id="pwForm" action="newPW.do">    
            <h3>Beans.새비밀번호 생성</h3>
            <div class="pwbox">
            	 <input type="text" name="email" value="<%= email %>">
                <input type="text" name="pw1" id="pw1" oninput="pwCheck()" placeholder="비밀번호">
                <input type="text" name="pw" id="pw" oninput="pwCheck()" placeholder="비밀번호 확인"><br>
                <span id="pwConfirm">비밀번호를 입력하세요</span><br>
                <button type="button" name="changer" onclick="passwordchange()">비밀번호 변경</button>
            </div>
        </form>
    </section>
</body>

<script>
function pwCheck(){
    if($('#pw1').val() == $('#pw').val()){
        $('#pwConfirm').text('비밀번호 일치').css('color', 'green')
    } else {
        $('#pwConfirm').text('비밀번호 불일치').css('color', 'red')
    }
}

function passwordchange() {
	var email = $('input[name="email"]').val();
    var pw1 = $('input[name="pw1"]').val();
    var pw = $('input[name="pw"]').val();
    
    alert("Email: " + email); // email 값 확인

    var jsonData = {
        email: email,
        pw: pw
    };

    $.ajax({
        url: 'newPW.do',
        type: 'POST',
        data: JSON.stringify(jsonData),
        contentType: 'application/json',
        success: function(response) {
            alert(response); // 비밀번호 변경 성공 메시지 표시
        },
        error: function(xhr, status, error) {
            alert("비밀번호 변경에 실패했습니다: " + error); // 실패 시 에러 메시지 표시
        }
    });
}
</script>
</html>