package com.beans.market.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.board.service.BoardService;
import com.beans.market.main.service.MainService;

@Controller
public class MainController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired MainService mainService;
	@Autowired BoardService boardService;
	
	@RequestMapping(value="/")
	public String main() {
		logger.info("메인 페이지...");
		
		return "main";
	}
	
	@RequestMapping(value="/main")
	public String main2() {
		logger.info("메인 페이지...");
		
		BoardDTO dto = mainService.goodsList();
		logger.info("판매자: "+dto.getEmail());
		logger.info("게시글 옵션: "+dto.getOption());
		logger.info("제목: "+dto.getSubject());
		logger.info("가격: "+dto.getPrice());
		
		return "main";
	}
	

}
