package com.beans.market.board.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public String goodsDetailGo(Model model, Integer idx) {
		logger.info("{} 디테일로 이동", idx);
		int option_idx = 1; // 게시글이라는 의미
		String page = "redirect:/";
		if(idx != null) {
			page = boardSevice.goodsDetail(idx, model);
			photoService.boardPhoto(idx, model, option_idx);						
		}
		
		return page;
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

	// 관심 목록 추가 및 삭제
	@RequestMapping(value = "/remaingTime.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> remaingTime(String close_date){
		logger.info("remaingTime.do close_date : {}", close_date);
		Map<String, Object> map = new HashMap<String, Object>();
		
		LocalDateTime currentTime = LocalDateTime.now();

        // 비교할 특정 시간 설정하기
        LocalDateTime specificTime = LocalDateTime.parse(close_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // 현재 시간과 특정 시간 사이의 차이 계산하기
        long remaingTime = ChronoUnit.SECONDS.between(currentTime, specificTime);
		
        logger.info("남은 시간 : {}", remaingTime);

		map.put("remaingTime", remaingTime);
		return map;
	}	
	
}
