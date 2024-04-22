
	// 최신순, 인기순 select-option
	var selectedSort = $('#main-subject-sort').val();
	$('#main-subject-sort').change(function() {
		selectedSort = $(this).val();
		
		listCall(selectedSort, sellOptionChk, AuctionOptionChk);
	});
	
	// 판매, 경매 checkbox
	var sellOptionChk = $('#saleOption1').is(':checked');
	var AuctionOptionChk = $('#saleOption2').is(':checked');
	$('.sellOption-checkbox').change(function() {
		sellOptionChk = $('#saleOption1').is(':checked');
		AuctionOptionChk = $('#saleOption2').is(':checked');
		
	    listCall(selectedSort, sellOptionChk, AuctionOptionChk);
	});
	
	// 물품 리스트 출력
	function listCall(selectedSort, sellOptionChk, AuctionOptionChk) {
		console.log('click!!!');
		$.ajax({
			type: 'get',
			url: './list.ajax',
			data: {
				'selectedSort': selectedSort,
				'sellOptionChk': sellOptionChk,
				'AuctionOptionChk': AuctionOptionChk
			},
			dataType: 'JSON',
			success: function(data) {
				drawGoodsList(data);
			}, error: function(error) {
				console.log(error);
			}
		});
	}
	// drawList 함수 : 물품 그리기
	function drawGoodsList(data) {
		$('.main-content').empty();
		
		var content = '';
		
		if (data.list == null) {
			content += '<p> 판매중인 상품이 없습니다. </p>';
		}
		for (item of data.list) {
			content += '<div class="main-content-goods'+(item.bbs_state === '거래완료' ? ' sold-out' : '')+'">';
			content += '<div class="goods-idx" style="display: none;">'+item.idx+'</div>';
			content += '<div class="goods-top">';
			content += '<div class="goods-top-left"><p>'+item.sellerName+'</p></div>';
			content += '<div class="goods-top-right">';
			
			var mark = item.bbs_state == '거래완료'? '<div class="goods-top-right-mark1"><span>Sold Out</span></div>': (item.option == '경매'? '<div class="goods-top-right-mark2"><span>경매</span></div>':'');
			content += mark;
			
			content += '</div></div>';
			content += '<div class="goods-photo">';
			content += '<img src="/photo/'+item.new_picname+'" alt="'+item.new_picname+'"/>';
			var heart_img_path = item.mine == 1? 'heart.png': 'unHeart.png';
			content += '<img src="resources/img/'+heart_img_path+'" class="clickHeart" alt="찜"/></div>';
			content += '<div class="goods-subject"><span>'+item.subject+'</span></div>';
			content += '<div class="goods-price-1">';
			content += '<div class="goods-price-1-left">';
			content += '<span>&nbsp;현재가&nbsp;&nbsp;</span><span id="Price">'+item.price+'</span></div>';
			content += '<div class="goods-price-1-right"><span>❤</span><span class="Hit">&nbsp;'+item.heartCnt+'&nbsp;</span></div>';
			content += '</div>';
			content += '<div class="goods-price-2">';
			content += item.option == '경매'? '<span>&nbsp;즉구가&nbsp;&nbsp;</span><span class="highPrice">'+item.successful_bid+'</span>':'';
			content += '</div>';
			content += '<div class="goods-bottom">';
			content += '<div class="goods-bottom-left">';
			content += item.option == '경매'? '<span>&nbsp;입찰 &nbsp;&nbsp;</span><span class="Cnt">0</span></div>':'</div>';
			content += '<div class="goods-bottom-right">';
			content += '<span>'+item.reg_date+'&nbsp;</span>';
			content += '</div></div></div>';
		}
		
		$('.main-content').append(content);
	}
	
	
	
	// 관심물품 등록/삭제
	$('.main-content').on('click', '.clickHeart', function() {
		var idx = $(this).closest('.main-content-goods').find('.goods-idx').text();
		var currImg = $(this).attr('src');
		
		var isHearted = currImg.includes('heart.png');
		var isToggled = !isHearted
		
		// 사진 및 토글 상태 업데이트
		var newImg = isToggled ? 'heart.png':'unHeart.png';
		$(this).attr('src', 'resources/img/'+newImg);
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