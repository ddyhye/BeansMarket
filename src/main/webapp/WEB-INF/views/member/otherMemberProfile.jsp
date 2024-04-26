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
        /* css 기본 초기화 */
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
       	
       	.main-content {
		    display: flex;
		    flex-wrap: wrap;
		    justify-content: space-between;
		}
		
		.main-content-goods {
		    width: calc(25% - 12.5px); /* 4개의 요소를 한 줄에 배치하므로, 너비를 25%로 설정하고 간격을 조절합니다. */
		    margin-bottom: 25px; /* 게시글 아래 간격 조절 */
		}
       	
        li{
            list-style: none;
        }
        .container {
            position: relative;
            top: 13%;
            width: 1300px;
            margin: 0 auto;    
        }
        /* 수정된 스타일 */
        section {
            text-align: left; /* 텍스트 중앙 정렬 */
            max-width: 70%; /* 최대 너비 설정 */
            width: 100%; /* 너비 100%로 설정 */
            padding: 20px; /* 내부 여백 추가 */
            margin: 125px auto 0; /* 가운데 정렬 */
        }
        .profile-info {
			max-width: 80%;
		    width: 70%;
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    margin: 20px auto;
		    padding: 0px 20px 40px;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		}
        .profile-info img.profile {
            margin-bottom: -40px;
            width: 160px; /* 프로필 이미지 크기 설정 */
            height: 160px;
            border-radius: 50%; /* 프로필 이미지를 원형으로 */
        }
        .profile-info dl {
            margin-right: 20px; /* 오른쪽 여백 조정 */
        }
          .profile-info dt {
            argin-right: 20px;
		    margin-left: -270;
		    margin-top: 40px;
		    padding-bottom: 60px;
		    text-align: center;
		    font-size: 25px;
        }
        .profile-info p {
            margin-left: -220px;
     
        }
		 .mine-top {
		   display: flex;
		
		   position: relative;
		   width: 100%;
		   height: 80px;
		   margin: 20px auto;
		}
		.mine-top p {
		   display: flex;
		   align-items: center;
		   justify-content: center;
		
			position: relative;
		
			color: rgb(68, 68, 68);
		   font-size: 25px;
		}
		.mine-top #nic {
			margin-left: 40px;
			font-weight: bold;
		}
		
		
		.mine-center  {
			display: flex;
			align-items: flex-start;
			justify-content: flex-start;
			flex-wrap: wrap;
			
			position: relative;
			width: 90%;
			margin: 0 auto;
		}
		.mine-center-goods {
			display: flex;
		   	flex-direction: column;
		   	
		   	position: relative;
			width: 217px;
			height: 280px;
			border: 2px solid lightgray;
			margin: 12.5px;
		}
		.sold-out {
			opacity: 0.4;
		}
		.goods-top {
		   display: flex;
		   flex-direction: row;
		
		   position: relative;
		   height: 10%;
		}
		.goods-top-left {
		   display: flex;
		   align-items: center;
		   justify-content: flex-start; 
		
		   position: relative;
		   width: 65%;
		}
		.goods-top-right {
		   display: flex;
		   align-items: center; 
		   justify-content: flex-end;
		
		   position: relative;
		   width: 35%;
		}
		.goods-top-right-mark1 {
		   position: relative;
		   width: 80px;
		   height: 25px;
		   text-align: center;
		
		   background-color: #97001b;
		   border-left: 2px solid #97001b;
		   border-top: 2px solid #97001b;
		   border-bottom: 2px solid #97001b;
		   
		   opacity: 1;
		}
		.goods-top-right-mark1 span{
		   color: white;
		   font-weight: bold;
		}
		.goods-top-right-mark2 {
		   position: relative;
		   width: 60px;
		   height: 25px;
		   text-align: center;
		
		   background-color: pink;
		   border-left: 2px solid lightgray;
		   border-top: 2px solid lightgray;
		   border-bottom: 2px solid lightgray;
		}
		.goods-top-right-mark2 span{
		   font-weight: bold;
		}
		.goods-photo {
		   display: flex;
		   align-items:center;
		   justify-content: center;
		
		   position: relative;
		   height: 200px;
		}
		.goods-photo img {
		   position: relative;
		   width: 90%;
		   height: 95%;
		}
		.goods-photo img:last-child {
		   position: absolute;
		   width: 22%;
		   height: auto; 
		   right: 5%;
		   bottom: 5%; 
		   z-index: 1;
		}
		.goods-subject {
		   display: flex;
		   align-items: center;
		   justify-content: center;
		   text-align: center;
		   vertical-align: center;
		
		   position: relative;
		   height: 15%;
		}
		.goods-subject span {
		   position: relative;
		   width: 90%;
		   font-size: 15px;
		   font-weight: bold;
		}
		.goods-price {
		   display: flex;
		   align-items: center;
		   justify-content: center;
		   flex-direction: row;
		
		   position: relative;
		   height: 13%;
		}
		.Price {
		   font-weight: bold;
		}
        button {
            margin-bottom: -170px; /* 버튼과의 간격 조정 */
            margin-right: 10px;
            padding: 10px 20px; /* 버튼 내부 여백 설정 */
            background-color: gray; /* 배경색 설정 */
            color: #fff; /* 텍스트 색상 설정 */
            border: none; /* 테두리 없애기 */	
            border-radius: 5px; /* 테두리 반경 설정 */
            cursor: pointer; /* 마우스 커서 설정 */
            transition: background-color 0.3s; /* 배경색 변경 애니메이션 설정 */
        }
        button:hover {
            background-color: #0056b3; /* 호버 시 배경색 변경 */
        }
        
    </style>
