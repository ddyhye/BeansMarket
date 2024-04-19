<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
	table {
        border-collapse: separate;
        border-spacing: 0;
        border: 2px solid gray;
        border-radius: 10px;
        overflow: hidden;
        text-align: center;
    }
    .inline-field {
        display: inline;
        margin-right: 5px;
    }    
</style>
</head>

<body>
	<form>
		<h3>Beans.ID등록확인</h3>
		<table>
			<tr>
   				 <th colspan = "2">ID(Email) :</th>
   				 <td> <input type="text" name="find">
						 <input type="button" value="확인" onclick="overlay()" />
				</td>
			</tr>
		</table>
	</form>
</body>

<script>
	var overChk=false;
	var msg = '${msg}'; // 쿼터 빠지면 넣은 문구가 변수로 인식됨.
	if(msg != ''){
		alert(msg);
}
	function overlay(){
		var id =$('input[name="find"]').val();	
		$.ajax({
			type:'post',            //metjod 방식
			url:'overlay.do',          //요청할 주소
			data:{'id':id},             // 파라메터
			success:function(data){ //통신 성공시
				console.log(data);
				if(data.use >0){
					alert('등록된 아이디 입니다.');
					$('input[name="id"]').val('');
				}else{
				 alert('등록되지 않은아이디 입니다.');	
				 overChk=true;
				}
			},
			error:function(error){
				console.log(error);	
			}
		});
	}
</script>
</html>