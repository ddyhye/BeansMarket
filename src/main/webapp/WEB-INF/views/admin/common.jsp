<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"href="<c:url value='/resources/css/admin_top.css'/>" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>

<body>
	<div class="left-header">
	     <div class="mark">
	         <p>BEANS</p>
	     </div>
	     <div class="pageName">
	         <p class="head-p">회원 관리</p> 
	     </div>
	 </div>
	 <div class="right-header">
	     <div class="adminName">
	         <p class="head-p">관리자 명</p><!-- 세션으로 받아서 회원관리처럼 이름 변경 -->
	     </div>
	     <div class="alarm-icon">
	         <i class="fa-solid fa-bell"></i>
	         <div class="unRead2"></div>
	     </div>
	     <div>
	     	<button class="logout"><i class="fa-solid fa-right-from-bracket"></i></button>
	     </div>
	 </div>
	 
	 <div class="alarmForm" id="alarmForm">
		<h2>알림 내용</h2>
		<div id="alarmList">
			<div class="alarm">
				<p class = alarm-content>알림 관련 내용을 여기에 표시합니다.</p>	
				<p class = alarm-reg-date>시간</p>
			</div>
		</div>
	 </div>
</body>
 
<script>
	var pageName = '${pageName}';
	if (pageName != '') {
		$('.pageName p').text(pageName);	
	}

	var loginInfo = '${adLoginInfo}';
	if (loginInfo != ''){
		$('.adminName p').text('${adLoginInfo.admin_name}');
	}
	
	 newAlarm();
	
	// 로그인 체크
	function loginCheck() {
	    var login = true;
	    if('${adLoginInfo}' == ''){
	        alert('로그인이 필요한 서비스 입니다.');
	        location.href='<c:url value="/admin/"/>';
	        login = false;
	    }
	    return login;
	}
	 
	$('.logout').click(function(){
		location.href="<c:url value='/admin/logout.do'/>";
	});
  	
  	// 알림 아이콘 클릭시 - 확인
  	$('.alarm-icon').click(function() {
		$.ajax({
            type:'POST',
            url:'./adminAlarm.ajax',
            data:{
                // 넣을 데이터가 없음
            },
            dataType:'JSON',
            success:function(data){
            	//alert(data.list);
            	//alert(data.inquiryCnt);
            	//alert(data.reportCnt);
				drawAlarmList(data);
            },
            error:function(error){
                console.log(error);
            }
        });
		$('#alarmForm').toggle(); // 알람 폼의 표시/숨김을 토글합니다.
	});
  	
  	function drawAlarmList(data) {
		$('#alarmList').empty();
		
		var content = '';
		
		if (data.inquiryCnt != 0) {
			content += '<div class="alarm" data-value="inquiryManage">'
			content += 	'<p class = alarm-content>현재 미처리 문의 : '+data.inquiryCnt+ '</p>';
			content += '</div>'
		}
		
		if (data.reportCnt != 0) {
			content += '<div class="alarm" data-value="report">'
			content += 	'<p class = "alarm-content">현재 미처리 신고 : '+data.reportCnt+ '</p>';
			content += '</div>'
		}
		
		if (!data.list || data.list.length === 0) {
			content += '<p> 알림이 없습니다. </p>';
		}
		
		var cnt = 0;
		for (item of data.list) {
			content += '<div class="alarm" data-value="' +item.link+ '">';
			content += 	'<p class = "alarm-content">'+item.content+'</p>';	
			content += 	'<p class = "alarm-reg-date">'+DateToString(item.reg_date)+'</p>';
			content += 	'<p class = "alarm-checked" style="display: none;">'+item.checked+'</p>';
			content += 	'<p class = "alarm-idx" style="display: none;">'+item.idx+'</p>';
			content += '</div>';
			
			cnt++;
		}
		
		$('#alarmList').append(content);
		
		$(document).ready(function(){
		    $(".alarm").click(function(event){
		    	readAlarm(event);
		    	window.location.href = "<c:url value='/admin/"+$(this).data("value")+".go'/>";
		    });
		});
	
		$('.alarm-checked:contains("Y")').parent().css('background-color', 'lightgray');
  	}
  	
	// timestamp 형식인 거 문자열로 변환하는 함수
	function DateToString(timesteamp){
		var date = new Date(timesteamp);
		var dateStr = date.toLocaleDateString("ko-KR");
		return dateStr;
	}
	
	// timestamp 형식인 거 문자열로 변환하는 함수
	function formatDate(num) {
	    return ('0' + num).slice(-2);
	}
	function DateToStringTime(timesteamp) {
	    var date = new Date(timesteamp);
	    var year = date.getFullYear();
	    var month = formatDate(date.getMonth() + 1); // getMonth()는 0부터 시작하므로 1을 더함
	    var day = formatDate(date.getDate());
	    var hours = formatDate(date.getHours());
	    var minutes = formatDate(date.getMinutes());
	    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
	}
	
	// 알림 읽기 처리
	function readAlarm(event){
		var idx = $(event.target).closest('.alarm').find('.alarm-idx').text();
		if(idx != ''){
			$.ajax({
				type: 'GET',
				url:'./adminAlarmRead.ajax',
				data: {
					'idx': idx
				},
				dataType: 'JSON',
				success: function(data) {
					// 딱히 없음
				},
				error : function(error) {
				}
			});
		}
	}

	// 새로운 알림 표시
	function newAlarm() {
		$.ajax({
			type: 'GET',
			url: './adminNewAlarm.ajax',
			data: {},
			dataType: 'JSON',
			success: function(data){
				if (data.newAlarm > 0 || data.inquiryCnt > 0 || data.reportCnt > 0) {
					$('.unRead2').addClass('active');
				} else {
					$('.unRead2').removeClass('active');
				}
			}, error: function(data){}
		});
	}
  		
</script>
</html>