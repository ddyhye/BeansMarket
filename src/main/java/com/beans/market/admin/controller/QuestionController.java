package com.beans.market.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QuestionController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	
	//1:1 문의하기 페이지
	@RequestMapping(value="/question")
	public String question() {
		logger.info("question 페이지 요청");
		return "customerService/inquire";
	}
	
	
	//상세보기
	@RequestMapping(value="/question.detail")
	public String questionDetail() {
		logger.info("questionDeatil 페이지 요청");
		return "customerService/inquireDetail";
	}
	
	//문의 작성 폼
	@RequestMapping(value="/question.do")
	public String questionDo() {
		logger.info("questionDo 페이지 요청");
		return "customerService/inquireDetail";
	}
}
