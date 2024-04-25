package com.beans.market.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.beans.market.admin.service.QuestionService;

@Controller
public class QuestionController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired QuestionService questionService;
	
	//1:1 문의하기 페이지
	@RequestMapping(value="/question")
	public String question() {
		logger.info("question 페이지 요청");
		return "customerService/inquire";
	}
	
	@RequestMapping(value="/question.ajax")
	@ResponseBody
	public Map<String, Object> questionList(String page) {
		logger.info("questionList 요청");
		logger.info("요청페이지 : " + page);
		int currPage = Integer.parseInt(page);
		int pagePerCnt = 10;
		Map<String, Object> map = questionService.list(currPage, pagePerCnt);
		return map;
	}
	
	
	//상세보기
	@RequestMapping(value="/question.detail")
	public String questionDetail() {
		logger.info("questionDetail 페이지 요청");
		return "customerService/inquireDetail";
	}
	
	//문의 작성 폼
	@RequestMapping(value="/questionForm")
	public String questionGo() {
		logger.info("questionForm 페이지 요청");
		return "customerService/inquireWrite";
	}
	
	@RequestMapping(value="/question/write", method = RequestMethod.POST)
    public String questionWrite (MultipartFile photos, HttpSession session, @RequestParam Map<String, String> param) {
        logger.info("문의 글 작성");
        logger.info("param : {} " , param);
        String page = "redirect:/question";
        
        if(session.getAttribute("loginId")!=null) {
        	int row = questionService.write(photos, param);
        	if(row<1) {
        		page= "questionForm";
        	}
        }
        return page;
}
}
