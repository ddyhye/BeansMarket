<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/profile.css" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
</style>
</head>

<body>
	<jsp:include page="profileCommon.jsp" />
		<div class="main">
			<div class="main-top">
				<div class="main-top-profilePic">
					<img src="/photo/${new_filename}" />
				</div>
				<div class="main-top-profileNic">
					<h2>${name}</h2>
				</div>
				<div class="main-top-profileUpdate">
					<a href="<c:url value='/member/profileUpdate.go'/>"><p>프로필 수정</p></a>
				</div>
			</div>

			<div class="main-center">
				<div class="main-center-first">
					<div class="main-center-first-head">
						<h3>나의 매너</h3>
					</div>
					<div class="main-center-first-body">
						<i class="fa-regular fa-face-laugh-squint"></i>
						<p>&nbsp;23(이거쪽지이후)&nbsp;&nbsp;&nbsp;&nbsp;</p>
						<i class="fa-regular fa-face-rolling-eyes"></i>
						<p>&nbsp;4(쪽지)</p>
					</div>
				</div>
				<div class="main-center-second">
					<div class="main-center-second-head">
						<h3>나의 정보</h3>
					</div>
					<div class="main-center-second-body">
						<table>
							<tr>
								<td>&nbsp;&nbsp;EMAIL</td>
								<td>&nbsp;&nbsp;${email}</td>
							</tr>
							<tr>
								<td>&nbsp;&nbsp;NICNAME</td>
								<td>&nbsp;&nbsp;${name}&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;&nbsp;ADRESS</td>
								<td>&nbsp;&nbsp;${location}&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;&nbsp;BIRTHDAY&nbsp;&nbsp;</td>
								<td>&nbsp;&nbsp;${birth_date}</td>
							</tr>
							<tr>
								<td>&nbsp;&nbsp;GENDER</td>
								<td>&nbsp;&nbsp;${gender}</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="main-center-third">
					<div class="main-center-third-head">
						<h3>Beans Pay</h3>
					</div>
					<div class="main-center-third-body">
						<p>${point} $(페이이후)&nbsp;&nbsp;</p>
						<i class="fa-solid fa-circle-dollar-to-slot"></i>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script>
/*
	$.ajax({
		type: 'get',
		url: './profile.ajax',
		data: {},
		dataType: 'JSON',
		success: function(data) {
			
		}, error: function(data){}
	});

	function drawProfile(data) {
		$('.main').empty();
		
		var content = '';
		
		for (item of data.list) {
			content += '<div class="main-top">';
			content += '<div class="main-top-profilePic">';
			content += '<img src="/photo/ahruru.png" />';
			content += '</div>';
			content += '<div class="main-top-profileNic">';
			content += '<h2>아루루</h2>';
			content += '</div>';
			content += '<div class="main-top-profileUpdate">';
			content += '<p>프로필 수정</p>';
			content += '</div></div>';
			content += '<div class="main-center">';
			content += '<div class="main-center-first">';
			content += '<div class="main-center-first-head">';
			content += '<h3>나의 매너</h3>';
			content += '</div>';
			content += '<div class="main-center-first-body">';
			content += '<i class="fa-regular fa-face-laugh-squint"></i>';
			content += '<p>&nbsp;23&nbsp;&nbsp;&nbsp;&nbsp;</p>';
			content += '<i class="fa-regular fa-face-rolling-eyes"></i>';
			content += '<p>&nbsp;4</p>';
			content += '</div></div>';
			content += '<div class="main-center-second">';
			content += '<div class="main-center-second-head">';
			content += '<h3>나의 정보</h3>';
			content += '</div>';
			content += '<div class="main-center-second-body">';
			content += '<table>';
			content += '<tr><td>&nbsp;&nbsp;EMAIL</td><td>&nbsp;&nbsp;ahruru@email.com</td></tr>';
			content += '<tr><td>&nbsp;&nbsp;NICNAME</td><td>&nbsp;&nbsp;아루루&nbsp;&nbsp;</td></tr>';
			content += '<tr><td>&nbsp;&nbsp;ADRESS</td><td>&nbsp;&nbsp;경기도 광명시 광명동&nbsp;&nbsp;</td></tr>';
			content += '<tr><td>&nbsp;&nbsp;BIRTHDAY&nbsp;&nbsp;</td><td>&nbsp;&nbsp;1999. 09. 12.</td></tr>';
			content += '<tr><td>&nbsp;&nbsp;GENDER</td><td>&nbsp;&nbsp;남자</td></tr>';
			content += '</table>';
			content += '</div></div>';
			content += '<div class="main-center-third">';
			content += '<div class="main-center-third-head">';
			content += '<h3>Beans Pay</h3>';
			content += '</div>';
			content += '<div class="main-center-third-body">';
			content += '<p>500,200 $&nbsp;&nbsp;</p>';
			content += '<i class="fa-solid fa-circle-dollar-to-slot"></i>';
			content += '</div></div></div>';
		}
		
		$('.main').append(content);
	}*/

</script>
</html>