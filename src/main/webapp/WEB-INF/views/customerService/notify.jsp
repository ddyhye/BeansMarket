<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../resources/css/common.css" type="text/css"/>
    <link rel="stylesheet" href="../resources/css/detail.css" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
    <style>
             section {
            height: 100%;
            margin-top: 125px;
            padding: 20px;
            border-radius: 10px;
        }

        h3 {
        	margin-top: 30px;
            margin-left: 100px;
            font-size: 28px;
            color: #333;
        }

        hr {
            width: 90%;
            margin: 0 auto;
            border-width: 2px;
            border-color: #ddd;
        }

        .notify-list {
            margin: 0 auto;
            width: 90%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding: 20px;
        }

        .notify-list:last-child {
            border-bottom: none;
        }

        .notify-list-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .notify-list-name {
            font-size: 14px;
            color: #777;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .notify-list-mark1 {
            background-color: red;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
            display: inline-block;
        }

        .notify-list-mark1 span {
            font-weight: bold;
        }

        .notify-list-date {
            font-size: 14px;
            color: #777;
            display: flex;
            align-items: center;
        }

        .notify-list-date span {
            margin-right: 10px;
        }

        p {
            font-size: 18px;
            color: #777;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common.jsp"/>
    <section>
        <h3>공지사항</h3>
        <hr>
        <div class="notify"></div>
        <div id="pagination"></div> <!-- 페이징을 표시할 곳 -->
        <select id="pagePerNum">
            <option value="5">5개씩 보기</option>
            <option value="10">10개씩 보기</option>
            <option value="20">20개씩 보기</option>
        </select> <!-- 페이지당 보여줄 게시물 수 선택 -->
    </section>

    <script>
    var showPage = 1; // 현재 페이지를 저장할 변수

    $(document).ready(function() {
        // 페이지당 게시물 수 변경 시
	$('#pagePerNum').on('change', function() {
	    $('#pagination').twbsPagination('destroy');
	    questionList(showPage);
	});
        listCall(1); // 페이지가 로드되면 자동으로 첫 번째 페이지의 공지사항을 불러옵니다.
    });

    function listCall(pageNumber) {
        console.log('공지사항 리스트 출력');
        $.ajax({
            type: 'GET',
            url: 'notifyList.ajax',
            data: { 
                page: pageNumber, // 수정: 쉼표 추가
                'cnt': $('#pagePerNum').val()
            },
            dataType: 'JSON',
            success: function(data) {
                console.log('공지사항 리스트 출력 성공');
                drawnotifyList(data); // 공지사항 목록을 그리는 함수 호출
                var startPage = data.currPage > data.totalPages ? data.totalPages : data.currPage;
                $('#pagination').twbsPagination({
                	startPage: startPage, // 시작페이지
                    totalPages: data.totalPages, // 전체 페이지 수
                    visiblePages: 5, // 보여줄 페이지 수
                    onPageClick: function(event, page) {
                        showPage = page; // 페이지를 클릭할 때마다 현재 페이지 업데이트
                        listCall(page); // 선택한 페이지의 공지사항을 불러옴
                    	drawnotifyList(page);
                    }
                });
            },
            error: function(error) {
                console.log('공지사항 리스트 출력 실패:', error);
            }
        });
    }

        function drawnotifyList(data){
            $('.notify').empty();
            var content = '';
            if(!data.list || data.list.length === 0) {
                content += '<p>현재 공지사항이 없습니다.</p>';
            } else {
                for(let item of data.list){
                    content += '<div class="notify-list">';
                    content += '<div class="notify-list-idx" style="display:none;">' + item.notice_idx + '</div>';
                    content += (item.notice_option ? '<div class="notify-list-mark1"><span>' + item.notice_option + '</span></div>' : '');

                    content += '<div class="notify-list-title">' + (item.notice_option ? '' : '일반') + item.notice_title + '</div>';
                    content += '<div class="notify-list-name">' + item.admin_name + '</div>';
    
                    content += '<div class="notify-list-date">';
                    var date = new Date(item.notice_date);
                    var dateStr = date.toLocaleDateString("ko-KR", { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\./g, '').replace(/\s/g, '. ') + '.';            
                    content += '<span>' + dateStr + '</span>';
                    content += '<div class="notify-list-nhit">' + item.nHit + '</div>';
                    content += '</div>';
                    content += '</div>';
                }
            }
            $('.notify').append(content);
     	}
        
    </script>
</body>
</html>