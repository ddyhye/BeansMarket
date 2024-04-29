<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="resources/css/common.css" type="text/css" />
<link rel="stylesheet" href="resources/css/detail.css" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
/* Your custom styles here */
	body {
		font-family: Arial, sans-serif;
		background-color: #f8f8f8;
		margin: 0;
		padding: 0;
	}
	
	section {
		margin-top: 125px;
		height: 100%;
		padding: 20px;
		background-color: #fff;
		border-radius: 10px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	
	.container {
		margin: 0 auto;
		width: 90%;
	}
	
	.option-container {
		display: flex;
		align-items: center;
		margin-bottom: 10px;
	}
	
	.option {
		margin-top: 15px;
		font-size: 14px;
		font-weight: bold;
		padding: 4px 6px;
		border-radius: 4px;
		display: inline-block;
		margin-right: 10px;
	}
	
	.title {
		font-size: 24px;
		font-weight: bold;
		color: #333;
		margin-top: 20px;
	}
	
	.info {
		margin-top: 10px;
		font-size: 14px;
		color: #777;
	}
	
	.info div {
		margin-bottom: 5px;
	}
	
	.content {
		margin-top: 20px;
		font-size: 16px;
		color: #555;
		line-height: 1.6;
	}
	
	.back-button {
		background-color: gray;
		color: #fff;
		padding: 10px 20px;
		border-radius: 5px;
		text-decoration: none;
		display: inline-block;
		margin-bottom: 20px;
		border: none;
		cursor: pointer;
		margin-left: 70px;
	}
	
	.back-button i {
		margin-right: 1px;
	}
	
	.back-button:hover {
		background-color: #555;
	}
	
	hr {
		margin: 0 auto;
		width: 100%;
		text-align: center; /* 수평선 가운데 정렬 */
	}
</style>
</head>
<body>
	<jsp:include page="../common.jsp" />
	<section>
		<button class="back-button">
			<i class="fas fa-arrow-left"></i>
		</button>
		<div class="container">
			<hr>
			<div class="option-container">
				<div class="option">${noticedetail.notice_option}</div>
				<div class="title">${noticedetail.notice_title}</div>
			</div>
			<div class="info">
				<div>작성자 : ${noticedetail.admin_name}</div>
				<div>작성일 : ${noticedetail.notice_date}</div>
				<div>조회수 : ${noticedetail.nHit}</div>
			</div>
			<div>
				<hr>
			</div>
			<div class="content">${noticedetail.notice_content}</div>
		</div>
		<div></div>
	</section>

	<script>
        $(document).ready(function() {
            $(".back-button").click(function() {
                window.location.href = "/main/notify.go"; // 컨트롤러 경로로 변경
            });

            var option = "${noticedetail.notice_option}";

            if (option === "일반") {
                $(".option").css("background-color", "orange");
                $(".option").css("color", "white");
            } else if (option === "필독") {
                $(".option").css("background-color", "red");
                $(".option").css("color", "white");
            }
        });
    </script>
</body>
</html>