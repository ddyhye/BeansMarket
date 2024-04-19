package com.beans.market.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	// report
	@RequestMapping(value="/report.do", method = RequestMethod.POST)
	public String reportDo(Model model, @RequestParam Map<String, String> map) {
		logger.info("{} 번 게시글 신고", map.get("idx"));
		logger.info("{}", map);
		
		return "redirect:/";
	}
	
	// 관심 목록 추가 및 삭제
	@RequestMapping(value = "/interest.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> interestToggle(String className, String bbsIdx){
		logger.info("interestToggle.do className : {}, bbsIdx : {}", className, bbsIdx);
		Map<String, Object> map = new HashMap<String, Object>();
		String result = boardSevice.interestToggle(className, Integer.parseInt(bbsIdx));
		map.put("result", result);
		return map;
	}

}
