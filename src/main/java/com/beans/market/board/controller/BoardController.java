package com.beans.market.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.beans.market.board.service.BoardService;
import com.beans.market.photo.service.PhotoService;

@Controller
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService boardSevice;
	@Autowired PhotoService photoService;
	

	// goodsDetail로 이동
	@RequestMapping(value="/goodsDetail.go", method = RequestMethod.GET)
	public String goodsDetailGo(Model model, int idx) {
		logger.info("{} 디테일로 이동", idx);
		int option_idx = 1;

		boardSevice.goodsDetail(idx, model);
		photoService.boardPhoto(idx, model, option_idx);
		
		return "board/saleOfGoodsDetail";
	}

}
