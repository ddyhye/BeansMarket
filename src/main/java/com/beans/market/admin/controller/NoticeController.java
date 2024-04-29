package com.beans.market.admin.controller;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.admin.dto.NoticeDTO;
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
	
	//공지사항 디테일
	@RequestMapping(value="customerService/notifyDetail.go")
	public String noticedetail(String notice_idx, Model model) {
		logger.info("상세페이지요청");
		
		noticeService.increaseHitCount(notice_idx);
		
		NoticeDTO detail = noticeService.detail(notice_idx);
		model.addAttribute("noticedetail", detail);
		logger.info("detail : "+detail);
		
		return "customerService/notifyDetail";
		
	}
	
	//공지사항 검색
	@RequestMapping(value="searchByTitle.ajax")
	@ResponseBody
	public Map<String, Object> noticeSearch(HttpSession session, String textval, @RequestParam("page") String page){
		Map<String, Object>map = new HashMap<String,Object>();
		
		noticeService.noticesearch(map, textval);
		
	
		return map;
	}
	
	
}
