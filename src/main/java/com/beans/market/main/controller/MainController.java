package com.beans.market.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beans.market.main.service.MainService;

@Controller
public class MainController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired MainService mainService;
	
	@RequestMapping(value="/")
	public String main() {
		logger.info("메인 페이지...");
		
		return "main";
	}
	

}
