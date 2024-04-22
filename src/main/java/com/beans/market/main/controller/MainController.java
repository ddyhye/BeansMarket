package com.beans.market.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.board.service.BoardService;
import com.beans.market.main.service.MainService;
import com.beans.market.photo.dto.PhotoDTO;

@Controller
public class MainController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired MainService mainService;
	@Autowired BoardService boardService;
	
	@RequestMapping(value="/")
	public String main(Model model) {
		logger.info("메인 페이지...");
		
		mainService.goodsList(model);
		
		return "main";
	}
	// AJAX 리스트 출력
	@RequestMapping(value="/list.ajax")
	@ResponseBody
	public Map<String, Object> listAjax(String selectedSort, String sellOptionChk, String AuctionOptionChk){
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean isSell = sellOptionChk.equals("true")? true : false;
		boolean isAuction = AuctionOptionChk.equals("true")? true : false;
		
		//mainService.goodsListAjax(map);
		mainService.goodsListAjax(map, selectedSort, isSell, isAuction);
		
		return map;
	}
	
	
	// 물품 팔기 페이지 이동
	@RequestMapping(value="/goodsWrite.go")
	public String goodsWrite_go() {
		logger.info("메인 페이지...");
		
		return "board/saleOfGoodsWrite";
	}

}
