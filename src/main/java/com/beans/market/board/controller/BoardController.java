package com.beans.market.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beans.market.board.service.BoardService;


@Controller
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService boardSevice;
	
	//
	@RequestMapping(value="/")
	public String home() {
		logger.info("TEST");
		
		int cnt = boardSevice.connectTest();
		
		if (cnt > 0) {
			logger.info("DB 접속 성공");
		} else {
			logger.info("DB 접속 실패");
		}
		
		return "detail";
	}
	
	//윤경배 테스트
	@RequestMapping(value="/yuntest")
	public String yuntest() {
		logger.info("yun testing");
		return "yuntesting";
		
	}
	

}
