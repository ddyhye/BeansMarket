<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css" type="text/css"/>
<style>

.container {
    margin: 0 auto;
    width: 1300px;  /*수정필요 1*/
  position: absolute;
  top: 50%;
  left: 60%;
  transform: translate(-50%, -50%); /* 정확한 중앙 정렬을 위해 */
}

table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}

th, td {
    padding: 5px 10px;
}


.pagination {
  display: flex;
  list-style: none;
  padding: 0;
  justify-content: center;
}

.page-item {
  margin: 0 2px;
}

.page-link {
  display: block;
  padding: 5px 10px;
  color: #007bff;
  text-decoration: none;
}

/* 버튼 스타일 */
.button {
    background-color: #4CAF50; /* 배경색 */
    color: white; /* 글꼴 색상 */
    padding: 12px 20px; /* 패딩 */
    border: none; /* 테두리 없음 */
    border-radius: 4px; /* 모서리 둥글게 */
    cursor: pointer; /* 마우스 오버 시 커서 변경 */
    margin-top: 10px; /* 상단 여백 */
}

/* 마우스 오버 시 버튼 스타일 */
.button:hover {
    background-color: #45a049;
}

</style>

</head>

<body>
	<jsp:include page="../common.jsp" />
		<div class="container">
		<!--  여기 안에서 작업하기 -->
<h3 style="display: inline-block;">1:1 문의하기</h3>
<button class="button" onclick="location.href='questionForm'">문의하기</button>

<table>
    <thead>

        <tr>
            <th>글번호</th>
            <th style="width:70%">제목</th>
            <th>작성자</th>
            <th>등록 날짜</th>
        </tr>
    </thead>
    <tbody id="list"></tbody>
    <tr>
        <td colspan="4">
            <div class="pagination-container">
                <nav aria-label="Page navigation" style="text-align:center">
                    <ul class="pagination" id="pagination"></ul>
                </nav>
            </div>
        </td>
    </tr>
</table>

<select name="state" class="form-state" aria-label="Default select example">
	<option value="title">제목</option>
	<option value="titleNcontent">제목 + 내용</option>
</select>
<input id="searchInput"  type="text" placeholder="검색" >
<button id="searchButton"  style="height: 20px;">검색</button>
		
		
		
		</div>



</body>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script>

var showPage = 1;

$(document).ready(function() { 
    // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
    questionList(showPage);
    $("#searchButton").click(function() {
        getSearchList(); // 검색 함수 호출
    });
});

$('#pagePerNum').on('change', function() {
    // 페이지당 보여줄 게시물의 숫자를 변경하면 전체 페이지 수의 변화가 생기므로
    // 페이징 처리 객체를 파괴하고 다시 만들도록 해야 한다.
    $('#pagination').twbsPagination('destroy');
    questionList(showPage);
});

function questionList(page) {
    $.ajax({
        type: 'get',
        url: './question.ajax',
        data: {
            'page': page,
            'cnt': $('#pagePerNum').val()
        },
        dataType: 'json',
        success: function(data) {
            drawList(data.list);
            console.log(data);
            // 플러그인 추가
            var startPage = data.currPage > data.totalPages ? data.totalPages : data.currPage;
            $('#pagination').twbsPagination({
                startPage: startPage, // 시작페이지
                totalPages: data.totalPages, // 총 페이지 갯수
                visiblePages: 5, // 보여줄 페이지 수 [1][2][3][4][5]
                onPageClick: function(evt, pg) { // 페이지 클릭시 실행 함수
                    console.log(evt);//이벤트 객체
                    console.log(pg);//클릭한 페이지 번호
                    showPage = pg;
                    questionList(pg);
                }
            });
        },
        error: function(error) {
            console.log(error);
        }
    });
}

function drawList(list) {
    var content = '';
    for (item of list) {
        content += '<tr>';
        content += '<td>' + item.inquiry_idx + '</td>';
        content += '<td>' + item.inquiry_title + '</td>';
        content += '<td>' + item.enquirer +'</td>';
        var date = new Date(item.reg_date);
        var dateStr = date.toLocaleDateString("ko-KR"); //en-US
        content += '<td>' + dateStr + '</td>';
        content += '</tr>';
    }
    $('#list').html(content);
}


function getSearchList() {
    $.ajax({
        type: 'GET',
        url: "/questionSearch.ajax",
        data:{
        	'type': $("select[name='state']").val(),
        	'keyword': $("#searchInput").val()
        },
        dataType: "json",
        success: function(result) {       

        }

    })
}





</script>

</html>