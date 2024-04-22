<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>BEANS-${bbs.subject}</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
<link rel="stylesheet" href="../resources/css/goodsDetail.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>
<body>
	<header>
	    <jsp:include page="../common.jsp"/>
	</header>
    <section>
        <div class="container">
            <div class="goods-detail">
                <div class="left">
                    <div class="picture">
                        <img class="goodsImg" src="/photo/${photos[0].new_picname}" alt="goodsImage"/>
                        <div class="controller">
                            <button class="prev"><i class="fa-solid fa-arrow-left"></i></button>
                            <button class="next"><i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                    </div>
                    <div class="select-pic">
                    </div><!-- 사진 선택 공간 -->
                </div>
                <div class="right">
                    <div class="top">
                    	<p class="bbs-state">${bbs.bbs_state}</p>
                        <button class="reportBtn">신고하기</button> 
                    </div>
                    <div class="profile">
                        <div class="left">
                            <img src="/photo/${sellerPic.new_filename}" alt="profileImage"/>
                        </div>
                        <div class="right">
                            <p class="user_name">${sellerInfo.name}</p>
                            <div class="reivew">
                            	<p><i class="fa-solid fa-thumbs-up"></i> ${sellerInfo.positiveCount}</p>
                                <p><i class="fa-solid fa-thumbs-down"></i> ${sellerInfo.negativeCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="subject">
                        <p>${bbs.subject}</p>
                        <div class="icon">
                        	<!-- 로그인 관련해서 완성되면 회원만 가능하다는 알림 -->
                            <!-- <i class="fa-solid fa-heart"></i> -->
                            <button class="interest"><i class="fa-regular fa-heart"></i></button><!-- 빈 하트 -->
                        </div>
                    </div>
                    <hr/>
                    <div class="bid-price">
                        <p class="price">현재 입찰가 ${bbs.price}원 (시작가 : ${bbs.start_price}원)</p>
                        <p class="successful-bid">즉시 구매가 ${bbs.successful_bid}원</p>
                    </div>
                    <hr/>
                    <div class="bid-info">
                        <div class="bid-count">
                            <p>입찰수</p>
                            <p>${bbs.bid_count} 회</p>
                        </div>
                        <div class="time">
                            <p>남은시간 </p>
                            <p class="remaing-time">123456</p>
                            <p>(종료 : ${close_date})</p>
                        </div>
                    </div>
                    <hr/>
                    <p class="place">거래 희망 장소 : ${bbs.place}</p>
                    <p class="reg-date">등록일 : ${reg_date}</p>
                    <div class="btn">
                        <button id="bid">입찰하기</button>
                        <button id="buy">구매하기</button>
                    </div>
                </div>
            </div><!--goods-detail 종료-->
            <hr/>
            <br/>
            <div class="goods-content">
            	<h2>상품 설명</h2>
            	<br/>
            	<p>${bbs.content}</p>
               	<c:forEach items="${photos}" var="photo">
					<img src="/photo/${photo.new_picname}"/>
					<br/>				
				</c:forEach>
            </div>
            <div id="reportForm">
                <div class="form">
                    <div class="option">
                        <p>신고 분류</p>
                        <select id="report_option" name="category_idx">
                            <option value="r001">도배</option>
                            <option value="r002">욕설</option>
                            <option value="r003">성희롱</option>
                        </select>
                    </div>
                    <div class="content">
                        <p>신고 사유를 입력해주세요</p>
                        <textarea name="content"></textarea>
                    </div>
                    <input type="hidden" name="option_idx" value="RB001">
                    <div class="btn-controller">
                        <button class="ok" onclick="report()">확인</button>
                        <button type="button" class="reportBtn">취소</button>
                    </div>
                </div>
            </div><!--reportForm 종료-->
            <div id="bidForm">
	            <div class="top">
	                <button class="escape"><i class="fa-solid fa-x"></i></button>
	            </div>
	            <div class="bid-subject">
	                <p>${bbs.subject} - 입찰 페이지</p>
	            </div>
	            <hr/>
	            <div class="bidForm-price">
	                <div>
	                 <p class="title">현재 입찰가</p>
	                    <p class="current">${bbs.price}</p>
	                    <p>원</p>
	                    <p class="start-price">(시작가 : ${bbs.start_price}원)</p>
	                </div>                    
	                <div>
	                    <p class="title">입찰 가능가</p>
	                    <p id="bid-able">00000</p>
	                    <p>원</p>
	                </div>  
	                <div>
	                    <p class="title">즉시 구매가</p>
	                    <p>${bbs.successful_bid}</p>
	                    <p>원</p>
	                </div>
	                <br/>
	                <div>
	                    <p class="title">나의 빈즈페이</p>
	                    <p id=remain-pay>${loginInfo.point}</p>
	                    <p>원</p>
	                    <input type="button" value="충전하기" />
	                </div>
	            </div>
	            <hr/>
	            <div class="bidForm-info">
	                <p>* 입찰 가능가 부터 입찰 가능합니다.</p>
	                <p>* 입찰은 1,000원 단위로만 가능합니다.</p>
	                <p>* 입찰할 금액만큼 나의 빈즈페이 잔액이 있어야 합니다.</p>
	            </div>
	            <div class="bid-input">
	                <p>입찰가 입력</p>
	                <input type="text" id="bid-price"/>
	                <input type="button" id="bid-btn" value="입찰하기" />
	            </div>
	            <div id="bid-msg">
	                <div class="top">
	                    <button class="escape"><i class="fa-solid fa-x"></i></button>
	                </div>
	                <p class="head">정상적으로 입찰 되었습니다.</p>
	                <br/>
	                <p class="content">'마이페이지 > 경매 > 나의 입찰' 을 확인해주세요</p>
	            </div>
            </div> <!-- bidForm 종료 -->
        </div> <!-- container 종료 -->
    </section>
</body>
<script>
    var picCount = 0;     // 현재 사진이 몇번째 사진인지
	var bbsIdx = '${bbs.idx}'; // String으로 들어오는거 주의
	var bbsEmail = '${bbs.email}';
    var close_date = '${close_date}';
    
    runEverySecond();
    
    // 특정 게시물 모든 사진 이름 받아오기
    var photoArray = [];
    $('.goods-content img').each(function() {
        photoArray.push($(this).attr('src'));
    });

    // 사진 밑에 점
    for (var photo_idx = 0;  photo_idx < '${photos.size()}'; photo_idx++) {
        $('.select-pic').append(photo_idx == 0 ? '<button class="select" onclick="photoChange('+photo_idx+')"></button>' : '<button class="unselect" onclick="photoChange('+photo_idx+')"></button>');        
    }
	
    // select-pic 의 버튼을 누르면 사진이 바뀌게
    function photoChange(photo_idx) {
        $('.goodsImg').attr('src', photoArray[photo_idx]);
        $('.select').removeClass('select').addClass('unselect');
        $('.select-pic button').eq(photo_idx).removeClass('unselect').addClass('select');
	}
    
    // 사진 이동 버튼 표시
    $('.goods-detail .left').hover(function(){
        $('.next').show();
        $('.prev').show();
    });

    // 사진 이동 버튼 제거
    $('.goods-detail .left').mouseleave(function(){
        $('.next').hide();
        $('.prev').hide();
    });

    // 다음 버튼 클릭 시
    $('.next').click(function() {        
        var curSelect = $('.select');

        if(picCount == $('.select-pic button').length-1){
            curSelect.removeClass('select').addClass('unselect');
            $('.select-pic button').first().removeClass('unselect').addClass('select');
            picCount = 0;
            $('.goodsImg').attr('src', photoArray[picCount]);
            return;
        }
        picCount++;
        curSelect.removeClass('select').addClass('unselect');
        curSelect.next().removeClass('unselect').addClass('select');
        $('.goodsImg').attr('src', photoArray[picCount]);
    });

    // 이전 버튼 클릭 시
    $('.prev').click(function() {        
        var curSelect = $('.select');

        if(picCount == 0){
            curSelect.removeClass('select').addClass('unselect');
            $('.select-pic button').last().removeClass('unselect').addClass('select');
            picCount = $('.select-pic button').length-1;
            $('.goodsImg').attr('src', photoArray[picCount]);
            return;
        }
        picCount--;
        curSelect.removeClass('select').addClass('unselect');
        curSelect.prev().removeClass('unselect').addClass('select');
        $('.goodsImg').attr('src', photoArray[picCount]);
    });

    // 판매 상태에 따른 CSS 변경
    $(document).ready(function() {
        var bbs_state = '${bbs.bbs_state}';
        bbsState(bbs_state);
    });

    function bbsState(bbs_state){
        console.log(bbs_state);
        if (bbs_state == '거래완료') {
            $('.bbs-state').css({'background-color':'gray'});
        } else if (bbs_state == '예약중'){
            $('.bbs-state').css({'background-color':'lightgreen'});
        }
    }

    // 로그인을 안했으면 alert 창 출력 후 로그인으로 이동 - 체크는 서버 측에서도 한번더 하면 좋을거 같음
    function loginCheck() {
        var login = true;
        if('${loginInfo}' == ''){
            alert('로그인이 필요한 서비스 입니다.');
            location.href="./login.go";
            login = false;
        }
        return login;
    }

    // 관심 목록 추가 및 삭제 - 회원
    $('.icon').click(function(){
    	if(loginCheck()){
            var i = $('.icon i');
            if(i.attr('class') == 'fa-regular fa-heart'){
                i.removeClass('fa-regular fa-heart').addClass('fa-solid fa-heart');
                interest(i.attr('class'));
            } else if(i.attr('class') == 'fa-solid fa-heart'){
                i.removeClass('fa-solid fa-heart').addClass('fa-regular fa-heart');
                interest(i.attr('class'));
            }
        }
    });

    // 관심목록 ajax - 회원
    function interest(className){
		$.ajax({
			type:'GET',
			url:'./interest.ajax',
			data:{
				'className':className,
				'bbsIdx':bbsIdx,
			},
			dataType:'JSON',
			success:function(data){
				console.log(data.result);
			},
			error:function(error){
				console.log(error);
			}
		});
	}

    // 신고 버튼 클릭 시 - 회원
    $('.reportBtn').click(function(){
        if(loginCheck()){
            $('#reportForm').toggle();
        }
    });

    // 신고 ajax - 회원
    function report(){
		var category_idx = $('select[name="category_idx"]').val();
        var content = $('textarea[name="content"]').val();
        var option_idx = $('input[name="option_idx"]').val();
        
        console.log(category_idx, content, option_idx, bbsEmail, bbsIdx);
        
		$.ajax({
			type:'POST',
			url:'../report/report.do',
			data:{
                'category_idx':category_idx,
                'content':content,
                'option_idx':option_idx,
                'perpet_email':bbsEmail,
                'idx':bbsIdx
            },
            dataType:'JSON',
			success:function(data){
				$('#reportForm').toggle();
				alert(data.msg);
			}, 
			error:function(error){
				console.log(error);
			} 
		});
    }

    // 남은시간 계산 - auction
    function runEverySecond() {
        $.ajax({
            type:'GET',
            url:'./remaingTime.ajax',
            data:{
                'close_date':close_date
            },
            dataType:'JSON',
            success:function(data){
                var remaingTime = data.remaingTime
                var days = Math.floor(remaingTime / (24 * 60 * 60));
                remaingTime %= (24 * 60 * 60);
                var hours = Math.floor(remaingTime / (60 * 60));
                remaingTime %= (60 * 60);
                var minutes = Math.floor(remaingTime / 60);
                var seconds = remaingTime % 60;
                if (remaingTime < 0) {
                    $('.remaing-time').text("종료").css({'color':'red'});
                } else {
                    // console.log(days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초");
                    $('.remaing-time').text(days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초");
                }
            },
            error:function(error){
                console.log(error);
            }
        });
    }
    setInterval(runEverySecond, 1000);

    // 입찰창 띄우기 - auction
    $('.btn button').click(function(){ 
        if (loginCheck()) {
            $('#bidForm').show();
            var bid_able = parseInt('${bbs.price}')+1000;
            $('#bid-able').text(bid_able);
            if($(this).attr('id') == 'buy') {
                $('.bid-input input[type="text"]').val('${bbs.successful_bid}');
            } else {
                $('.bid-input input[type="text"]').val(bid_able);
            }
        }  
    });

    // 입찰창 및 모달창 닫기
    $('.escape').click(function() {
        $(this).closest('.top').parent().hide();
    });

    // 입찰하기
    $('#bid-btn').click(function(){
        $.ajax({
            type:'POST',
            url:'./bidding.ajax',
            data:{
                'bid_price' : $('#bid-price').val(),
                'bbsIdx' : bbsIdx
            },
            dataType:'JSON',
            success:function(data){
                if(!data.result){
                	console.log(data.content);
                    $('#bid-msg .head').text("입찰에 실패 했습니다.");
                    $('#bid-msg .content').text(data.content);
                }
            },
            error:function(error){
                console.log(error);
            }
        });
    });
    
</script>
</html>
