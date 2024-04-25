<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원차단</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="resources/css/detail.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    body, html {
        height: 100%;
        margin: 0;
        display: flex;
        align-items: center;
    }
    section {
        text-align: left; /* 텍스트 중앙 정렬 */
        width: 400px; /* 원하는 너비 설정 */
    }
    
    button {
        position: absolute;
        right: 400px;
        top: 300px;    
    }   
    
    .profile-info {
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
    }

    .profile-info dl, .profile-info p {
        margin-right: 10px; /* 오른쪽 여백 */
    }

    .profile-info p {
        display: flex; /* flex를 사용하여 아이콘과 숫자가 한 줄에 배열 */
        align-items: center; /* 아이콘과 숫자를 세로 중앙 정렬 */
    }

</style>
</head>

<body>
	  
	  <jsp:include page="../common.jsp"/>
	<section>
	<img class="profile" src="/photo/${new_filename}">
	<span>다른 회원 프로필</span>
		<div class="profile-info">
		<dl>
			<dt>긍정 / 부정</dt>
		</dl>
		<p><i class="fa-solid fa-thumbs-up"></i> ${sellerInfo.positiveCount}</p>
		<p><i class="fa-solid fa-thumbs-down"></i> ${sellerInfo.negativeCount}</p>
		<dl>
		<dt>판매중인 물품</dt>		
		</dl>
		</div>
		<div class="main-content">
		<div class="main-content-goods">
    <div class="goods-container">
        <div class="goods-image">
            <img src="../resources/img/checked.png" alt="상품 이미지"/>
            <img src="../resources/img/unHeart.png" class="clickHeart" alt="찜"/>
        </div>
        <div class="goods-details">
            <div class="goods-title">
                <p>상품 제목</p>
            </div>
            <div class="goods-price">
                <span>현재가</span>
                <span class="Price">450,000</span>
            </div>
            <div class="goods-buttons">
                <!-- 추가 버튼 등을 여기에 추가할 수 있어요 -->
            </div>
        </div>
    </div>
</div>
		</div>
		<button>차단하기</button>	
	</section>

</body>	

<script>
	//차단하기
	$(document).ready(function() {
	    // URL에서 사용자 ID 추출
	    var urlParams = new URLSearchParams(window.location.search);
	    var userId = urlParams.get('userId');
	    
	    $('button').click(function() {
	        var email = '${email}'; // 현재 로그인한 사용자의 아이디
	        
	        $.ajax({
	            url: '/report/ban.do', 
	            type: 'POST',
	            data: { loggedInUserEmail: email, blockedUserId: userId },
	            success: function(response) {
	                alert('사용자가 차단되었습니다.');
	            },
	            error: function() {
	                alert('차단 과정에 문제가 발생했습니다.');
	            }
	        });
	    });
	    
	    listCall(); // 페이지 로드 후 리스트 호출
	});
	
	//회원값리스트 출력하기
	function listCall() {
		$.ajax({
			type: 'post',
			url: 'otherlist.ajax',
			data: {
				'email': 'zxz0608@naver.com'
			},
			dataType: 'JSON',
			success: function(data) {
				console.log(data);
 				drawGoodsList(data);
			}, 
			error: function(error) {
				console.log(error);
			}
		});
	}
	
	// 리스트 그리기
function drawGoodsList(data) {
    $('.main-content').empty();

    var content = '';

    if (!data.list || data.list.length === 0) {
        content += '<p> 판매중인 상품이 없습니다. </p>';
    } else {
        for (item of data.list) {
            content += '<div class="main-content-goods-wrapper">'; // 각 게시물을 감싸는 div 추가
            content += '<div class="main-content-goods'+(item.bbs_state === '거래완료' ? ' sold-out' : '')+'">';
            content += '<div class="goods-idx" style="display: none;">'+item.idx+'</div>';
            content += '<div class="goods-top">';
            content += '<div class="goods-top-left"><p>&nbsp;&nbsp;'+item.sellerName+'</p></div>';
            content += '<div class="goods-top-right">';

            var mark = item.bbs_state === '거래완료'? '<div class="goods-top-right-mark1"><span>Sold Out</span></div>': (item.option === '경매'? '<div class="goods-top-right-mark2"><span>경매</span></div>':'');
            content += mark;

            content += '</div></div>';
            content += '<div class="goods-photo">';
            content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
            var heart_img_path = item.mine == 1? '<c:url value="/resources/img/heart.png"/>': '<c:url value="/resources/img/unHeart.png"/>';
            content += '<img src="'+heart_img_path+'" class="clickHeart" alt="찜"/></div>';
            content += '<div class="goods-subject"><span>'+item.subject+'</span></div>';
            content += '<div class="goods-price-1">';
            content += '<div class="goods-price-1-left">';
            content += '<span>&nbsp;&nbsp;현재가&nbsp;&nbsp;</span><span id="Price">'+item.price+'</span></div>';
            content += '<div class="goods-price-1-right"><span>❤</span><span class="Hit">&nbsp;'+item.heartCnt+'&nbsp;&nbsp;</span></div>';
            content += '</div>';
            content += '<div class="goods-price-2">';
            content += item.option == '경매'? '<span>&nbsp;&nbsp;즉구가&nbsp;&nbsp;</span><span class="highPrice">'+item.successful_bid+'</span>':'';
            content += '</div>';
            content += '<div class="goods-bottom">';
            content += '<div class="goods-bottom-left">';
            content += item.option == '경매'? '<span>&nbsp;&nbsp;입찰 &nbsp;&nbsp;</span><span class="Cnt">0&nbsp;</span></div>':'</div>';
            content += '<div class="goods-bottom-right">';
            content += '<span>'+item.reg_date+'&nbsp;</span>';
            content += '</div></div></div>'; // 감싸는 div 닫기
        }
    }

    $('.main-content').append(content);
}
</script>
</html>