</head>
<body>
    <jsp:include page="../common.jsp"/>
    <section>
        <div class="profile-info">
            <img class="profile" src="/photo/${photo}">
            <div class= "class">
            <div class="goods-top-left">
					</div>
            	<dl>
				<dt>닉네임: ${sellerInfo.name}</dt> 
            	</dl>
         <p>긍정적인 평가 :<i class="fa-solid fa-thumbs-up"></i>&nbsp;( ${sellerInfo.positiveCount} )</p>
         <p>부정적인평가 :<i class="fa-solid fa-thumbs-down"></i> &nbsp;( ${sellerInfo.negativeCount} )</p>
         	
            </div>
            <button>차단하기</button>
        </div>
        <div class="main-content">
            <c:forEach items="${listdata}" var="item">
                <div class="main-content-goods">
                    <div class="goods-container">
                        <!-- 상품 이미지와 정보 표시 -->
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</body>
<script>
    $(document).ready(function() {
    	
    
    // 차단하기 버튼 클릭 시의 동작
	 $('button').click(function() {
	    // 현재 페이지의 URL을 가져옵니다.
	    var currentUrl = window.location.href;
	    // URL에서 쿼리 문자열을 가져옵니다.
	    var queryString = window.location.search;
	    // 쿼리 문자열에서 파라미터를 추출합니다.
	    var urlParams = new URLSearchParams(queryString);
	    // email 파라미터 값을 가져옵니다.
	    var email = urlParams.get('email');
	    console.log(email); // 출력: "zxz0608@naver.com"
	
	    $.ajax({
	        url: '/report/ban.do', 
	        type: 'post',
	        data: { email: email }, // 파라미터 이름을 email로 변경
	        success: function(response) {
	            console.log(email);
	            alert('사용자가 차단되었습니다.');
	        },
	        error: function() {
	            alert('차단 과정에 문제가 발생했습니다.');
	        }
	    });
	});
        
        listCall(); // 페이지 로드 후 리스트 호출
    });
    
    
    
    
    // 회원값 리스트 출력하기
    function listCall() {

        $.ajax({
            type: 'post',
            url: 'otherlist.ajax',
            data: {
                'email': 'zxz0608@naver.com',
                'sellerInfo': 'sellerInfo',
     
                
                	
            },
            dataType: 'JSON',
            success: function(data) {
            	
                var photo = data.photo;
                console.log(photo);
                console.log(data);
                drawGoodsList(data);
            }, 
            error: function(error) {
                console.log(error);
            }
        });
    }
    
    // 리스트 그리기 함수
    function drawGoodsList(data) {
        $('.main-content').empty();

        var content = '';

        if (!data.listdata || data.listdata.length === 0) {
            content += '<p> 판매중인 상품이 없습니다. </p>';
        } else {
            for (item of data.listdata) {
    			content += '<div class="mine-center-goods'+(item.bbs_state === '거래완료' ? ' sold-out' : '')+'">';
    			content += '<div class="goods-idx" style="display: none;">'+item.idx+'</div>';
    			content += '<div class="goods-top">';
    			content += '<div class="goods-top-left">';
    			content += '<p>&nbsp;'+item.sellerName+'</p></div>';
    			content += '<div class="goods-top-right">';
    			var mark = item.bbs_state === '거래완료'? '<div class="goods-top-right-mark1"><span>Sold Out</span></div>': (item.option === '경매'? '<div class="goods-top-right-mark2"><span>경매</span></div>':'');
    			content += mark;
    			content += '</div></div>';
    			content += '<div class="goods-photo">';
    			content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
    			var heart_img_path = item.mine == 1? '<c:url value="/resources/img/heart.png"/>': '<c:url value="/resources/img/unHeart.png"/>';
    			content += '<img src="'+heart_img_path+'" class="clickHeart" alt="찜"/></div>';
    			content += '<div class="goods-subject">';
    			content += '<span>'+item.subject+'</span>';
    			content += '</div>';
    			content += '<div class="goods-price">';
    			content += '<span class="Price">'+item.price+'</span>';
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
    			content += '</div></div></div>';
            }
        }

        $('.main-content').append(content);
    }
    
	// 고객서비스 - 관심물품 등록/삭제
	$('.main-content').on('click', '.clickHeart', function(event) {
		// 이벤트 버블링 방지 (하트 누를 때 게시글 이동 방비)
		event.stopPropagation();
		
		var idx = $(this).closest('.main-content-goods').find('.goods-idx').text();
		var currImg = $(this).attr('src');
		
		var isHearted = currImg.includes('heart.png');
		var isToggled = !isHearted
		
		// 사진 및 토글 상태 업데이트
		var newImg = isToggled ? '<c:url value="/resources/img/heart.png"/>':'<c:url value="/resources/img/unHeart.png"/>';
		$(this).attr('src', newImg);
		$(this).data('toggled', isToggled);
		
		$.ajax({
			type: 'get',
			url: './clickHeart.ajax',
			data: {
				'idx': idx,
				'isToggled': isToggled
			},
			dataType: 'JSON',
			success: function(data) {
				if (data.msg != '') {
					alert(data.msg);
				}
			}, error: function(error) {
			}
		});
	});
	// 고객서비스 - 최근 본 물품 추가하기 && 게시글 디테일 보기
	$('.main-content').on('click', '.main-content-goods', function() {
		var idx = $(this).find('.goods-idx').text().trim();
		
		// 세션 스토리지에 저장된 idx 목록 불러오기 (없으면 말고)
		var currIdxArr = sessionStorage.getItem('recentLookIdx');
		currIdxArr = currIdxArr ? JSON.parse(currIdxArr) : [];
		
		// 방금 본 게시글이 최근 본 목록에 있으면 세션 기록에서 삭제
		var idxPosition = currIdxArr.indexOf(idx);
		if (idxPosition > -1) {
			currIdxArr.splice(idxPosition, 1);
		}
		
		currIdxArr.unshift(idx);
		
		if (currIdxArr.length > 9) {
			currIdxArr.pop();
		}
		
		sessionStorage.setItem('recentLookIdx', JSON.stringify(currIdxArr));
		
		// 남은 자리수가 있다면,9까지 0으로 채우기
	    while (currIdxArr.length < 9) {
	        currIdxArr.push(0);
	    }
	    
	   	// 게시글 디테일로 이동
	   	window.location.href = '<c:url value="/board/detail.go?idx='+idx+'"/>';
	});
	
	
</script>
</html>