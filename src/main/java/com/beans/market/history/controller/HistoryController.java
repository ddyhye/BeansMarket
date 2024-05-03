package com.beans.market.history.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.history.service.HistoryService;

@Controller
public class HistoryController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired HistoryService historyService;
	
	// 게시글을 토대로 출력 - 성영
	@RequestMapping(value="/history/historyList.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> historyList(HttpSession session, String searchText, String option) {
		logger.info("검색 내용 : {}, 히스토리 옵션 {}", searchText, option);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("adLoginInfo") != null) {
			map = historyService.historyList(searchText, option);			
		}
		
	
		return map;
	}
	
}
