package com.beans.market.admin.controller;



import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.admin.service.NoticeService;

@Controller
public class NoticeController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired NoticeService noticeService;
	
	//공지사항으로 가보자
	@RequestMapping(value="/notify.go")
	public String notifygo() {
		logger.info("공지사항 페이지 요청");
		
		return "customerService/notify";
	}
	
	//공지사항 불러오기
	@RequestMapping(value="notifyList.ajax")
	@ResponseBody
	public Map<String, Object> notifyList(@RequestParam("page") String page) {
	    logger.info("notifyList 요청");
	    int currPage = Integer.parseInt(page);
	    int pagePerCnt = 10;
	    return noticeService.list(currPage, pagePerCnt);
	}
	
	
}
