// 카테고리 펼침/닫힘
$('.top-second-left-head').on('mouseenter', function() {
    $('.top-second-left-body').addClass('active');
});
$('.top-second-left-border').on('mouseleave', function() {
    $('.top-second-left-body').removeClass('active');
});

// 고객센터 펼침/닫힘
$('#top-second-center-down').on('mouseenter', function() {
    $('.top-second-center-body').addClass('active');
});
$('.top-second-center-parent').on('mouseleave', function() {
    $('.top-second-center-body').removeClass('active');
});

// 고객서비스 펼침/닫힘
$('.top-second-right-border-bottom-icon').on('click', function() {
    // 요소의 토글 상태를 저장
    var isToggled = $(this).data('toggled');
    // .top-second-right-border를 변수에 저장
    var borderDiv = $('.top-second-right-border');

    if (isToggled) {
        $(this).attr('src','../html/detailIcon.png');
        borderDiv.css('height', '150%');
        borderDiv.find('.memberService').remove();
    } else {
        $(this).attr('src','../html/reverseDetailIcon.png');
        borderDiv.css('height', '600%');
        borderDiv.append('<div class="memberService"><a href="">마이페이지</a></div>');
        borderDiv.append('<div class="memberService"><a href="">관심</a></div>');
        borderDiv.append('<div class="memberService"><a href="">물품팔기</a></div>');
        borderDiv.append('<div class="memberService"><a href="">판매리스트</a></div>');
        borderDiv.append('<div class="memberService"><a href="">최근 본 물품</a></div>');
    }
    
    // 요소의 토글 업데이트
    $(this).data('toggled', !isToggled);
});


// 알림
$('#alarmIcon').on('click', function() {
    $('.alarm').addClass('active');
});
$('#deleteBtn').on('click', function() {
    $('.alarm').removeClass('active');
});