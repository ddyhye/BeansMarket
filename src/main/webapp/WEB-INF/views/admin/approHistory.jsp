<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/history.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<header>
		<jsp:include page="./common.jsp"/>
	</header>
	<main>
		<jsp:include page="./nav.jsp"/>
		<section>
			<div class="content-search">
				<p>검색</p>
				<div class="search-box" data-value="deal_approv_hist">
					<input type="text" name="search-val" id="subject-search" placeholder="이메일 혹은 게시글 번호를 입력해주세요" />
					<button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
				</div>
			</div>

            <table id="approve-hist-box">
                <thead>
                    <tr>
                        <th>글 번호</th>
                        <th>등록 일시</th>
                        <th>승인 회원</th>
                    </tr>
                </thead>
                <tbody id="approve-hist-result"></tbody>
            </table>

		</section>
	</main>
</body>

<script>
historyCall('', 'deal_approv_hist');

$(".search-btn").click(function(event) {
	var searchText = $(this).closest('.search-box').find('input[type="text"]').val();
    var option = $(event.target).closest('.search-box').data("value");

    historyCall(searchText, option);
});

function historyCall(searchText, option){
	if(loginCheck()){
		$.ajax({
			type:'GET',
			url:'<c:url value="/history/historyList.ajax"/>',
			data:{
				"searchText" : searchText,
				"option" : option
			},
			dataType:'JSON',
			success:function(data){
				if (data.result) {
					historyDraw(data.list);			
				}
			},
			error:function(error){
				console.log(error);
			}
		});
	}
}

function historyDraw(list){
	var content = '';
	
	for (item of list) {
		content +='<tr>';
		content +=		'<td>'+item.idx+'</td>';
		content +=		'<td>'+DateToStringTime(item.reg_date)+'</td>';
		content +=		'<td>'+item.email+'</td>';
		content +='</tr>';
	}

	$('#approve-hist-result').html(content);
	
	$(document).ready(function(){
	    $('tr').hover(
	        function(){
	            $(this).css('background-color', 'lightgray');
	        },
	        function(){
	            $(this).css('background-color', ''); // 마우스가 벗어나면 원래 색상으로 돌아갑니다.
	        }
	    );
	});
}
</script>
</html>