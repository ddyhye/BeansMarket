com.beans.market<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <section>
        <div class="container">
            <div class="goods-detail">
                <div class="left">
                    <div class="picture">
                        <img src="resources/img/image.png" alt="goodsImage"/>
                    </div>
                    <div class="controller">
                        <button class="prev">이전</button>
                        <button class="next">다음</button>
                    </div>
                    <div class="select-pic">
                        <button class="select"></button>
                        <button class="unselect"></button>
                        <button class="unselect"></button>
                    </div>
                </div>
                <div class="right">
                    <div class="profile">
                        <div class="left">
                            <img src="resources/img/image.png" alt="profileImage"/>
                        </div>
                        <div class="right">
                            <p class="user_name">이름</p>
                            <p class="reivew">거래 후기</p>
                        </div>
                    </div>
                    <p class="subject">제목</p>
                    <p class="price">가격</p>
                    <hr/>
                    <p class="place">거래 희망 장소</p>
                    <p class="reg-date">등록일</p>
                    <button>쪽지 보내기</button>       
                </div>
            </div>
            <br/>
            <br/>
            
            <hr/>
            <br/>
            <div class="goods-content">
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Id laborum ipsa eum ratione ea consequatur voluptas distinctio assumenda voluptate? Saepe et enim expedita officiis ipsam sed voluptatum deserunt? Voluptatibus nulla expedita ad recusandae dolores totam repellat, voluptatum fuga nobis veniam!</p>
            </div>
        </div>
    </section>
</body>
<script>
</script>
</html>