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

    section.check_box {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .check_box {
        border: 2px solid #aaa;
        border-radius: 20px;
        padding: 20px;
        width: 600px;
        max-width: 100%;
/*         background-color: #fff; */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: auto; /* 가운데 정렬을 위해 추가 */
    }

    .check_box dl {
        margin-bottom: 15px;
        width: 100%;
    }

    .check_box dl dt,
    .check_box dl dd {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: left;
    }

    .check_box dl dt {
        font-weight: bold;
        background-color: #f2f2f2;
    }

    .check_box dl dd input[type="text"] {
        width: calc(100% - 20px);
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 5px 10px;
    }

    .check_box dl dd input[type="button"] {
        width: auto;
        padding: 5px 15px;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        background-color: #007bff;
        color: #fff;
    }

    .check_box dl dd input[type="button"]:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
<jsp:include page="../common.jsp" />
<section class="check_box">
    <form>
        <h3>Beans.아이디 등록 확인</h3>
        <div class="check_box">
            <dl>
                <dt>ID(Email)</dt>
                <dd>
                    <input type="text" name="find">
                    <input type="button" value="확인" onclick="overlay()" />
                </dd>
            </dl>
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
        var id = $('input[name="find"]').val();
        $.ajax({
            type: 'post',
            url: 'overlay.do',
            data: { 'id': id },
            success: function (data) {
                console.log(data);
                if (data.use > 0) {
                    alert('등록된 아이디 입니다.');
                    $('input[name="id"]').val('');
                } else {
                    alert('등록되지 않은 아이디 입니다.');
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