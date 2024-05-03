<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/category.css" type="text/css"/>
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
			<div class="category-top">
				<button onclick="categoryInsert()">카테고리 추가</button>
			</div>
			
			<div class="container">
				<table id="category-table">
	                <thead>
	                    <tr>
	                        <th>카테고리 번호</th>
	                        <th>카테고리 명</th>
	                    </tr>
	                </thead>
	                <tbody id="category-list"></tbody>
	            </table>
				
				<form action="categorySave.do" id="category-controller" method="POST">
					<div id="category-idx">
						<p>카테고리 번호</p>
						<input type="text" name="idx" readonly>
					</div>
					
					<div id="category-name">
						<p>카테고리 명</p>
						<input type="text" name="name">
					</div>
					
					<div id="category-state">
						<p>공개 여부</p>
						<span>공개</span><input type="radio" name="hidden" value="N">
						<span>비공개</span><input type="radio" name="hidden" value="Y">
					</div>
					
					<div class="category-bottom">
						<input type="submit" class="save-btn" value="저장하기">
					</div>
				</form>
			</div>
			
		<form id="categoryInsert" action="categoryInsert.do" method="POST">
			<div class="form">
				<h3>카테고리 추가</h3>
				<p>카테고리 번호</p>			
				<input type="text" name="idx">
				<p>카테고리 명</p>			
				<input type="text" name="name">
				<div class="btn-controller">
					<input type="submit" class="insert-btn" value="확인">
					<input type="button" class="cancel-btn" onclick="categoryInsert()" value="취소"/>	
				</div>
			</div>	
		</form><!--categoryInsert 종료-->
		</section>
	</main>
</body>

<script>
var msg = '${msg}';
if(msg != ''){
	alert(msg);
}

categoryCall();

function categoryCall(){
	if(loginCheck()){
		$.ajax({
			type:'GET',
			url:'./categoryCall.ajax',
			data:{},
			dataType:'JSON',
			success:function(data){
				if (data.result) {
					categoryDraw(data.list);			
				}
			},
			error:function(error){
				console.log(error);
			}
		});
	}
}
function categoryDraw(list){
	var content = '';
	
    for (item of list) {
        var color = item.hidden === 'Y' ? 'lightgray' : '';
        content +='<tr onclick="categoryDetail(event)" data-value=\''+JSON.stringify(item)+'\' style="color: '+color+';">';
        content +=        '<td>'+item.category_idx+'</td>';
        content +=        '<td>'+item.category_name+'</td>';
        content +='</tr>';
    }

    $('#category-list').html(content);
	
	$(document).ready(function(){
	    $('tr').hover(
	        function(){
	            $(this).css('background-color', 'lightgray');
	        },
	        function(){
	            $(this).css('background-color', '');
	        }
	    );
	});
}

function categoryDetail(event) {
	$('.save-btn').show();
	
	var data = $(event.target).closest('tr').data("value");
	
	$('#category-idx input[type="text"]').val(data.category_idx);
	$('#category-name input[type="text"]').val(data.category_name);
	
	if (data.hidden === 'N') {
        $('input[name="hidden"][value="N"]').prop('checked', true);
    } else if (data.hidden === 'Y') {
        $('input[name="hidden"][value="Y"]').prop('checked', true);
    }
}


function categoryInsert() {
	$('#categoryInsert').toggle();
	$('#categoryInsert input[type="text"]').val('');
}


</script>
</html>