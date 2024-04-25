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
            max-width: 800px; /* 최대 너비 설정 */
            width: 100%; /* 너비 100%로 설정 */
            padding: 20px; /* 내부 여백 추가 */
            margin: 125px auto 0; /* 가운데 정렬 */
        }
        .profile-info {
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
            justify-content: space-between; /* 요소 사이 간격을 최대로 벌리기 */
            margin-bottom: 20px; /* 하단 여백 추가 */
            padding: 20px 20px 100px; /* 내부 여백 추가 */
            border: 1px solid #ddd; /* 테두리 추가 */
            border-radius: 5px; /* 테두리 반경 설정 */
        }
        .profile-info img.profile {
            width: 130px; /* 프로필 이미지 크기 설정 */
            height: 130px;
            border-radius: 50%; /* 프로필 이미지를 원형으로 */
        }
        .profile-info dl {
            margin-right: 20px; /* 오른쪽 여백 조정 */
        }
        .profile-info p {
            display: flex; /* flex를 사용하여 아이콘과 숫자가 한 줄에 배열 */
            align-items: center; /* 아이콘과 숫자를 세로 중앙 정렬 */
           inline-block;
        }
        .main-content {
            display: flex;
            flex-wrap: wrap; /* 아이템을 여러 줄에 걸쳐 표시 */
            gap: 20px; /* 아이템 간의 간격 설정 */
        }
        .main-content-goods {
            width: calc(33.33% - 20px); /* 아이템 너비 설정 */
            border: 1px solid #ddd; /* 테두리 추가 */
            padding: 20px; /* 내부 여백 추가 */
            border-radius: 5px; /* 테두리 반경 설정 */
            transition: box-shadow 0.3s; /* 그림자 변경 애니메이션 설정 */
        }
        .main-content-goods:hover {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 호버 시 그림자 추가 */
        }
        .main-content-goods img {
            max-width: 100%; /* 이미지 최대 너비 설정 */
            height: auto; /* 이미지 높이 자동 조정 */
        }
        button {
            margin-top: 20px; /* 버튼과의 간격 조정 */
            padding: 10px 20px; /* 버튼 내부 여백 설정 */
            background-color: #007bff; /* 배경색 설정 */
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
						<p>${sellerInfo.name}</p> 
					</div>
            	<dl>
            	<dt>긍정&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 부정</dt>
            	</dl>
         <p><i class="fa-solid fa-thumbs-up"></i>&nbsp;( ${sellerInfo.positiveCount} ) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-thumbs-down"></i> &nbsp;( ${sellerInfo.negativeCount} )</p>
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
            var email = '${email}'; // 현재 로그인한 사용자의 이메일
            var userId = '${userId}'; // 차단할 사용자의 아이디
            
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